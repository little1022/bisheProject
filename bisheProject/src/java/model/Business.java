package model;

public class Business {
    String salonId;
    int totalVip;
    int totalEmployee;
    int totalVipMoney;
    int totalHairMoney;

    public String getSalonId() {
        return salonId;
    }

    public void setSalonId(String salonId) {
        this.salonId = salonId;
    }

    public int getTotalVip() {
        return totalVip;
    }

    public void setTotalVip(int totalVip) {
        this.totalVip = totalVip;
    }

    public int getTotalEmployee() {
        return totalEmployee;
    }

    public void setTotalEmployee(int totalEmployee) {
        this.totalEmployee = totalEmployee;
    }

    public int getTotalVipMoney() {
        return totalVipMoney;
    }

    public void setTotalVipMoney(int totalVipMoney) {
        this.totalVipMoney = totalVipMoney;
    }

    public int getTotalHairMoney() {
        return totalHairMoney;
    }

    public void setTotalHairMoney(int totalHairMoney) {
        this.totalHairMoney = totalHairMoney;
    }
}
