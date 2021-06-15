package action;

import com.opensymphony.xwork2.ActionSupport;
import model.*;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import service.*;
import utils.CommonUtils;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller("hairAction")
@Scope("prototype")
public class HairAction extends ActionSupport {

    public Horder getHorder() {
        return horder;
    }

    public void setHorder(Horder horder) {
        this.horder = horder;
    }

    private Horder horder;

    public List<Horder> getHorderList() {
        return horderList;
    }

    public void setHorderList(List<Horder> horderList) {
        this.horderList = horderList;
    }

    private List<Horder> horderList;

    public List<Hairproject> getHairprojectList() {
        return hairprojectList;
    }

    public void setHairprojectList(List<Hairproject> hairprojectList) {
        this.hairprojectList = hairprojectList;
    }

    private List<Hairproject> hairprojectList;
     @Resource
     private HorderService horderService;
     @Resource
     private VipService vipService;
     @Resource
     private HairProjectService hairProjectService;
     @Resource
     private WaitService waitService;
     @Resource
     private EmployeeService employeeService;

     //展示美发套餐
    public String showHairProject(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        List<Hairproject> allHairproject = hairProjectService.getAllHairProject();
        int tote=allHairproject.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        hairprojectList = hairProjectService.getHairProjectByPage(page);
        if (hairprojectList!=null&&hairprojectList.size()!=0) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", hairprojectList);
            System.out.println(hairprojectList);
            return SUCCESS;
        }
        return INPUT;
    }

    //展示美发结算订单
    public String showHorder(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        UserinfoEntity login = (UserinfoEntity)session.getAttribute("loginUser");
        String loginSalon =employeeService.getEmployee(login.getUseBy()).getSalonId();
        //获取展示类型
        Object s =session.getAttribute("showHorderType");
        int showHorderType =3;
        if(s!=null)  showHorderType=(int)s;
        System.out.println(showHorderType);
        //获取传递参数
        String name=null;
        name = request.getParameter("name");
        //分店长、收银员只能查看自己店铺
        if(login.getRoleId()!=0){
            name = loginSalon;
            showHorderType=5;
        }
        if(name!=null){
            session.setAttribute("name",name);
        }
        name=(String)session.getAttribute("name");
        List<Horder> allHorder = horderService.getALLHorderByName(name,showHorderType);
        int tote=allHorder.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        horderList = horderService.getHorderByPage(page,name,showHorderType);
        if (horderList!=null) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", horderList);
            System.out.println(horderList);
            return SUCCESS;
        }
        return INPUT;
    }

    //跳转美发结算
    public String toAccountHair(){
        return SUCCESS;
    }

    //ajax获取美发基本价格
    public  String getHairPrice(){
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse responses = ServletActionContext.getResponse();
            //设置编码格式,注：位置需在list前，否则utf-8格式会不对list起作用，导致乱码问题
            responses.setCharacterEncoding("utf-8");
            PrintWriter writer = responses.getWriter();
            Byte hairId =(byte)(Integer.parseInt(request.getParameter("i")));
            Hairproject hairproject =hairProjectService.getHairProjectById(hairId);
            JSONArray jsonArray =JSONArray.fromObject(hairproject);
            //写入到前台
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();


        }catch (Exception e){
            System.out.println(e.toString());
        }
        return SUCCESS;
    }

    //ajax通过vipId查询预约信息
    public String getWaitByVipId(){
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse responses = ServletActionContext.getResponse();
            //设置编码格式,注：位置需在list前，否则utf-8格式会不对list起作用，导致乱码问题
            responses.setCharacterEncoding("utf-8");
            PrintWriter writer = responses.getWriter();
            String add_vipId =request.getParameter("add_vipId");
            byte status =Byte.valueOf(request.getParameter("waitStatus"));
            List<Wait> waits =waitService.getWaitByVipAndStatus(add_vipId,status);
            List<String> waitInformation =new ArrayList<String>();
            for(int i=0;i<waits.size();i++){
                waitInformation.add(waits.get(i).getHairId()+waits.get(i).getEmployeeId());
            }
            JSONArray jsonArray =JSONArray.fromObject(waitInformation);
            //写入到前台
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();


        }catch (Exception e){
            System.out.println(e.toString());
        }
        return SUCCESS;
    }
    //ajax模糊查找vip
    public String getHairVipByFuzzy(){
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse responses = ServletActionContext.getResponse();
            //设置编码格式,注：位置需在list前，否则utf-8格式会不对list起作用，导致乱码问题
            responses.setCharacterEncoding("utf-8");
            PrintWriter writer = responses.getWriter();
            HttpSession session =request.getSession();
            //int showEmployeeType =0;
            String name=request.getParameter("fuzzyVipId");
            List<Vip> allVipList =vipService.getVipByFuzzy(name,name);
            List<String> vipIdAndName =new ArrayList<String>();
            for(int i=0;i<allVipList.size();i++){
                vipIdAndName.add(allVipList.get(i).getVipId()+allVipList.get(i).getVipName());
            }
            //将List转换为JSON
            JSONArray jsonArray = JSONArray.fromObject(vipIdAndName);
            System.out.println(jsonArray.toString());
            //写入到前台
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();

        } catch (Exception e) {

        }
        return  SUCCESS;
    }

    //美发结算
    public String accountHair(){
        //获取今日日期
        Date dNow = new Date();
        String today = new SimpleDateFormat("yyyyMMdd").format(dNow);//获取今天日期
        //生成会员订单信息
        int todayHOrders = horderService.getHorderByFuzzy(today).size();//查询今天的会员结算数
        String part2 = CommonUtils.fillZeroBeforeString(String.valueOf(todayHOrders+1),4);
        SimpleDateFormat ft = new SimpleDateFormat ("yyyyMMddHHmmss");
        String part1 =ft.format(dNow);   //结算单生成时间:年月日时分秒,共14位
        horder.sethOrderId(part1+part2);
        String ss =horder.gethOrderId();
        HttpServletResponse response= ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码

        String message =" ";
        String desc =" ";
        //获取支付方式
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        List<Vipscheme> vipschemes=(List<Vipscheme>) session.getAttribute("vschList");
        byte type =horder.getPayType();
        Vip uVip =vipService.getVip(horder.getVipId());
        List<Wait> waits =waitService.getWaitByVipAndStatus(uVip.getVipId(),(byte)1);
        if(type==2)  //会员账户扣款
        {
            //判断积分是否达到抵扣标准
            uVip =vipService.getVip(horder.getVipId());
            if(uVip.getRewardPoints()>=vipschemes.get(3).getPrice()){
                //如果积分达到标准,判断账户余额是否足够抵扣，
                if(uVip.getAccBalance()>=(horder.getTotalCost()-vipschemes.get(3).getGive())){
                    //如果账户余额足够,新余额=原金额-消费金额+抵扣金额
                    //
                    message+="本次使用"+vipschemes.get(3).getPrice()+"积分抵扣了"+vipschemes.get(3).getGive()+"元，实际消费金额为"+(horder.getTotalCost()-vipschemes.get(3).getGive());
                    desc=message;
                    //更新vip账户信息
                    uVip.setRewardPoints(uVip.getRewardPoints()-vipschemes.get(3).getPrice());
                    uVip.setAccBalance(uVip.getAccBalance()-horder.getTotalCost()+vipschemes.get(3).getGive());
                    horder.setTotalCost(0); //会员账户抵扣，顾客不用支付现金。
                }
                //如果积分达到标准，但账户余额不够，通知用户账户余额不够，请使用其他方式或者充值
                else{
                    message+="您的账户余额不足以支付本次消费，请使用现金支付或者充值！";
                    try {
                        PrintWriter out = null;
                        out = response.getWriter();
                        out = response.getWriter();
                        out.print("<script>alert('"+message+"')</script>");
                        out.print(
                                "<script>window.history.back();</script>");
                        return INPUT;

                    } catch (IOException el) {
                        el.printStackTrace();
                    }
                }
            }
            //如果积分未达到标准，将直接使用账户余额扣款
            else{
                if(uVip.getAccBalance()>=(horder.getTotalCost())){
                    //如果账户余额足够,新余额=原金额-消费金额
                    //
                    message+="本次未使用积分，实际消费"+horder.getTotalCost()+"元";
                    desc=message;
                    //更新vip账户信息
                    uVip.setRewardPoints(uVip.getRewardPoints());
                    uVip.setAccBalance(uVip.getAccBalance()-horder.getTotalCost());
                    horder.setTotalCost(0);//使用账户抵扣
                }
                //如果积分达到标准，但账户余额不够，通知用户账户余额不够，请使用其他方式或者充值
                else{
                    message+="您的账户余额不足以支付本次消费，请使用现金支付或者充值！";
                    try {
                        PrintWriter out = null;
                        out = response.getWriter();
                        out.print("<script>alert('"+message+"')</script>");
                        out.print(
                                "<script>window.history.back();</script>");
                        out.flush();
                        out.close();
                        return INPUT;

                    } catch (IOException el) {
                        el.printStackTrace();
                    }
                }

            }

        }
        //判断结算用户是不是会员
        int isVip = Integer.parseInt(request.getParameter("optionsRadiosinline"));
        if(isVip==1&&(type==1||type==0)) //网络支付或现金支付
        {

            //获取积分方案
            if(horder.getTotalCost()>vipschemes.get(2).getPrice()){
                //如果消费金额大于获取积分标准
                int getPoint =(horder.getTotalCost()/vipschemes.get(2).getPrice())*vipschemes.get(2).getGive();
                uVip.setRewardPoints(uVip.getRewardPoints()+getPoint);
                message+="本次消费"+horder.getTotalCost()+"元，获得积分"+getPoint+"。";
                desc=message;
            }

        }
        if(isVip!=1) {
            message+="本次非会员用户消费"+horder.getTotalCost()+"元";
            desc=message;
        }
        try {
            String s =horder.toString();
            horder.setAccDesc(desc);
            String s1=horder.getVipId();
            String s2=horder.gethOrderId();
            String s3=horder.getEmployeeId();
            int s5=horder.getTotalCost();
            int s6=horder.getBase();
            int s7=horder.getAddition();
           byte s8=horder.getPayType();
            byte s9=horder.getWaitTag();
            byte s10=horder.getHairId();
            horderService.saveHorder(horder);
            vipService.updateVip(uVip);
            if(waits.size()!=0){
                for(int i=0;i<waits.size();i++){
                    waits.get(i).setwTag((byte)3);
                    waitService.updateWait(waits.get(i));
                }
            }
            PrintWriter out = response.getWriter();
            out.print("<script>alert('"+message+"')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/toAccountHair';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();

            try {
                PrintWriter out = null;
                out = response.getWriter();
                out = response.getWriter();
                out.print("<script>alert('美发结算失败，请检查输入信息！')</script>");
                out.print(
                        "<script>window.history.back();</script>");

            } catch (IOException el) {
                el.printStackTrace();
            }

        }
        return  SUCCESS;
    }
}
