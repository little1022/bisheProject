package service;

import dao.TitleDao;
import model.Title;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import service.TitleService;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service("titleService")
public class TitleServiceImpl implements TitleService {
    @Resource
    private TitleDao titleDao;
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Title getTitle(byte titleId) {
        return titleDao.getTitle(titleId);
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveTitle(Title title) {
         titleDao.saveTitle(title);
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean updateTitle(Title title) {
        titleDao.updateTitle(title);
        return true;
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Title> getTitleByPage(int currentPage) {
       return titleDao.getTitleByPage(currentPage);
    }

    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Title> getAllTitle() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        List<Title> list = titleDao.getAllTitle();
        session.setAttribute("titleList", list);
        return list;
    }


}
