package service;

import model.Vorder;

import java.util.List;

public interface VorderService {
    void saveVorderDao(Vorder vorder);
    List<Vorder> getVorderByFuzzy(String today);
    List<Vorder> getALLVorderByName(String name, int showVorderType);  //通过参数查询
    List<Vorder> getVorderByPage(int currentPage,String name,int showVorderType);
}
