package service;

import dao.EmployeeDao;
import model.Employee;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
    @Resource
    private EmployeeDao employeeDao;

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Employee getEmployee(String employeeId) {
        return employeeDao.getEmployee(employeeId);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Employee> getAllEmployee() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        List<Employee> list = employeeDao.getAllEmployee();
        session.setAttribute("employeeList",list);
        return list;
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Employee> getAllEmployeeBySalon(String hsalonId) {
        HttpSession session = ServletActionContext.getRequest().getSession();
        List<Employee> list = employeeDao.getAllEmployeeBySalon(hsalonId);
        session.setAttribute("employeeListBySalon",list);
        return list;
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveEmployee(Employee employee) {
        employeeDao.saveEmployee(employee);

    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean updateEmployee(Employee employee) {
        return employeeDao.updateEmployee(employee);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Employee> getALLEmployeeByName(String salonId,String name, int showEmployeeType) {
        return employeeDao.getALLEmployeeByName(salonId,name,showEmployeeType);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Employee> getEmployeeByPage(int currentPage, String salonId,String name, int showEmployeeType) {
        return employeeDao.getEmployeeByPage(currentPage,salonId,name,showEmployeeType);
    }
}
