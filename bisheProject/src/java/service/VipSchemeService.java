package service;

import model.Vipscheme;

import java.util.List;

public interface VipSchemeService {
    List<Vipscheme> getALLVipscheme();
    List<Vipscheme> getVipschemeByPage(int currentPage);
    Vipscheme getVipscheme(byte vschId);
}
