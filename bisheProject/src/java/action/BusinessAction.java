package action;

import com.opensymphony.xwork2.ActionSupport;
import model.*;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import service.EmployeeService;
import service.HorderService;
import service.HsalonService;
import service.VorderService;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller("businessAction")
@Scope("prototype")
public class BusinessAction extends ActionSupport {
    @Resource
    private VorderService vorderService;
    @Resource
    private HorderService horderService;
    @Resource
    private EmployeeService employeeService;
    @Resource
    private HsalonService hsalonService;

    //统计财务数据
    public String business(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse responses = ServletActionContext.getResponse();
        HttpSession session=request.getSession();

        List<Business> businesses =new ArrayList<Business>();
        List<Hsalon> hsalons=hsalonService.getAllHsalon();
        for(int i=0;i<hsalons.size();i++){
            String salonId=hsalons.get(i).getSalonId();
            Business newBusiness =new Business();
            newBusiness.setSalonId(salonId);
            newBusiness.setTotalEmployee(employeeService.getAllEmployeeBySalon(salonId).size());
            newBusiness.setTotalVip(vorderService.getALLVorderByName(salonId,4).size());
            //会员收入
            int totalVipMoney =0;
            List<Vorder> vorders=vorderService.getALLVorderByName(salonId,1);
            for(int j=0;j<vorders.size();j++){
                if(vorders.get(j).getVschId()==0) //退款
                    totalVipMoney=totalVipMoney-vorders.get(j).getCost();
                else  //充值、办卡
                    totalVipMoney+=vorders.get(j).getCost();
            }
            newBusiness.setTotalVipMoney(totalVipMoney);
            //美发收入
            int totalHairMoney =0;
            List<Employee> employees =employeeService.getAllEmployeeBySalon(salonId);
            for(int m=0;m<employees.size();m++){
                List<Horder> horders=horderService.getALLHorderByName(employees.get(m).getEmployeeId(),4);
                for(int n=0;n<horders.size();n++){
                    totalHairMoney+=horders.get(n).getTotalCost();
                }
            }
            newBusiness.setTotalHairMoney(totalHairMoney);
            businesses.add(newBusiness);
        }
        int tote=businesses.size();
        List<Business> list=new ArrayList<Business>();
        int totalPage = PageUtils.getTotalPage(8, tote);
        String nowPage =request.getParameter("page");
        int page=Integer.parseInt(nowPage ==null?"1":nowPage);
        for(int i=0;i<8;i++){
            if((i+(page-1)*8)<businesses.size())
              list.add(businesses.get(i+(page-1)*8));
        }

        request.setAttribute("businesses",businesses);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("page", page);
        request.setAttribute("tote", tote);
        request.setAttribute("list", list);
        session.setAttribute("businesses",businesses);
        return SUCCESS;
    }
}
