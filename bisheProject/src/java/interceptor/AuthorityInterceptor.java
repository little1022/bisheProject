package interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import model.UserinfoEntity;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class AuthorityInterceptor extends AbstractInterceptor {
    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        HttpSession session= ServletActionContext.getRequest().getSession();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        Object loginUser = session.getAttribute("loginUser");
        boolean isLogin = loginUser!=null;//判断是否登录
        if(!isLogin){
            try {
                PrintWriter out = response.getWriter();
                out.print("<script>alert('您未登录，请先登录！')</script>");
                out.print(
                        "<script>window.location.href='http://localhost:8080/isFirstLogin';</script>");
                out.flush();
                out.close();

            } catch (IOException e) {
                e.printStackTrace();
            }

            return ActionSupport.ERROR;
        }
        //判断登录用户是否是店长
        if(((UserinfoEntity)loginUser).getRoleId()==0)
            return actionInvocation.invoke();
        else {

            try {
                PrintWriter out = response.getWriter();
                out.print("<script>alert('您的权限不够，无法访问！')</script>");
                out.print(
                        "<script>window.history.back();</script>");
                out.flush();
                out.close();

            } catch (IOException e) {
                e.printStackTrace();
            }

            return ActionSupport.ERROR;
        }

       /* if(((UserinfoEntity)loginUser).getRoleId()==1)
            return "viceAdmin";   //分店长
        if(((UserinfoEntity)loginUser).getRoleId()==2)
            return "cashier";   //收银员
        return null;*/
    }
}
