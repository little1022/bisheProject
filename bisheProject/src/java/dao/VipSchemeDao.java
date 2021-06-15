package dao;

import model.Hairproject;
import model.Vipscheme;

import java.util.List;

public interface VipSchemeDao {
     List<Vipscheme> getALLVipscheme();
     List<Vipscheme> getVipschemeByPage(int currentPage);
     Vipscheme getVipscheme(byte vschId);
}
