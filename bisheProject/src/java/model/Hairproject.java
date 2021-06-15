package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Hairproject {
    private byte hairId;
    private String hairService;
    private int basePrice;
    private String pDesc;

    @Id
    @Column(name = "hair_id", nullable = false)
    public byte getHairId() {
        return hairId;
    }

    public void setHairId(byte hairId) {
        this.hairId = hairId;
    }

    @Basic
    @Column(name = "hair_service", nullable = false, length = 10)
    public String getHairService() {
        return hairService;
    }

    public void setHairService(String hairService) {
        this.hairService = hairService;
    }

    @Basic
    @Column(name = "base_price", nullable = false)
    public int getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(int basePrice) {
        this.basePrice = basePrice;
    }

    @Basic
    @Column(name = "p_desc", nullable = true, length = 50)
    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Hairproject that = (Hairproject) o;
        return hairId == that.hairId &&
                basePrice == that.basePrice &&
                Objects.equals(hairService, that.hairService) &&
                Objects.equals(pDesc, that.pDesc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(hairId, hairService, basePrice, pDesc);
    }
}
