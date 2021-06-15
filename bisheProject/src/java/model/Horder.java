package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Horder {
    private String hOrderId;
    private String vipId;
    private Byte waitTag;
    private String employeeId;
    private byte hairId;
    private int base;
    private Integer addition;
    private int totalCost;
    private byte payType;
    private String accDesc;

    @Id
    @Column(name = "h_order_id", nullable = false, length = 18)
    public String gethOrderId() {
        return hOrderId;
    }

    public void sethOrderId(String hOrderId) {
        this.hOrderId = hOrderId;
    }

    @Basic
    @Column(name = "vip_id", nullable = true, length = 12)
    public String getVipId() {
        return vipId;
    }

    public void setVipId(String vipId) {
        this.vipId = vipId;
    }

    @Basic
    @Column(name = "wait_tag", nullable = true)
    public Byte getWaitTag() {
        return waitTag;
    }

    public void setWaitTag(Byte waitTag) {
        this.waitTag = waitTag;
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
    @Column(name = "hair_id", nullable = false)
    public byte getHairId() {
        return hairId;
    }

    public void setHairId(byte hairId) {
        this.hairId = hairId;
    }

    @Basic
    @Column(name = "base", nullable = false)
    public int getBase() {
        return base;
    }

    public void setBase(int base) {
        this.base = base;
    }

    @Basic
    @Column(name = "addition", nullable = true)
    public Integer getAddition() {
        return addition;
    }

    public void setAddition(Integer addition) {
        this.addition = addition;
    }

    @Basic
    @Column(name = "total_cost", nullable = false)
    public int getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(int totalCost) {
        this.totalCost = totalCost;
    }

    @Basic
    @Column(name = "pay_type", nullable = false)
    public byte getPayType() {
        return payType;
    }

    public void setPayType(byte payType) {
        this.payType = payType;
    }

    @Basic
    @Column(name = "acc_desc", nullable = true, length = 100)
    public String getAccDesc() {
        return accDesc;
    }

    public void setAccDesc(String accDesc) {
        this.accDesc = accDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Horder horder = (Horder) o;
        return hairId == horder.hairId &&
                base == horder.base &&
                totalCost == horder.totalCost &&
                payType == horder.payType &&
                Objects.equals(hOrderId, horder.hOrderId) &&
                Objects.equals(vipId, horder.vipId) &&
                Objects.equals(waitTag, horder.waitTag) &&
                Objects.equals(employeeId, horder.employeeId) &&
                Objects.equals(addition, horder.addition) &&
                Objects.equals(accDesc, horder.accDesc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(hOrderId, vipId, waitTag, employeeId, hairId, base, addition, totalCost, payType, accDesc);
    }
}
