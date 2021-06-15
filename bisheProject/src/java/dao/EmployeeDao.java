package dao;

import model.Employee;
import model.Wait;

import java.util.List;

public interface EmployeeDao  {
     Employee getEmployee(String employeeId);
    List<Employee> getAllEmployee();
    List<Employee> getAllEmployeeBySalon(String hsalonId);
    void saveEmployee(Employee employee);
    boolean updateEmployee(Employee employee);
    List<Employee> getALLEmployeeByName(String salonId, String name, int showEmployeeType);  //通过参数查询
    List<Employee> getEmployeeByPage(int currentPage,String salonId,String name,int showEmployeeType);
}
