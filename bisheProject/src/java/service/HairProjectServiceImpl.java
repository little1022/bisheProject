package service;

import dao.HairProjectDao;
import model.Hairproject;
import model.Vipscheme;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service("hairProjectService")
public class HairProjectServiceImpl implements HairProjectService {
    @Resource
    private HairProjectDao hairProjectDao;

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Hairproject> getAllHairProject() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        List<Hairproject> list =hairProjectDao.getAllHairProject();
        session.setAttribute("hairprojects",list);
        return list;
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Hairproject> getHairProjectByPage(int currentPage) {
        return hairProjectDao.getHairProjectByPage(currentPage);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Hairproject getHairProjectById(byte hairId) {
        return hairProjectDao.getHairProjectById(hairId);
    }
}
