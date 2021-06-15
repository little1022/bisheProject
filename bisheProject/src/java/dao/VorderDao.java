package dao;

import model.Vorder;
import model.Wait;

import java.util.List;

public interface VorderDao {

    void saveVorder(Vorder vorder);
    List<Vorder> getVorderByFuzzy(String today);
    List<Vorder> getALLVorderByName(String name, int showVorderType);  //通过参数查询
    List<Vorder> getVorderByPage(int currentPage,String name,int showVorderType);
}
