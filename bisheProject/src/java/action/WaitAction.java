package action;

import com.opensymphony.xwork2.ActionSupport;
import model.UserinfoEntity;
import model.Vip;
import model.Wait;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;
import service.*;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller("waitAction")
public class WaitAction extends ActionSupport {

    private Wait wait;
    private List<Wait> waits;

    @Resource
    private WaitService waitService;

    @Resource
    private HairProjectService hairProjectService;
    @Resource
    private VipService vipService;
    @Resource
    private EmployeeService employeeService;

    public Wait getWait() {
        return wait;
    }

    public void setWait(Wait wait) {
        this.wait = wait;
    }

    public List<Wait> getWaits() {
        return waits;
    }

    public void setWaits(List<Wait> waits) {
        this.waits = waits;
    }

    //ajax设置查询
    public String setSession(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        String name =request.getParameter("name");
        System.out.println("json"+name);
        String showWaitType =request.getParameter("showWaitType");
        System.out.println("json"+showWaitType);
        session.setAttribute("name",name);
        session.setAttribute("showWaitType",Integer.parseInt(showWaitType));
        Object obj =request.getParameter("all");
        if(obj!=null)
            session.setAttribute("all",(String)obj);
        else
            session.setAttribute("all","no");
        return SUCCESS;
    }

    //取消预约
    public String changeStatus(){
        HttpServletRequest request =ServletActionContext.getRequest();
        String nWaitId =request.getParameter("waitId");
        String nWaitStatus =request.getParameter("waitStatus");
        int waitId = Integer.parseInt(nWaitId);
        byte waitStatus =Byte.valueOf(nWaitStatus);
        Wait updateWait = waitService.getWaitByWaitId(waitId);
        updateWait.setwTag(waitStatus);
        waitService.updateWait(updateWait);
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码

        String status =null;
        switch (waitStatus){
            case 0:status = "预约";break;
            case 1:status = "会员已到店确认！";break;
            case 2:status = "会员预约取消成功！";break;
            case 3:status = "会员预约单已完成！";break;
            default:break;
        }
        try {
            PrintWriter out = response.getWriter();
            out.print("<script>alert('"+status+"')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showWait?page=1';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

    //查找全部预约记录,查找类型为
    public String showAllWait(){


        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        //获取展示类型
         Object s =session.getAttribute("showWaitType");
         int showWaitType =3;
         if(s!=null)  showWaitType=(int)s;

        UserinfoEntity login = (UserinfoEntity)session.getAttribute("loginUser");
        String loginSalon =employeeService.getEmployee(login.getUseBy()).getSalonId();
        String salonId ="";
        if(login.getRoleId()==1||login.getRoleId()==2){
            salonId=loginSalon;
        }
        salonId=loginSalon;
        String isALL =(String) session.getAttribute("all");
        if(isALL!=null&&isALL.equals("yes")){
            salonId="";
        }else{
            salonId=loginSalon;
        }
         System.out.println(showWaitType);
         //获取传递参数
         String name=null;
         switch (showWaitType){
             case 0:
             case 1:
             case 2:  name = request.getParameter("name");
                 if(name!=null){
                     session.setAttribute("name",name);
                 }
                 name=(String)session.getAttribute("name");
                 break;
             case 3:name ="";
                    break;
             default:break;
         }
        session.setAttribute("showWaitType",s);

        List<Wait> allWait =waitService.getALLWaitByName(salonId,name,showWaitType);
        List<Wait> list =null;
        //上一页下一页
        int tote=allWait.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        String nowPage =request.getParameter("page");
        int page=Integer.parseInt(nowPage ==null?"1":nowPage);
        list = waitService.getWaitByPage (page,salonId,name,showWaitType);
        List<String> vipNameList =new ArrayList<String>();  //记录姓名
        List<String> hairProjectDescList =new ArrayList<String>(); //记录美发项目名
       // System.out.println(list.toString());
        if (list!=null) {
            if(list.size()!=0)
               for(int i=0;i<list.size();i++){
                   String nVipId =list.get(i).getVipId();
                   byte nHairId =list.get(i).getHairId();
                   String nVipName =vipService.getVip(nVipId).getVipName();
                   String nHairDesc =hairProjectService.getHairProjectById(nHairId).getpDesc();
                   //System.out.println(list.get(i).getVipId());
                   //System.out.println(vipService.getVip(list.get(i).getVipId()).getVipName());
                   //System.out.println(list.get(i).getHairId());
                   //System.out.println(hairProjectService.getHairProjectById(list.get(i).getHairId()).getpDesc());
                    vipNameList.add(nVipName);
                    hairProjectDescList.add(nHairDesc);
             }
             else {
                vipNameList.add("");
                hairProjectDescList.add("");
            }
            request.setAttribute("vipNameList",vipNameList);
            request.setAttribute("hairProjectDescList",hairProjectDescList);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            //session.setAttribute("isSelf","no");
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;
        //return SUCCESS;

    }


}
