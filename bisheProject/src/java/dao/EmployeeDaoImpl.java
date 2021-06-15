package dao;

import model.Employee;
import model.Page;
import model.UserinfoEntity;
import model.Wait;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
@Repository("employeeDao")
public class EmployeeDaoImpl implements EmployeeDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public Employee getEmployee(String employeeId) {
        Session session=sessionFactory.getCurrentSession();
        return session.get(Employee.class,employeeId);
    }

    @Override
    public List<Employee> getAllEmployee() {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Employee ";
        Query query = session.createQuery(hql);
        List<Employee> employees = query.list();
        return employees;
    }

    @Override
    public List<Employee> getAllEmployeeBySalon(String hsalonId) {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Employee as employee where employee.salonId like :id";
        Query<Employee> query = session.createQuery(hql,Employee.class);
        query.setString("id", hsalonId);
        List<Employee> list=query.getResultList();
        return list;
    }

    @Override
    public void saveEmployee(Employee employee) {
        Session session=sessionFactory.getCurrentSession();
        session.save(employee);
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        Session session=sessionFactory.getCurrentSession();
        session.update(employee);
        return true;
    }

    @Override
    public List<Employee> getALLEmployeeByName(String salonId,String name, int showEmployeeType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Employee> list=null;
        switch(showEmployeeType){
            case 0:hql="from Employee as employee where employee.salonId like:id1 and (employee.employeeId like:id or employee.employeeName like :id)";
                break;
            case 1:hql="from Employee as employee where employee.salonId like:id1 and employee.updateTag =:id";
                break;
            case 2:hql="from Employee as employee where employee.salonId like:id1 and employee.outTag =:id";
                break;
            case 3:hql="from Employee as employee where employee.salonId like:id";
                break;
            case 4:hql="from Employee as employee where employee.salonId like:id";
                break;
            default:break;
        }
        Query<Employee> query=session.createQuery(hql, Employee.class);
        if(showEmployeeType==0){
            query.setString("id1","%"+salonId+"%");
            query.setString("id","%"+name+"%");
        }
        else if(showEmployeeType ==3||showEmployeeType==4){
            query.setString("id","%"+salonId+"%");
        }
        else
        if(showEmployeeType==1||showEmployeeType==2){
            query.setString("id1","%"+salonId+"%");
            query.setByte("id",Byte.valueOf(name));

        }

        return query.getResultList();
    }

    @Override
    public List<Employee> getEmployeeByPage(int currentPage, String salonId,String name, int showEmployeeType) {

        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Employee> list=null;
        switch(showEmployeeType){
            case 0:hql="from Employee as employee where employee.salonId like:id1 and (employee.employeeId like:id or employee.employeeName like :id)";
                break;
            case 1:hql="from Employee as employee where employee.salonId like:id1 and employee.updateTag =:id";
                break;
            case 2:hql="from Employee as employee where employee.salonId like:id1 and employee.outTag =:id";
                break;
            case 3:hql="from Employee as employee where employee.salonId like:id";
                break;
            case 4:hql="from Employee as employee where employee.salonId like:id";
                break;
            default:break;
        }
        Query<Employee> query=session.createQuery(hql, Employee.class);
        if(showEmployeeType==0){
            query.setString("id1","%"+salonId+"%");
            query.setString("id","%"+name+"%");
        }
        else if(showEmployeeType ==3||showEmployeeType==4){
            query.setString("id","%"+salonId+"%");
        }
        else
        if(showEmployeeType==1||showEmployeeType==2){
            query.setString("id1","%"+salonId+"%");
            query.setByte("id",Byte.valueOf(name));

        }
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(8, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());
        list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }
}
