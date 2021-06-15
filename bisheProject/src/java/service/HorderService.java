package service;

import model.Horder;

import java.util.List;

public interface HorderService {
    void saveHorder(Horder vorder);
    List<Horder> getHorderByFuzzy(String today);
    List<Horder> getALLHorderByName(String name, int showHorderType);  //通过参数查询
    List<Horder> getHorderByPage(int currentPage,String name,int showHorderType);
}
