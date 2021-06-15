package service;

import dao.VipSchemeDao;
import model.Vipscheme;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
@Repository("vipSchemeService")
public class VipSchemeServiceImpl implements VipSchemeService {
    @Resource
    private VipSchemeDao vipSchemeDao;
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vipscheme> getALLVipscheme() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        List<Vipscheme> list =vipSchemeDao.getALLVipscheme();
        session.setAttribute("vschList",list);
        return list;
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vipscheme> getVipschemeByPage(int currentPage) {
        return vipSchemeDao.getVipschemeByPage(currentPage);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Vipscheme getVipscheme(byte vschId) {
        return vipSchemeDao.getVipscheme(vschId);
    }
}
