package model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "userinfo", schema = "ssh", catalog = "")
public class UserinfoEntity {
    private String userId;
    private String password;
    private int roleId;
    private String useBy;

    @Id
    @Column(name = "user_id", nullable = false, length = 12)
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "password", nullable = false, length = 32)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "role_id", nullable = false)
    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    @Basic
    @Column(name = "use_by", nullable = true, length = 12)
    public String getUseBy() {
        return useBy;
    }

    public void setUseBy(String useBy) {
        this.useBy = useBy;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserinfoEntity that = (UserinfoEntity) o;
        return roleId == that.roleId &&
                Objects.equals(userId, that.userId) &&
                Objects.equals(password, that.password) &&
                Objects.equals(useBy, that.useBy);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, password, roleId, useBy);
    }
}
