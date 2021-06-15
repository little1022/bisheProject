package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;
import java.util.Objects;

@Entity
public class Employee {
    private String employeeId;
    private String employeeName;
    private String sex;
    private Date inDate;
    private String telephone;
    private String email;
    private byte titleId;
    private String salonId;
    private Byte updateTag;
    private Byte outTag;

    @Id
    @Column(name = "employee_id", nullable = false, length = 12)
    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    @Basic
    @Column(name = "employee_name", nullable = true, length = 50)
    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    @Basic
    @Column(name = "sex", nullable = true, length = 1)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "in_date", nullable = true)
    public Date getInDate() {
        return inDate;
    }

    public void setInDate(Date inDate) {
        this.inDate = inDate;
    }

    @Basic
    @Column(name = "telephone", nullable = true, length = 11)
    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    @Basic
    @Column(name = "email", nullable = true, length = 50)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "title_id", nullable = false)
    public byte getTitleId() {
        return titleId;
    }

    public void setTitleId(byte titleId) {
        this.titleId = titleId;
    }

    @Basic
    @Column(name = "salon_id", nullable = false, length = 4)
    public String getSalonId() {
        return salonId;
    }

    public void setSalonId(String salonId) {
        this.salonId = salonId;
    }

    @Basic
    @Column(name = "update_tag", nullable = true)
    public Byte getUpdateTag() {
        return updateTag;
    }

    public void setUpdateTag(Byte updateTag) {
        this.updateTag = updateTag;
    }

    @Basic
    @Column(name = "out_tag", nullable = true)
    public Byte getOutTag() {
        return outTag;
    }

    public void setOutTag(Byte outTag) {
        this.outTag = outTag;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Employee employee = (Employee) o;
        return titleId == employee.titleId &&
                Objects.equals(employeeId, employee.employeeId) &&
                Objects.equals(employeeName, employee.employeeName) &&
                Objects.equals(sex, employee.sex) &&
                Objects.equals(inDate, employee.inDate) &&
                Objects.equals(telephone, employee.telephone) &&
                Objects.equals(email, employee.email) &&
                Objects.equals(salonId, employee.salonId) &&
                Objects.equals(updateTag, employee.updateTag) &&
                Objects.equals(outTag, employee.outTag);
    }

    @Override
    public int hashCode() {
        return Objects.hash(employeeId, employeeName, sex, inDate, telephone, email, titleId, salonId, updateTag, outTag);
    }
}
