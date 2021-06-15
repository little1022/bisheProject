package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;
import java.util.Objects;

@Entity
public class Attendance {
    private int attendId;
    private String employeeId;
    private Date aDate;
    private String aDesc;

    @Id
    @Column(name = "attend_id", nullable = false)
    public int getAttendId() {
        return attendId;
    }

    public void setAttendId(int attendId) {
        this.attendId = attendId;
    }

    @Basic
    @Column(name = "employee_id", nullable = false, length = 12)
    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    @Basic
    @Column(name = "a_date", nullable = false)
    public Date getaDate() {
        return aDate;
    }

    public void setaDate(Date aDate) {
        this.aDate = aDate;
    }

    @Basic
    @Column(name = "a_desc", nullable = true, length = 50)
    public String getaDesc() {
        return aDesc;
    }

    public void setaDesc(String aDesc) {
        this.aDesc = aDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Attendance that = (Attendance) o;
        return attendId == that.attendId &&
                Objects.equals(employeeId, that.employeeId) &&
                Objects.equals(aDate, that.aDate) &&
                Objects.equals(aDesc, that.aDesc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(attendId, employeeId, aDate, aDesc);
    }
}
