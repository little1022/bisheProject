package action;

import com.opensymphony.xwork2.ActionSupport;
import model.Hairproject;
import model.Title;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import service.TitleService;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller("titleAction")
@Scope("prototype")
public class TitleAction extends ActionSupport {
     private Title title;
     private List<Title> titleList;

    public List<Title> getTitleList() {
        return titleList;
    }

    public void setTitleList(List<Title> titleList) {
        this.titleList = titleList;
    }

    @Resource
     private TitleService titleService;

    public Title getTitle() {
        return title;
    }

    public void setTitle(Title title) {
        this.title = title;
    }

    public String  getTitleById(byte titleId){
        title=titleService.getTitle(titleId);
        System.out.print(title.toString());
        return SUCCESS;
    }
    //保存美发师职称
    public String saveTitle() {
        Title title = new Title();
        title.setTitleId((byte) 1);
        title.setTitleName("初级美发师");
        title.setBaseSalary(4000);
        title.setCommission(50);
        titleService.saveTitle(title);
        return SUCCESS;
    }
    //更新职称信息
    public String updateTitle(){
        titleService.updateTitle(title);
        titleService.getAllTitle();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            PrintWriter out = response.getWriter();
            out.print("<script>alert('美发师职称更新成功！')</script>");
            out.print("<script>window.location.href='http://localhost:8080/showTitle?page=1';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }
    //展示职称
    public String showTitle(){
        HttpServletRequest request =ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        List<Title> allTitle = titleService.getAllTitle();
        int tote=allTitle.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        System.out.println(request.getParameter("page"));
        int page=Integer.parseInt(request.getParameter("page"));
        titleList = titleService.getTitleByPage(page);
        if (titleList!=null&&titleList.size()!=0) {
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", titleList);
            System.out.println(titleList);
            return SUCCESS;
        }
        return INPUT;
    }

}
