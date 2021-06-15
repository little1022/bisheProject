package action;

import com.opensymphony.xwork2.ActionSupport;
import model.Hsalon;
import model.UserinfoEntity;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.Parameter;
import org.apache.tools.ant.taskdefs.condition.Http;
import org.hibernate.Session;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import service.*;
import utils.CommonUtils;
import utils.Md5;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Controller("userAction")
@Scope("prototype")
public class UserAction extends ActionSupport {

    private UserinfoEntity userinfoEntity;
    private List<UserinfoEntity> list;
    private String md5_password;

    public String getMd5_password() {
        return md5_password;
    }

    public void setMd5_password(String md5_password) {
        this.md5_password = md5_password;
    }

    public List<UserinfoEntity> getList() {
        return list;
    }

    public void setList(List<UserinfoEntity> list) {
        this.list = list;
    }

    public UserinfoEntity getUserinfoEntity() {
        return userinfoEntity;
    }

    public void setUserinfoEntity(UserinfoEntity userinfoEntity) {
        this.userinfoEntity = userinfoEntity;
    }

    @Resource
    private UserService userService;

    @Resource
    private TitleService titleService;
    @Resource
    private HsalonService hsalonService;
    @Resource
    private EmployeeService employeeService;
    @Resource
    private VipSchemeService vipSchemeService;
    @Resource
    private HairProjectService hairProjectService;

