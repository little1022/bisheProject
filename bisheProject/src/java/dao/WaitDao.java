package dao;

import model.Wait;

import java.util.List;

public interface WaitDao {

    void saveWait(Wait wait);
    void updateWait(Wait wait);
    Wait getWaitByWaitId(int waitId);
    List<Wait> getAllWait();
    List<Wait> getAllWaitByVipId(String vipId);
    List<Wait> getALLWaitByName(String salonId,String name,int showWaitType);  //通过参数查询
    List<Wait> getWaitByPage(int currentPage,String salonId,String name,int showWaitType);
    List<Wait> getWaitByVipAndStatus(String vip,byte status);

}
