package dao;

import model.Horder;
import model.Vorder;
import model.Wait;

import java.util.List;

public interface HorderDao {
    void saveHorder(Horder horder);
    List<Horder> getHorderByFuzzy(String today);
    List<Horder> getALLHorderByName(String name, int showHorderType);  //通过参数查询
    List<Horder> getHorderByPage(int currentPage,String name,int showHorderType);

}
