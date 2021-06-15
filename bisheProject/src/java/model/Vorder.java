package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Vorder {
    private String vOrderId;
    private String salonId;
    private String vipId;
    private byte vschId;
    private int cost;

    @Id
    @Column(name = "v_order_id", nullable = false, length = 18)
    public String getvOrderId() {
        return vOrderId;
    }

    public void setvOrderId(String vOrderId) {
        this.vOrderId = vOrderId;
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
    @Column(name = "vip_id", nullable = false, length = 12)
    public String getVipId() {
        return vipId;
    }

    public void setVipId(String vipId) {
        this.vipId = vipId;
    }

    @Basic
    @Column(name = "vsch_id", nullable = false)
    public byte getVschId() {
        return vschId;
    }

    public void setVschId(byte vschId) {
        this.vschId = vschId;
    }

    @Basic
    @Column(name = "cost", nullable = false)
    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vorder vorder = (Vorder) o;
        return vschId == vorder.vschId &&
                cost == vorder.cost &&
                Objects.equals(vOrderId, vorder.vOrderId) &&
                Objects.equals(salonId, vorder.salonId) &&
                Objects.equals(vipId, vorder.vipId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(vOrderId, salonId, vipId, vschId, cost);
    }
}
