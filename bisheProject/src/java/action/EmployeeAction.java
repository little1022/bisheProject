package action;

import com.opensymphony.xwork2.ActionSupport;
import model.Employee;
import model.Hsalon;
import model.UserinfoEntity;
import model.Wait;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import service.EmployeeService;
import service.TitleService;
import service.UserService;
import utils.CommonUtils;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller("employeeAction")
@Scope("prototype")
public class EmployeeAction extends ActionSupport {
    private Employee employee;
    @Resource
    private EmployeeService employeeService;
    @Resource
    private UserService userService;
    @Resource
    private TitleService titleService;

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    //ajax设置在session设置查询方式
    public String setEmployeeSession(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        String name =request.getParameter("name");
        System.out.println("json"+name);
        String showEmployeeType =request.getParameter("showEmployeeType");
        System.out.println("json"+showEmployeeType);
        session.setAttribute("name",name);
        session.setAttribute("showEmployeeType",Integer.parseInt(showEmployeeType));

        return SUCCESS;
    }

    //模糊查找所有在职职员信息
    public String getEmployeeByFuzzy(){
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse responses = ServletActionContext.getResponse();
            //设置编码格式,注：位置需在list前，否则utf-8格式会不对list起作用，导致乱码问题
            responses.setCharacterEncoding("utf-8");
            PrintWriter writer = responses.getWriter();
            HttpSession session =request.getSession();

            int showEmployeeType =0;
            String name=request.getParameter("fuzzyEmployeeId");
            UserinfoEntity login = (UserinfoEntity)session.getAttribute("loginUser");
            String loginSalon =employeeService.getEmployee(login.getUseBy()).getSalonId();
            String salonId ="";
            if(login.getRoleId()==1||login.getRoleId()==2){
                salonId=loginSalon;
            }
            List<Employee> allEmployeeList =employeeService.getALLEmployeeByName(salonId,name,showEmployeeType);
            List<String> employeeIdAndName =new ArrayList<String>();
            for(int i=0;i<allEmployeeList.size();i++){
                employeeIdAndName.add(allEmployeeList.get(i).getEmployeeId()+allEmployeeList.get(i).getEmployeeName());
            }
            //将List转换为JSON
            JSONArray jsonArray = JSONArray.fromObject(employeeIdAndName);
            System.out.println(jsonArray.toString());
            //写入到前台
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();

        } catch (Exception e) {

        }
        return  SUCCESS;
    }
    //按session中保存查询方式展示所有美发师信息
    public String showAllEmployee(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        UserinfoEntity login = (UserinfoEntity)session.getAttribute("loginUser");
        String loginSalon =employeeService.getEmployee(login.getUseBy()).getSalonId();
        //获取展示类型
        Object s =session.getAttribute("showEmployeeType");
        int showEmployeeType =4;
        if(s!=null)  showEmployeeType=(int)s;
        String salonId ="";
        if(login.getRoleId()==1){
           salonId=loginSalon;
        }
        System.out.println(showEmployeeType);
        //获取传递参数
        String name=null;
        switch (showEmployeeType){
            case 0:
            case 1:
            case 2:
            case 3: name = request.getParameter("name");
                if(name!=null){
                    session.setAttribute("name",name);
                }
                name=(String)session.getAttribute("name");
                break;
            case 4: name ="";
                    break;
            default:break;
        }


        List<Employee> allEmployee =employeeService.getALLEmployeeByName(salonId,name,showEmployeeType);
        List<Employee> list =null;
        //上一页下一页
        int tote=allEmployee.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        String nowPage =request.getParameter("page");
        int page=Integer.parseInt(nowPage ==null?"1":nowPage);
        list = employeeService.getEmployeeByPage(page,salonId,name,showEmployeeType);
        List<String> eTitleList =new ArrayList<String>();  //记录姓名
        // System.out.println(list.toString());
        if (list!=null) {
            if(list.size()!=0)
                for(int i=0;i<list.size();i++){
                    eTitleList.add(titleService.getTitle(list.get(i).getTitleId()).getTitleName());
                }
            else {
                    eTitleList.add("");
            }
            request.setAttribute("eTitleList",eTitleList);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;
        //return SUCCESS;
    }

    //美发师离职
    public String deleteEmployee(){
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        String deleteEmployeeId =request.getParameter("deleteEmployeeId");
        Employee uEmployee =employeeService.getEmployee(deleteEmployeeId);
        uEmployee.setOutTag((byte)1);
        uEmployee.setUpdateTag((byte)1);
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            employeeService.updateEmployee(uEmployee);
            employeeService.getAllEmployeeBySalon((employeeService.getEmployee(((UserinfoEntity)(session.getAttribute("loginUser"))).getUseBy())).getSalonId());
            PrintWriter out = response.getWriter();
            out.print("<script>alert('成功办理职工离职！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showEmployee?page=1';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }
    //美发师信息更新
    public String updateEmployee(){
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        String indate =request.getParameter("inDate");
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" );
        Date uDate =null;
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            uDate=sdf.parse(indate);
            java.sql.Date sDay =new java.sql.Date(uDate.getTime());
            employee.setInDate(sDay);
            employee.setUpdateTag((byte)1);
            employeeService.updateEmployee(employee);
            employeeService.getAllEmployeeBySalon((employeeService.getEmployee(((UserinfoEntity)(session.getAttribute("loginUser"))).getUseBy())).getSalonId());
            employeeService.getAllEmployee();
            PrintWriter out = response.getWriter();
            out.print("<script>alert('美发师信息修改成功！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showEmployee?page=1';</script>");
            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

    //保存美发师信息
    public String saveEmployee(){
        HttpServletResponse response= ServletActionContext.getResponse();
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        int number = employeeService.getAllEmployee().size()+1;
        //12位为（店铺号4位+入职时间4位+员工数量4）
        String part3 = CommonUtils.fillZeroBeforeString(String.valueOf(number),4);
        String part1 = employee.getSalonId();
        Date dNow = new Date();
        employee.setInDate(new java.sql.Date(dNow.getTime()));
        //employee.setSalonId("0000");
        employee.setUpdateTag((byte)0);
        employee.setOutTag((byte)0);
        SimpleDateFormat ft = new SimpleDateFormat ("yyyy");
        String part2 =ft.format(dNow);   //入职年
        employee.setEmployeeId(part1+part2+part3);

        //提示语句
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        PrintWriter out = null;
        try{
            employeeService.saveEmployee(employee);
            employeeService.getAllEmployeeBySalon((employeeService.getEmployee(((UserinfoEntity)(session.getAttribute("loginUser"))).getUseBy())).getSalonId());
            out = response.getWriter();
            out.print("<script>alert('美发师信息保存成功!')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showEmployee?page=1';</script>");

        }catch (Exception e){
            System.out.println(e.toString());
            return ERROR;
        }
        finally {
            out.flush();
            out.close();
        }

        return SUCCESS;
    }
}
