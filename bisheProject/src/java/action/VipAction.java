package action;

import com.opensymphony.xwork2.ActionSupport;
import model.*;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.concurrent.SuccessCallback;
import service.*;
import utils.CommonUtils;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller("vipAction")
@Scope("prototype")
public class VipAction extends ActionSupport {

    private Vip vip;
    private Vorder vorder;
    private List<Vip> list;

    public List<Vorder> getVorderList() {
        return vorderList;
    }

    public void setVorderList(List<Vorder> vorderList) {
        this.vorderList = vorderList;
    }

    private List<Vorder> vorderList;
    private Wait wait;

    public List<Vipscheme> getVipschemeList() {
        return vipschemeList;
    }

    public void setVipschemeList(List<Vipscheme> vipschemeList) {
        this.vipschemeList = vipschemeList;
    }

    private List<Vipscheme> vipschemeList;

    public Wait getWait() {
        return wait;
    }

    public void setWait(Wait wait) {
        this.wait = wait;
    }

    public List<Vip> getList() {
        return list;
    }

    public void setList(List<Vip> list) {
        this.list = list;
    }

    public Vorder getVorder() {
        return vorder;
    }

    public void setVorder(Vorder vorder) {
        this.vorder = vorder;
    }

    @Resource
    private VipService vipService;
    @Resource
    private VorderService vorderService;
    @Resource
    private VipSchemeService vipSchemeService;
    @Resource
    private EmployeeService employeeService;
    @Resource
    private UserService userService;
    @Resource
    private WaitService waitService;

    public Vip getVip() {
        return vip;
    }

    public void setVip(Vip vip) {
        this.vip = vip;
    }


