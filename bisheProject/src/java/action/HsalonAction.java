package action;

import com.opensymphony.xwork2.ActionSupport;
import model.Employee;
import model.Hsalon;
import model.UserinfoEntity;
import net.sf.json.JSONArray;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.aspectj.util.FileUtil;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import service.EmployeeService;
import service.HsalonService;
import utils.CommonUtils;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller("hsalonAction")
@Scope("prototype")
public class HsalonAction extends ActionSupport {

    private Hsalon hsalon;
    private List<File> upload;      					//上传的文件内容，由于是多个，用List集合
    private List<String> uploadFileName;				//文件名

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

    @Resource
    private HsalonService hsalonService;
    @Resource
    private EmployeeService employeeService;

    public Hsalon getHsalon() {
        return hsalon;
    }

    public void setHsalon(Hsalon hsalon) {
        this.hsalon = hsalon;
    }

    //营业许可证等图片上传
    //public String uploadLicense(){
    //    HttpServletResponse res= ServletActionContext.getResponse();
    //    HttpServletRequest  req=ServletActionContext.getRequest();
    //    //将文件上传到本地磁盘目录下
    //    String updoadFilePath = req.getServletContext().getRealPath("")+ "upload";
    //    System.out.println("updoadFilePath:"+updoadFilePath);
    //    File updoadDir = new File(updoadFilePath);
    //    if (!updoadDir.exists()) {
    //        updoadDir.mkdirs();
    //    }
    //
    //    String add_License1 =req.getParameter("add_License1");
    //    String add_License2 =req.getParameter("add_License2");
    //    String add_License3 =req.getParameter("add_License3");
    //    // 获得文件：
    //    File file1 = new File(add_License1);
    //    File file2 = new File(add_License2);
    //    File file3 = new File(add_License3);
    //
    //    //获取文件名
    //    String filename1 = file1.getName();
    //    String filename2 = file2.getName();
    //    String filename3 = file3.getName();
    //    //获取文件路径
    //    String fullname1 = updoadFilePath + File.separator + filename1;
    //    String fullname2 = updoadFilePath + File.separator + filename2;
    //    String fullname3 = updoadFilePath + File.separator + filename3;
    //
    //    //System.out.println("fullname"+fullname);
    //    File targetFile1 = new File(fullname1);
    //    File targetFile2 = new File(fullname2);
    //    File targetFile3 = new File(fullname3);
    //    if (targetFile1.exists()) {
    //        targetFile1.delete();
    //    }
    //    if (targetFile2.exists()) {
    //        targetFile2.delete();
    //    }
    //    if (targetFile2.exists()) {
    //        targetFile2.delete();
    //    }
    //    try {
    //        targetFile1.createNewFile();//
    //        targetFile2.createNewFile();//
    //        targetFile3.createNewFile();//
    //        FileUtil.copyFile(file1,targetFile1);
    //        FileUtil.copyFile(file2,targetFile2);
    //        FileUtil.copyFile(file3,targetFile3);
    //        PrintWriter writer = res.getWriter();
    //        List<String> licenses = null;
    //        licenses.add(fullname1);
    //        licenses.add(fullname2);
    //        licenses.add(fullname3);
    //        //将List转换为JSON
    //        JSONArray jsonArray = JSONArray.fromObject(licenses);
    //        //写入到前台
    //        writer.write(jsonArray.toString());
    //        writer.flush();
    //        writer.close();
    //
    //    } catch (IOException e) {
    //        e.printStackTrace();
    //    }
    //
    //    return  SUCCESS;
    //}
    //展示图片
    public String toPicture() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        String picPath=request.getParameter("picPath");
        request.setAttribute("picPath",picPath);
        String updoadFilePath = request.getServletContext().getRealPath("")+ "upload";
        File source =new File(updoadFilePath+File.separator+picPath);
        File target =new File(request.getContextPath()+"upload"+File.separator+picPath);
        if(target.exists())
            target.delete();
        FileUtils.copyFile(source,target);
        return SUCCESS;
    }
    //ajax设置salon查询方式
    public String setSalonSession(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        String name =request.getParameter("name");
        System.out.println("json"+name);
        String showSalonType =request.getParameter("showSalonType");
        System.out.println("json"+showSalonType);
        session.setAttribute("name",name);
        session.setAttribute("showSalonType",Integer.parseInt(showSalonType));

        return SUCCESS;
    }

    //展示美发店信息
    public String showAllSalon(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session =request.getSession();
        //获取展示类型
        Object s =session.getAttribute("showSalonType");
        int showSalonType =4;
        UserinfoEntity login = (UserinfoEntity)session.getAttribute("loginUser");
        String loginSalon =employeeService.getEmployee(login.getUseBy()).getSalonId();
        String salonId ="";
        if(login.getRoleId()==1){
            salonId=loginSalon;
        }
        if(s!=null)  showSalonType=(int)s;
        System.out.println(showSalonType);
        //获取传递参数
        String name=null;
        switch (showSalonType){
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
        session.setAttribute("showSalonType",s);
        System.out.println("name"+name);
        System.out.println(showSalonType);
        List<Hsalon> allHsalon =hsalonService.getALLHsalonByName(salonId,name,showSalonType);
        List<Hsalon> list =null;
        //上一页下一页
        int tote=allHsalon.size();
        int totalPage = PageUtils.getTotalPage(8, tote);
        String nowPage =request.getParameter("page");
        int page=Integer.parseInt(nowPage ==null?"1":nowPage);
        list = hsalonService.getHsalonByPage(page,salonId,name,showSalonType);

        // System.out.println(list.toString());
        if (list!=null) {
            if(list.size()!=0){

                }
            else {

            }
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);
            request.setAttribute("tote", tote);
            request.setAttribute("list", list);
            System.out.println(list);
            return SUCCESS;
        }
        return INPUT;
    }

    //保存美发店店铺信息
    public  String saveHsalon(){
        ////文件上传
        //HttpServletResponse res= ServletActionContext.getResponse();
        //HttpServletRequest  req=ServletActionContext.getRequest();
        ////将文件上传到本地磁盘目录下
        //String updoadFilePath = req.getServletContext().getRealPath("")+ "upload";
        //System.out.println("updoadFilePath:"+updoadFilePath);
        //File updoadDir = new File(updoadFilePath);
        //if (!updoadDir.exists()) {
        //    updoadDir.mkdirs();
        //}
        //uploadFileName1 =upload1.getName();
        //uploadFileName2 =upload2.getName();
        //uploadFileName3 =upload3.getName();
        //
        //// 获得文件：
        //File targetFile1 = new File(updoadFilePath,uploadFileName1);
        //File targetFile2 = new File(updoadFilePath,uploadFileName2);
        //File targetFile3 = new File(updoadFilePath,uploadFileName3);
        //
        //if (targetFile1.exists()) {
        //    targetFile1.delete();
        //}
        //if (targetFile2.exists()) {
        //    targetFile2.delete();
        //}
        //if (targetFile2.exists()) {
        //    targetFile2.delete();
        //}
        //try {
        //    targetFile1.createNewFile();//
        //    targetFile2.createNewFile();//
        //    targetFile3.createNewFile();//
        //    FileUtils.copyFile(upload1,targetFile1);
        //    FileUtils.copyFile(upload2,targetFile2);
        //    FileUtils.copyFile(upload3,targetFile3);
        //
        //} catch (IOException e) {
        //    e.printStackTrace();
        //}
        try {
            if(upload!=null){
                for (int i=0; i < upload.size(); i++) {    //遍历，对每个文件进行读/写操作
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
        HttpServletRequest request =ServletActionContext.getRequest();
        int number = hsalonService.getAllHsalon().size();
        System.out.println(number);
        String part = CommonUtils.fillZeroBeforeString(String.valueOf(number),4);
        hsalon.setSalonId(part);
        hsalon.setLicense1(getUploadFileName().get(0));
        hsalon.setLicense2(getUploadFileName().get(1));
        hsalon.setLicense3(getUploadFileName().get(2));

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        PrintWriter out = null;
        try{
            hsalonService.saveHsalon(hsalon);
            hsalonService.getAllHsalon();
            out = response.getWriter();
            out.print("<script>alert('店铺信息保存成功！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showSalon?page=1';</script>");

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

    //读取图片
    public String showPicture(){
        HttpServletResponse response= ServletActionContext.getResponse();
        HttpServletRequest request =ServletActionContext.getRequest();
        String filename =(String)request.getAttribute("picPath");
        response.setContentType("image/*");
        FileInputStream fis = null;
        OutputStream os = null;
        try{
            //fis = new FileInputStream(re.getSession().getServletContext().getRealPath("/res/fileUpload")+"/"+pic_addr);
            //在这里我直接用了一个已经写好的路径
            fis = new FileInputStream(request.getServletContext().getRealPath("")+ "upload"+File.separator+filename);
            os = response.getOutputStream();
            int count = 0;
            byte[] buffer = new byte[1024*8];
            while ( (count = fis.read(buffer)) != -1 ){
                os.write(buffer, 0, count);
                os.flush();
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try {
                fis.close();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return SUCCESS;
    }

    //更新美发店店铺信息
    public String updateHsalon(){
        Hsalon nHsalon =hsalonService.getHsalon(hsalon.getSalonId());
        hsalon.setLicense1(nHsalon.getLicense1());
        hsalon.setLicense2(nHsalon.getLicense2());
        hsalon.setLicense3(nHsalon.getLicense3());
        hsalonService.updateHsalon(hsalon);
        hsalonService.getAllHsalon();
        HttpServletResponse response=ServletActionContext.getResponse();
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");// 防止弹出的信息出现乱码
        try {
            PrintWriter out = response.getWriter();
            out.print("<script>alert('店铺信息修改成功！')</script>");
            out.print(
                    "<script>window.location.href='http://localhost:8080/showSalon?page=1';</script>");
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

    //删除美发店店铺信息
    public String deleteHsalon(){
        return SUCCESS;
    }
}
