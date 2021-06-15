package dao;

import model.Employee;
import model.Hsalon;

import java.util.List;

public interface HsalonDao {
    Hsalon getHsalon(String salonId);
    List<Hsalon> getAllHsalon();
    void saveHsalon(Hsalon hsalon);
    boolean updateHsalon(Hsalon hsalon);
    List<Hsalon> getALLHsalonByName(String salonId,String name, int showHsalonType);  //通过参数查询
    List<Hsalon> getHsalonByPage(int currentPage,String salonId,String name,int showHsalonType);
}