    //??????????????????
    public String showVipScheme(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        List<Vipscheme> allVipscheme = vipSchemeService.getALLVipscheme();
        int tote=allVipscheme.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        vipschemeList = vipSchemeService.getVipschemeByPage(page);
        if (vipschemeList!=null&&vipschemeList.size()!=0) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", vipschemeList);
            System.out.println(vipschemeList);
            return SUCCESS;
        }
        return INPUT;
    }

    //??????????????????
    public String showVorder(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        UserinfoEntity login = (UserinfoEntity)session.getAttribute("loginUser");
        String loginSalon =employeeService.getEmployee(login.getUseBy()).getSalonId();
        //??????????????????
        Object s =session.getAttribute("showVorderType");
        int showVorderType =3;
        if(s!=null)  showVorderType=(int)s;
        System.out.println(showVorderType);
        //??????????????????
        String name=null;
        name = request.getParameter("name");
        if(login.getRoleId()!=0){
            showVorderType = 4;
            name =loginSalon;
        }
        if(name!=null){
            session.setAttribute("name",name);
        }
        name=(String)session.getAttribute("name");
        List<Vorder> allVorder = vorderService.getALLVorderByName(name,showVorderType);
        int tote=allVorder.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        vorderList = vorderService.getVorderByPage(page,name,showVorderType);
        if (vorderList!=null) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", vorderList);
            System.out.println(vorderList);
            return SUCCESS;
        }
        return INPUT;
    }

    //ajax??????????????????
    public String getVschePrice(){
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse responses = ServletActionContext.getResponse();
            //??????????????????,??????????????????list????????????utf-8???????????????list??????????????????????????????
            responses.setCharacterEncoding("utf-8");
            PrintWriter writer = responses.getWriter();
            Byte vScheId =(byte)(Integer.parseInt(request.getParameter("selectVsche"))+4);
            Vipscheme newVipscheme =vipSchemeService.getVipscheme(vScheId);
            JSONArray jsonArray =JSONArray.fromObject(newVipscheme);
            //???????????????
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();


        }catch (Exception e){
            System.out.println(e.toString());
        }
        return SUCCESS;
    }

    //????????????
    public String getVipByFuzzy(){

        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        //??????????????????
        session.setAttribute("vipPageType",1);

        String inputVipIdOrName = request.getParameter("inputVipId");
       // System.out.println("7"+inputVipIdOrName+"8");
        if(inputVipIdOrName!=null) {
            session.setAttribute("inputVipId",inputVipIdOrName);
            //System.out.println((String)session.getAttribute("inputVipId"));
        }


        inputVipIdOrName=(String)session.getAttribute("inputVipId");
        //System.out.println("9"+inputVipIdOrName+"9");
        List<Vip> allVip =vipService.getVipByFuzzy(inputVipIdOrName,inputVipIdOrName);

        int tote=allVip.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        list = vipService.getVipByPage(page,inputVipIdOrName,1);

        if (list!=null) {
            //&&list.size()!=0
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;
    }
    //??????????????????
    public String getAllVip(){
        HttpServletRequest request =ServletActionContext.getRequest();
        List<Vip> allVip =vipService.getAllVip();
        //??????????????????
        HttpSession session =request.getSession();
        session.setAttribute("vipPageType",0);
        int tote=allVip.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        list = vipService.getVipByPage(page,"",0);
        if (list!=null) {
            //&&list.size()!=0
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;
    }
    //??????????????????
    public String refundVip(){
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session = ServletActionContext.getRequest().getSession();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// ?????????????????????????????????
        try {
        //??????????????????
        Vip deleteVip = vipService.getVip(request.getParameter("vipId"));
        String refund = Integer.toString(deleteVip.getAccBalance());
        if(deleteVip.getAccBalance()==0){
            PrintWriter out = response.getWriter();
            out.print("<script>alert('??????????????????0??????????????????')</script>");
            out.print(
                    "<script>window.history.back();</script>");
            out.flush();
            out.close();
            return INPUT;

        }
        deleteVip.setAccBalance(0);
        deleteVip.setRewardPoints(0);

        //???????????????
        //???????????????????????????
        Date dNow = new Date();
        String today = new SimpleDateFormat("yyyyMMdd").format(dNow);//??????????????????
        int todayVOrders = vorderService.getVorderByFuzzy(today).size();//??????????????????????????????
        String part2 = CommonUtils.fillZeroBeforeString(String.valueOf(todayVOrders+1),4);
        SimpleDateFormat ft = new SimpleDateFormat ("yyyyMMddHHmmss");
        String part1 =ft.format(dNow);   //?????????????????????:??????????????????,???14???
        Vorder newOrder = new Vorder();
        //???????????????????????????????????????????????????
        UserinfoEntity loginUser =(UserinfoEntity)session.getAttribute("loginUser");
        Employee loginEmployee =employeeService.getEmployee(loginUser.getUseBy());
        //
        newOrder.setSalonId(loginEmployee.getSalonId());
        newOrder.setvOrderId(part1+part2);
        newOrder.setVipId(request.getParameter("vipId"));
        newOrder.setVschId((byte)0);
        newOrder.setCost(Integer.parseInt(refund));

            PrintWriter out = response.getWriter();
            out.print("<script>alert('?????????????????????"+refund+",???????????????????????????')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showVip?page=1';</script>");
            out.flush();
            out.close();
            vipService.updateVip(deleteVip);
            vorderService.saveVorderDao(newOrder);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }
    //??????????????????
    public String updateVip(){

        //????????????????????????
        HttpServletRequest request=ServletActionContext.getRequest();
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" );
        String birthday = request.getParameter("birthday");
        Date birth =null;
        try{
            birth = sdf.parse(birthday);
        }catch (ParseException e){
            System.out.println(e.toString());
        }
        java.sql.Date birthDay =new java.sql.Date(birth.getTime());
        vip.setBirthday(birthDay);

        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// ?????????????????????????????????
        try {

            vipService.updateVip(vip);
            PrintWriter out = response.getWriter();
            out.print("<script>alert('???????????????????????????')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showVip?page=1';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

    //????????????
    public String saveVip(){
        HttpServletResponse response= ServletActionContext.getResponse();
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session = ServletActionContext.getRequest().getSession();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// ?????????????????????????????????
        PrintWriter out = null;
        try{
            //??????vip????????????
            Vipscheme vipscheme = vipSchemeService.getVipscheme((byte)1); //????????????
            vip.setRewardPoints(0);  //???????????????????????????0
            vip.setAccBalance(vipscheme.getGive()); //??????????????????
            //????????????????????????
            SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" );
            String birthday = request.getParameter("birthday");
            Date birth =null;
            try{
                birth = sdf.parse(birthday);
            }catch (ParseException e){
                System.out.println(e.toString());
            }
            java.sql.Date birthDay =new java.sql.Date(birth.getTime());
            vip.setBirthday(birthDay);

            //???????????????????????????
            Date dNow = new Date();
            String today = new SimpleDateFormat("yyyyMMdd").format(dNow);//??????????????????
            int totalVips =vipService.getAllVip().size();
            String vipNum = CommonUtils.fillZeroBeforeString(String.valueOf(totalVips),4);
            vip.setVipId(today+vipNum); //??????vip id????????????????????????
            vipService.saveVip(vip);
            //????????????????????????
            int todayVOrders = vorderService.getVorderByFuzzy(today).size();//??????????????????????????????
            String part2 = CommonUtils.fillZeroBeforeString(String.valueOf(todayVOrders+1),4);
            SimpleDateFormat ft = new SimpleDateFormat ("yyyyMMddHHmmss");
            String part1 =ft.format(dNow);   //?????????????????????:??????????????????,???14???
            System.out.println("???");
            Vorder newOrder = new Vorder();
               //???????????????????????????????????????????????????

            UserinfoEntity loginUser =(UserinfoEntity)session.getAttribute("loginUser");
            Employee loginEmployee =employeeService.getEmployee(loginUser.getUseBy());
            newOrder.setSalonId(loginEmployee.getSalonId());
            newOrder.setvOrderId(part1+part2);
            newOrder.setVipId(vip.getVipId());
            newOrder.setVschId((byte)1);
            newOrder.setCost(vipscheme.getPrice());
            vorderService.saveVorderDao(newOrder);

            out = response.getWriter();
            out.print("<script>alert('?????????????????????')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showVip?page=1';</script>");

        }catch (Exception e){
            try {
                out = response.getWriter();
                out.print("<script>alert('?????????????????????')</script>");
                out.print(
                        "<script>window.history.back();</script>");

            } catch (IOException el) {
                el.printStackTrace();
            }

        }
        finally {
            out.flush();
            out.close();
        }

        return SUCCESS;
    }

    //????????????
    public String depositVip(){
        HttpServletResponse response= ServletActionContext.getResponse();
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session = ServletActionContext.getRequest().getSession();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// ?????????????????????????????????
        PrintWriter out = null;
        try{
            int inMoney = Integer.parseInt(request.getParameter("inMoney"));
            System.out.println(inMoney);
            Vip updateVip = vipService.getVip(vip.getVipId());
            //??????????????????
            // byte choseVipSche = (byte)request.getAttribute("vipScheme");
            //Vipscheme vipscheme = vipSchemeService.getVipscheme(choseVipSche);
            //?????????????????????
            updateVip.setAccBalance(inMoney+updateVip.getAccBalance());
            vipService.updateVip(updateVip);

            //??????????????????????????????
            //???????????????????????????
            Date dNow = new Date();
            String today = new SimpleDateFormat("yyyyMMdd").format(dNow);//??????????????????
            int todayVOrders = vorderService.getVorderByFuzzy(today).size();//??????????????????????????????
            String part2 = CommonUtils.fillZeroBeforeString(String.valueOf(todayVOrders+1),4);
            SimpleDateFormat ft = new SimpleDateFormat ("yyyyMMddHHmmss");
            String part1 =ft.format(dNow);   //?????????????????????:??????????????????,???14???
            vorder.setvOrderId(part1+part2);
            //???????????????????????????????????????????????????
            UserinfoEntity loginUser =(UserinfoEntity)session.getAttribute("loginUser");
            Employee loginEmployee =employeeService.getEmployee(loginUser.getUseBy());
            vorder.setSalonId(loginEmployee.getSalonId());
            vorder.setVipId(updateVip.getVipId());
            vorderService.saveVorderDao(vorder);

            out = response.getWriter();
            out.print("<script>alert('???????????????????????????')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showVip?page=1';</script>");

        }catch (Exception e){
            try {
                out = response.getWriter();
                out.print("<script>alert('?????????????????????')</script>");
                out.print(
                        "<script>window.history.back();</script>");

            } catch (IOException el) {
                el.printStackTrace();
            }

        }
        finally {
            out.flush();
            out.close();
        }

        return SUCCESS;
    }

    //??????
    public  String test(){
        System.out.println("??????");
        return SUCCESS;
    }

    //????????????
    public String bookingVip(){

        HttpServletResponse response= ServletActionContext.getResponse();
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session = ServletActionContext.getRequest().getSession();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// ?????????????????????????????????
        PrintWriter out = null;

        int totalWaitNum =waitService.getAllWait().size();
        //if(totalWaitNum==0){
        //    wait.setWaitId(0);
        //}
        //??????????????????
        //Timestamp bookingDate = new Timestamp(System.currentTimeMillis());
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
        String bookingTime = request.getParameter("bookingDate");
        System.out.println(bookingTime);
        Date nDay =null;
        try {

            nDay=sdf.parse(bookingTime);
            //java.sql.Date sqlDate = new java.sql.Date(nDay.getTime());
            //System.out.println(sqlDate);
            Timestamp bookingDate =new Timestamp(nDay.getTime());
            List<Wait> waits =waitService.getAllWaitByVipId(wait.getVipId());
            wait.setWaitTime(bookingDate);
            wait.setwTag((byte) 0);
            for(int i=0;i<waits.size();i++){
                if(waits.get(i).getwTag()==0) {
                    out = response.getWriter();
                    out.print("<script>alert('????????????,?????????????????????')</script>");
                    out.print(
                            "<script>window.location.href='http://localhost:8080/showWait?page=1';</script>");
                    return INPUT;
                }
            }
            String salonId ="";
            List<Wait> waits1 =waitService.getALLWaitByName(salonId,wait.getEmployeeId(),4);
            for(int i=0;i<waits1.size();i++){
                Long cha =Math.abs(waits1.get(i).getWaitTime().getTime()-wait.getWaitTime().getTime());

                if(cha<3600000){
                    out = response.getWriter();
                    out.print("<script>alert('????????????,????????????????????????????????????????????????')</script>");
                    out.print(
                            "<script>window.history.back();</script>");
                    return INPUT;
                }
            }
            wait.setSalonId((String)session.getAttribute("loginSalon"));
            waitService.saveWait(wait);
            out = response.getWriter();
            out.print("<script>alert('???????????????????????????')</script>");
            System.out.println("????????????1");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showWait?page=1';</script>");

            System.out.println("????????????2");
        }catch (Exception e){
            System.out.println(e.toString());
            try {
                out = response.getWriter();
                out.print("<script>alert('?????????????????????')</script>");
                out.print(
                        "<script>window.history.back();</script>");

            } catch (IOException el) {
                el.printStackTrace();
            }
        }
        finally {
            out.flush();
            out.close();
        }


        return SUCCESS;
    }
}
