package model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;

@Entity
public class Service {
    private byte serviceId;
    private String serviceName;
    private int costTime;
    private String serviceDesc;

    @Id
    @Column(name = "service_id", nullable = false)
    public byte getServiceId() {
        return serviceId;
    }

    public void setServiceId(byte serviceId) {
        this.serviceId = serviceId;
    }

    @Basic
    @Column(name = "service_name", nullable = false, length = 50)
    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    @Basic
    @Column(name = "cost_time", nullable = false)
    public int getCostTime() {
        return costTime;
    }

    public void setCostTime(int costTime) {
        this.costTime = costTime;
    }

    @Basic
    @Column(name = "service_desc", nullable = true, length = 50)
    public String getServiceDesc() {
        return serviceDesc;
    }

    public void setServiceDesc(String serviceDesc) {
        this.serviceDesc = serviceDesc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Service service = (Service) o;
        return serviceId == service.serviceId &&
                costTime == service.costTime &&
                Objects.equals(serviceName, service.serviceName) &&
                Objects.equals(serviceDesc, service.serviceDesc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(serviceId, serviceName, costTime, serviceDesc);
    }
}