      //保存用户
    public String saveUser(){
        //UserinfoEntity user = userService.getUser(userinfoEntity.getUserId());
        //int number = userService.getAllUser().size();
        //String part = CommonUtils.fillZeroBeforeString(String.valueOf(number),6);
        //userinfoEntity.setUserId(part);
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        PrintWriter out = null;
            try{
                //当使用者的角色为分店长时，修改使用者所在店铺的店长为该使用者
                if(userinfoEntity.getRoleId()==1  && !userinfoEntity.getUseBy().equals("无")){
                    Hsalon uHsalon =hsalonService.getHsalon(employeeService.getEmployee(userinfoEntity.getUseBy()).getSalonId());
                    uHsalon.setShopkeeper(userinfoEntity.getUseBy());
                    hsalonService.updateHsalon(uHsalon);
                }
                //密码加密
                Md5 md5 = new Md5();
                try {
                    userinfoEntity.setPassword(md5.EncoderByMd5(userinfoEntity.getPassword()));
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            userService.saveUser(userinfoEntity);
            out = response.getWriter();
            out.print("<script>alert('新建用户成功！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/getUser?page=1';</script>");

        }catch (Exception e){
            try {
                out = response.getWriter();
                out.print("<script>alert('新建用户失败,用户名可能已存在，请检查！')</script>");
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
      //更新用户
    public String updateUser(){
       // userinfoEntity=userService.getUser("000000");
        //userinfoEntity.setPassword("111111");
        //userinfoEntity.setRoleId(1);
        //当使用者的角色为分店长时，修改使用者所在店铺的店长为该使用者
        if(userinfoEntity.getRoleId()==1 && !userinfoEntity.getUseBy().equals("无")){
            Hsalon uHsalon =hsalonService.getHsalon(employeeService.getEmployee(userinfoEntity.getUseBy()).getSalonId());
            uHsalon.setShopkeeper(userinfoEntity.getUseBy());
            hsalonService.updateHsalon(uHsalon);
        }
        if(userinfoEntity.getRoleId()==2 && !userinfoEntity.getUseBy().equals("无")){
            Hsalon uHsalon =hsalonService.getHsalon(employeeService.getEmployee(userinfoEntity.getUseBy()).getSalonId());
            uHsalon.setShopkeeper("无");
            hsalonService.updateHsalon(uHsalon);
        }
        HttpServletRequest request =ServletActionContext.getRequest();
       // HttpSession session =request.getSession();
        //Object loginUser = session.getAttribute("loginUser");

        ////当密码全为空的时候，保留原有密码
        //if(userinfoEntity.getPassword().equals("")){
        //    UserinfoEntity originUser =userService.getUser(userinfoEntity.getUserId());
        //    userinfoEntity.setPassword(originUser.getPassword());
        //}
         //更新信息

        UserinfoEntity oldUser = userService.getUser(userinfoEntity.getUserId());
        //当密码改变时
        if(!oldUser.getPassword().equals(userinfoEntity.getPassword()))
        {
            //密码加密
            Md5 md5 = new Md5();
            try {
                userinfoEntity.setPassword(md5.EncoderByMd5(userinfoEntity.getPassword()));
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

        }
        userService.updateUser(userinfoEntity);
        userService.getAllUser();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            PrintWriter out = response.getWriter();
            String message1 = "";
            String message2 = "<script>window.location.href='http://localhost:8080/getUser?page=1';</script>";
            //当管理员修改自己的密码后，会退出。
            if(userinfoEntity.getRoleId()==0) {
                message1="请重新登录！";
                message2="<script>window.location.href='http://localhost:8080/logout';</script>";

            }
            out.print("<script>alert('用户账号更新成功！'"+message1+")</script>");
            out.print(message2);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

    //模糊查找用户
    public String findUserByFuzzy(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        session.setAttribute("userPageType",1);
        String inputUserId = request.getParameter("inputUserId");
        if(inputUserId!=null) {
            session.setAttribute("inputUserId",inputUserId);
            //System.out.println((String)session.getAttribute("inputVipId"));
        }
        inputUserId=(String)session.getAttribute("inputUserId");
        List<UserinfoEntity> allUser = userService.getUserByFuzzy(inputUserId);
        int tote=allUser.size();
        int totalPage = PageUtils.getTotalPage(3, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        list = userService.getUserByPage(page,inputUserId,1);
        if (list!=null) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;
    }

    //ajax模糊查询用户
    public String getUserByFuzzy() {
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            HttpServletResponse responses = ServletActionContext.getResponse();
            //设置编码格式,注：位置需在list前，否则utf-8格式会不对list起作用，导致乱码问题
            responses.setCharacterEncoding("utf-8");
            PrintWriter writer = responses.getWriter();
            String fuzzyUserId = request.getParameter("fuzzyUserId");
            List<UserinfoEntity> allUser = userService.getUserByFuzzy(fuzzyUserId);
            //将List转换为JSON
            JSONArray jsonArray = JSONArray.fromObject(allUser);
            //写入到前台
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();

        } catch (Exception e) {

        }
            return  SUCCESS;
    }
      //删除用户
    public String deleteUser(){
        HttpServletRequest request =ServletActionContext.getRequest();
        String userId = request.getParameter("userId");
        UserinfoEntity selectUser = userService.getUser(userId);
        //删除用户时，修改该用户使用者所在店铺的店长为无
        if(selectUser.getRoleId()==1 && !userinfoEntity.getUseBy().equals("无")){
            Hsalon uHsalon =hsalonService.getHsalon(employeeService.getEmployee(selectUser.getUseBy()).getSalonId());
            uHsalon.setShopkeeper("无");
            hsalonService.updateHsalon(uHsalon);
        }
        userService.deleteUser(selectUser);
        //更新数据
        userService.getAllUser();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            PrintWriter out = response.getWriter();
            out.print("<script>alert('删除成功！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/getUser?page=1';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

      //用户登录
    public String doLogin() {

        UserinfoEntity user = userService.getUser(userinfoEntity.getUserId());
        HttpServletResponse response=ServletActionContext.getResponse();
        Md5 md5 = new Md5();
        if (user != null) {
            try {
                if (md5.checkpassword(userinfoEntity.getPassword(),user.getPassword())) {
                    HttpSession session = ServletActionContext.getRequest().getSession();
                    session.setAttribute("loginUser", user);
                    session.setAttribute("loginSalon",(employeeService.getEmployee(user.getUseBy())).getSalonId());
                    session.setAttribute("loginEmployee",employeeService.getEmployee(user.getUseBy()));
                    session.setAttribute("showWaitType",3);
                    try{
                        employeeService.getAllEmployeeBySalon((employeeService.getEmployee(user.getUseBy())).getSalonId());
                    }catch (Exception e){
                        PrintWriter out = null;
                        try {
                            out = response.getWriter();
                        } catch (IOException e1) {
                            e1.printStackTrace();
                        }
                        out.print("<script>alert('您没有资格使用本账号！')</script>");
                        out.print(
                                "<script>window.history.back();</script>");
                        out.flush();
                        out.close();
                    }

                    if(user.getRoleId()==0) return SUCCESS;       //店长
                    if(user.getRoleId()==1) return SUCCESS;   //分店长
                    if(user.getRoleId()==2) return SUCCESS;   //收银员
                }
                else {

                    response.setContentType("text/html;charset=UTF-8");
                    response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
                    try {
                        PrintWriter out = response.getWriter();
                        out.print("<script>alert('您的密码错误！请重新输入')</script>");
                        out.print(
                                "<script>window.history.back();</script>");
                        out.flush();
                        out.close();

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    return "errorPassword";
                }
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
            else{

            response.setContentType("text/html;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
            try {
                PrintWriter out = response.getWriter();
                out.print("<script>alert('登录失败，您输入的账号不存在！')</script>");
                out.print(
                        "<script>window.history.back();</script>");
                out.flush();
                out.close();

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return ERROR;
    }
      //用户登录跳转
    public String toAdminHomeAction(){
          return SUCCESS;
    }

    //是否是第一次登录
    public String isFirstLogin(){
        //初始化读取要用到的数据库表
        //每次修改以下内容都要执行一次来保证session中的数据是最新的。
        titleService.getAllTitle();
        employeeService.getAllEmployee();
        vipSchemeService.getALLVipscheme();
        hairProjectService.getAllHairProject();
        hsalonService.getAllHsalon();

        String numbers =String.valueOf((hsalonService.getAllHsalon()).size());
        HttpSession session=ServletActionContext.getRequest().getSession();
        session.setAttribute("times",numbers);
        List<UserinfoEntity> users = userService.getAllUser();
        if(users.isEmpty()) return "firstLogin";
        else  return SUCCESS;
    }

    //通过页面分页展示User
    public String getAllUser(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        session.setAttribute("userPageType",0);
        List<UserinfoEntity> allUser = userService.getAllUser();
        int tote=allUser.size();
        int totalPage = PageUtils.getTotalPage(3, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        list = userService.getUserByPage(page,"",0);
        if (list!=null&&list.size()!=0) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;

    }
    //登出
    public String logout(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        session.invalidate();
        return SUCCESS;
    }

    //md5加密
    public String md5(){
        Md5 md5 =new Md5();
        HttpServletResponse response=ServletActionContext.getResponse();
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            String newPassword =md5.EncoderByMd5(md5_password);
            session.setAttribute("md5",newPassword);

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return  SUCCESS;
    }

}
