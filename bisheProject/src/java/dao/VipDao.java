package dao;


import model.Vip;

import java.util.List;

public interface VipDao {

    Vip getVip(String vipId);
    List<Vip> getAllVip();
    List<Vip> getVipByPage(int currentPage,String vipName,int tag);
    List<Vip> getVipByFuzzy( String vipId,String vipName);  //模糊查询
    void saveVip(Vip vip);
    boolean updateVip(Vip vip);
    boolean deleteVip(Vip vip);
}
