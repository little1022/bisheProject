package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
public class Wait {
    private int waitId;
    private Timestamp waitTime;
    private String vipId;
    private byte hairId;
    private String employeeId;
    private byte wTag;
    private String salonId;

    @Id
    @Column(name = "wait_id", nullable = false)
    public int getWaitId() {
        return waitId;
    }

    public void setWaitId(int waitId) {
        this.waitId = waitId;
    }

    @Basic
    @Column(name = "wait_time", nullable = false)
    public Timestamp getWaitTime() {
        return waitTime;
    }

    public void setWaitTime(Timestamp waitTime) {
        this.waitTime = waitTime;
    }

    @Basic
    @Column(name = "vip_id", nullable = false, length = 12)
    public String getVipId() {
        return vipId;
    }

    public void setVipId(String vipId) {
        this.vipId = vipId;
    }

    @Basic
    @Column(name = "hair_id", nullable = false)
    public byte getHairId() {
        return hairId;
    }

    public void setHairId(byte hairId) {
        this.hairId = hairId;
    }

    @Basic
    @Column(name = "employee_id", nullable = true, length = 12)
    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    @Basic
    @Column(name = "w_tag", nullable = false)
    public byte getwTag() {
        return wTag;
    }

    public void setwTag(byte wTag) {
        this.wTag = wTag;
    }

    @Basic
    @Column(name = "salon_id", nullable = true, length = 4)
    public String getSalonId() {
        return salonId;
    }

    public void setSalonId(String salonId) {
        this.salonId = salonId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Wait wait = (Wait) o;
        return waitId == wait.waitId &&
                hairId == wait.hairId &&
                wTag == wait.wTag &&
                Objects.equals(waitTime, wait.waitTime) &&
                Objects.equals(vipId, wait.vipId) &&
                Objects.equals(employeeId, wait.employeeId) &&
                Objects.equals(salonId, wait.salonId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(waitId, waitTime, vipId, hairId, employeeId, wTag, salonId);
    }
}
