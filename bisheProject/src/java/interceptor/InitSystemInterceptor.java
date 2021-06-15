package interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import dao.UserDaoImpl;
import model.UserinfoEntity;
import org.apache.struts2.ServletActionContext;
import service.UserService;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class InitSystemInterceptor extends AbstractInterceptor {

    private UserDaoImpl userDaoImpl;
    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        HttpSession session= ServletActionContext.getRequest().getSession();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        List<UserinfoEntity> list =userDaoImpl.getAllUser();
        Object loginUser = session.getAttribute("loginUser");
        boolean isLogin = loginUser!=null;//判断是否登录
        if(isLogin){
            try {
                PrintWriter out = response.getWriter();
                out.print("<script>alert('您已登录，系统无需初始化！')</script>");
                out.print(
                        "<script>window.history.back();</script>");
                out.flush();
                out.close();

            } catch (IOException e) {
                e.printStackTrace();
            }

            return ActionSupport.ERROR;
        }
        //判断登录用户是否是店长
        if(list.size()==0)
            return actionInvocation.invoke();
        else {

            try {
                PrintWriter out = response.getWriter();
                out.print("<script>alert('系统已保存登陆账户，无法初始化！')</script>");
                out.print(
                        "<script>window.history.back();</script>");
                out.flush();
                out.close();

            } catch (IOException e) {
                e.printStackTrace();
            }

            return ActionSupport.ERROR;
        }
    }
}
