package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Vipscheme {
    private byte vschId;
    private int price;
    private int give;
    private String vschDesc;

    @Id
    @Column(name = "vsch_id", nullable = false)
    public byte getVschId() {
        return vschId;
    }

    public void setVschId(byte vschId) {
        this.vschId = vschId;
    }

    @Basic
    @Column(name = "price", nullable = false)
    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Basic
    @Column(name = "give", nullable = false)
    public int getGive() {
        return give;
    }

    public void setGive(int give) {
        this.give = give;
    }

    @Basic
    @Column(name = "vsch_desc", nullable = true, length = 50)
    public String getVschDesc() {
        return vschDesc;
    }

    public void setVschDesc(String vschDesc) {
        this.vschDesc = vschDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vipscheme vipscheme = (Vipscheme) o;
        return vschId == vipscheme.vschId &&
                price == vipscheme.price &&
                give == vipscheme.give &&
                Objects.equals(vschDesc, vipscheme.vschDesc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(vschId, price, give, vschDesc);
    }
}
