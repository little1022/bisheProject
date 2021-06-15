package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Title {
    private byte titleId;
    private String titleName;
    private int commission;
    private int baseSalary;

    @Id
    @Column(name = "title_id", nullable = false)
    public byte getTitleId() {
        return titleId;
    }

    public void setTitleId(byte titleId) {
        this.titleId = titleId;
    }

    @Basic
    @Column(name = "title_name", nullable = false, length = 50)
    public String getTitleName() {
        return titleName;
    }

    public void setTitleName(String titleName) {
        this.titleName = titleName;
    }

    @Basic
    @Column(name = "commission", nullable = false)
    public int getCommission() {
        return commission;
    }

    public void setCommission(int commission) {
        this.commission = commission;
    }

    @Basic
    @Column(name = "base_salary", nullable = false)
    public int getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(int baseSalary) {
        this.baseSalary = baseSalary;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Title title = (Title) o;
        return titleId == title.titleId &&
                commission == title.commission &&
                baseSalary == title.baseSalary &&
                Objects.equals(titleName, title.titleName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(titleId, titleName, commission, baseSalary);
    }
}
