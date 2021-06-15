package service;

import dao.HsalonDao;
import model.Hsalon;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
@Service("hsalonService")
public class HsalonServiceImpl implements HsalonService {
    @Resource
    private HsalonDao hsalonDao;
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Hsalon getHsalon(String salonId) {
        return hsalonDao.getHsalon(salonId);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Hsalon> getAllHsalon() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        List<Hsalon> list =hsalonDao.getAllHsalon();
        session.setAttribute("hSalonList", list);
        return list;
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveHsalon(Hsalon hsalon) {
            hsalonDao.saveHsalon(hsalon);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean updateHsalon(Hsalon hsalon) {
        hsalonDao.updateHsalon(hsalon);
        return true;
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Hsalon> getALLHsalonByName(String salonId,String name, int showHsalonType) {
        return hsalonDao.getALLHsalonByName(salonId,name,showHsalonType);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Hsalon> getHsalonByPage(int currentPage, String salonId,String name, int showHsalonType) {
        return hsalonDao.getHsalonByPage(currentPage,salonId,name,showHsalonType);
    }
}
