package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Hsalon {
    private String salonId;
    private String salonName;
    private String address;
    private String shopkeeper;
    private String telephone;
    private String email;
    private String license1;
    private String license2;
    private String license3;

    @Id
    @Column(name = "salon_id", nullable = false, length = 4)
    public String getSalonId() {
        return salonId;
    }

    public void setSalonId(String salonId) {
        this.salonId = salonId;
    }

    @Basic
    @Column(name = "salon_name", nullable = false, length = 50)
    public String getSalonName() {
        return salonName;
    }

    public void setSalonName(String salonName) {
        this.salonName = salonName;
    }

    @Basic
    @Column(name = "address", nullable = false, length = 50)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "shopkeeper", nullable = false, length = 12)
    public String getShopkeeper() {
        return shopkeeper;
    }

    public void setShopkeeper(String shopkeeper) {
        this.shopkeeper = shopkeeper;
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
    @Column(name = "license1", nullable = false, length = 100)
    public String getLicense1() {
        return license1;
    }

    public void setLicense1(String license1) {
        this.license1 = license1;
    }

    @Basic
    @Column(name = "license2", nullable = false, length = 100)
    public String getLicense2() {
        return license2;
    }

    public void setLicense2(String license2) {
        this.license2 = license2;
    }

    @Basic
    @Column(name = "license3", nullable = false, length = 100)
    public String getLicense3() {
        return license3;
    }

    public void setLicense3(String license3) {
        this.license3 = license3;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Hsalon hsalon = (Hsalon) o;
        return Objects.equals(salonId, hsalon.salonId) &&
                Objects.equals(salonName, hsalon.salonName) &&
                Objects.equals(address, hsalon.address) &&
                Objects.equals(shopkeeper, hsalon.shopkeeper) &&
                Objects.equals(telephone, hsalon.telephone) &&
                Objects.equals(email, hsalon.email) &&
                Objects.equals(license1, hsalon.license1) &&
                Objects.equals(license2, hsalon.license2) &&
                Objects.equals(license3, hsalon.license3);
    }

    @Override
    public int hashCode() {
        return Objects.hash(salonId, salonName, address, shopkeeper, telephone, email, license1, license2, license3);
    }
}
