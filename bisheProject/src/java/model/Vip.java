package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;
import java.util.Objects;

@Entity
public class Vip {
    private String vipId;
    private String vipName;
    private byte sex;
    private Date birthday;
    private String telephone;
    private Integer rewardPoints;
    private Integer accBalance;

    @Id
    @Column(name = "vip_id", nullable = false, length = 12)
    public String getVipId() {
        return vipId;
    }

    public void setVipId(String vipId) {
        this.vipId = vipId;
    }

    @Basic
    @Column(name = "vip_name", nullable = false, length = 50)
    public String getVipName() {
        return vipName;
    }

    public void setVipName(String vipName) {
        this.vipName = vipName;
    }

    @Basic
    @Column(name = "sex", nullable = false)
    public byte getSex() {
        return sex;
    }

    public void setSex(byte sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "birthday", nullable = true)
    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @Basic
    @Column(name = "telephone", nullable = false, length = 11)
    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    @Basic
    @Column(name = "reward_points", nullable = true)
    public Integer getRewardPoints() {
        return rewardPoints;
    }

    public void setRewardPoints(Integer rewardPoints) {
        this.rewardPoints = rewardPoints;
    }

    @Basic
    @Column(name = "acc_balance", nullable = true)
    public Integer getAccBalance() {
        return accBalance;
    }

    public void setAccBalance(Integer accBalance) {
        this.accBalance = accBalance;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vip vip = (Vip) o;
        return sex == vip.sex &&
                Objects.equals(vipId, vip.vipId) &&
                Objects.equals(vipName, vip.vipName) &&
                Objects.equals(birthday, vip.birthday) &&
                Objects.equals(telephone, vip.telephone) &&
                Objects.equals(rewardPoints, vip.rewardPoints) &&
                Objects.equals(accBalance, vip.accBalance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(vipId, vipName, sex, birthday, telephone, rewardPoints, accBalance);
    }
}
