package action;

import com.opensymphony.xwork2.ActionSupport;
import model.*;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.aspectj.util.FileUtil;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import service.*;
import utils.CommonUtils;
import utils.Md5;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller("basicAction")
@Scope("prototype")
public class BasicAction extends ActionSupport {



    public List<File> getUpload() {
        return upload;
    }

    public void setUpload(List<File> upload) {
        this.upload = upload;
    }

    public List<String> getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(List<String> uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    private List<File> upload;      					//上传的文件内容，由于是多个，用List集合
    private List<String> uploadFileName;				//文件名
    //职员信息
    private Employee employee;
    @Resource
    private EmployeeService employeeService;

    //职能信息
    private Title title;
    @Resource
    private TitleService titleService;

    //店铺信息
    private Hsalon hsalon;
    @Resource
    private HsalonService hsalonService;

    @Resource
    private VipService vipService;

    //管理员账号
    private UserinfoEntity userinfoEntity;

    public UserinfoEntity getUserinfoEntity() {
        return userinfoEntity;
    }

    public void setUserinfoEntity(UserinfoEntity userinfoEntity) {
        this.userinfoEntity = userinfoEntity;
    }

    @Resource
    private UserService userService;

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Title getTitle() {
        return title;
    }

    public void setTitle(Title title) {
        this.title = title;
    }

    public Hsalon getHsalon() {
        return hsalon;
    }

    public void setHsalon(Hsalon hsalon) {
        this.hsalon = hsalon;
    }


    //图片上传
    public String uploadImg(){
        HttpServletResponse res= ServletActionContext.getResponse();
        HttpServletRequest  req=ServletActionContext.getRequest();
        //将文件上传到本地磁盘目录下
        String updoadFilePath = req.getServletContext().getRealPath("")+ "upload";
        System.out.println("updoadFilePath:"+updoadFilePath);
        File updoadDir = new File(updoadFilePath);
        if (!updoadDir.exists()) {
            updoadDir.mkdirs();
        }

        String add_License1 =req.getParameter("add_License1");
        String add_License2 =req.getParameter("add_License2");
        String add_License3 =req.getParameter("add_License3");
        // 获得文件：
        File file1 = new File(add_License1);
        File file2 = new File(add_License2);
        File file3 = new File(add_License3);

        //获取文件名
        String filename1 = file1.getName();
        String filename2 = file2.getName();
        String filename3 = file3.getName();
        //获取文件路径
        String fullname1 = updoadFilePath + File.separator + filename1;
        String fullname2 = updoadFilePath + File.separator + filename2;
        String fullname3 = updoadFilePath + File.separator + filename3;

        //System.out.println("fullname"+fullname);
        File targetFile1 = new File(fullname1);
        File targetFile2 = new File(fullname2);
        File targetFile3 = new File(fullname3);
        if (targetFile1.exists()) {
            targetFile1.delete();
        }
        if (targetFile2.exists()) {
            targetFile2.delete();
        }
        if (targetFile2.exists()) {
            targetFile2.delete();
        }
        try {
            targetFile1.createNewFile();//
            targetFile2.createNewFile();//
            targetFile3.createNewFile();//
            FileUtil.copyFile(file1,targetFile1);
            FileUtil.copyFile(file2,targetFile2);
            FileUtil.copyFile(file3,targetFile3);
            PrintWriter writer = res.getWriter();
            List<String> licenses = null;
            licenses.add(fullname1);
            licenses.add(fullname2);
            licenses.add(fullname3);
            //将List转换为JSON
            JSONArray jsonArray = JSONArray.fromObject(licenses);
            //写入到前台
            writer.write(jsonArray.toString());
            writer.flush();
            writer.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return  SUCCESS;
    }

    //保存美发店信息
    public String saveFirstHsalon(){
       // titleService.getAllTitle();
        try {
            if(upload!=null){
                for (int i=0; i < upload.size(); i++) {    //遍历，对每个文件进行读/写操作
                   System.out.println("图片一共有"+upload.size());
                    DataInputStream dis = null;//创建二进制读入流
                    DataOutputStream dos = null;//创建二进制输出流
                    InputStream is=new FileInputStream(upload.get(i));
                    //将对象转化为二进制
                    dis =new DataInputStream(is);
                    HttpServletRequest  req=ServletActionContext.getRequest();
                    //将文件上传到本地磁盘目录下
                    String updoadFilePath = req.getServletContext().getRealPath("")+ "upload";
                    OutputStream os=new FileOutputStream(updoadFilePath+File.separator+getUploadFileName().get(i)); //文件的写入路径
                    //将输出流对象转化为二进制
                    dos = new DataOutputStream(os);
                    byte buffer[]=new byte[1024];
                    int count=0;
                    while((count=is.read(buffer))>0){
                        dos.write(buffer,0,count);
                    }
                    os.close();
                    is.close();
                }
            }
        }catch (IOException e){
            System.out.println(e.toString());
        }

        HttpServletResponse response= ServletActionContext.getResponse();
        int number = hsalonService.getAllHsalon().size();
        System.out.println(number);
        String part = CommonUtils.fillZeroBeforeString(String.valueOf(number),4);
        hsalon.setSalonId(part);
        //HttpSession session=ServletActionContext.getRequest().getSession();
        //session.setAttribute("times","1");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        PrintWriter out = null;
        hsalon.setLicense1(getUploadFileName().get(0));
        hsalon.setLicense2(getUploadFileName().get(1));
        hsalon.setLicense3(getUploadFileName().get(2));
        try{
            hsalonService.saveHsalon(hsalon);
            out = response.getWriter();
            out.print("<script>alert('店铺信息保存成功！')</script>");
            out.print(
            "<script>window.location.href='http://localhost:8080/isFirstLogin';</script>");
            out.flush();
            out.close();
        }catch (Exception e){
           System.out.println(e.toString());
           return ERROR;
        }

        return SUCCESS;
    }


    //保存美发师信息
    public String saveFirstEmployee(){
        HttpServletResponse response= ServletActionContext.getResponse();
        int number = employeeService.getAllEmployee().size()+1;
        //12位为（店铺号4位+入职时间4位+员工数量4）
        String part3 = CommonUtils.fillZeroBeforeString(String.valueOf(number),4);
        String part1 = "0000";
        Date dNow = new Date();
        employee.setInDate(new java.sql.Date(dNow.getTime()));
        employee.setSalonId("0000");
        employee.setUpdateTag((byte)0);
        employee.setOutTag((byte)0);
        SimpleDateFormat ft = new SimpleDateFormat ("yyyy");
        String part2 =ft.format(dNow);   //入职年
        employee.setEmployeeId(part1+part2+part3);

        //设置管理员初始账号，以及账号使用者
        UserinfoEntity userinfoEntity1 = new UserinfoEntity();
        userinfoEntity1.setUserId("000000");
        //密码加密
        Md5 md5 = new Md5();
        try {
            userinfoEntity1.setPassword(md5.EncoderByMd5("000000"));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        //userinfoEntity1.setPassword("000000");
        userinfoEntity1.setUseBy(employee.getEmployeeId());

        //设置店长
        Hsalon firstHsalon = hsalonService.getHsalon("0000");
        firstHsalon.setShopkeeper(employee.getEmployeeId());

        //提示语句
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        PrintWriter out = null;
        //设置初始会员000000000为普通顾客
        Vip originVIP= new Vip();
        originVIP.setVipId("000000000000");
        originVIP.setVipName("普通客户");
        originVIP.setSex((byte)0);
        originVIP.setTelephone(employee.getTelephone());
        originVIP.setRewardPoints(0);
        originVIP.setAccBalance(0);
        //设置保存出生日期
        Date birth =new Date();
        java.sql.Date birthDay =new java.sql.Date(birth.getTime());
        originVIP.setBirthday(birthDay);
        try{
            employeeService.saveEmployee(employee);
            employeeService.getAllEmployee();
            if(vipService.getAllVip().size()==0)
                 vipService.saveVip(originVIP);
            userService.saveUser(userinfoEntity1);
            userService.getAllUser();
            hsalonService.updateHsalon(firstHsalon);
            hsalonService.getAllHsalon();
            out = response.getWriter();
            out.print("<script>alert('职员信息保存成功！您的管理员账号为： 000000初始密码为：000000 请登录系统修改密码！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/isFirstLogin';</script>");

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
