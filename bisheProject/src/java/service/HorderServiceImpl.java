package service;

import dao.HorderDao;
import model.Horder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service("horderService")
public class HorderServiceImpl implements  HorderService{

    @Resource
    private HorderDao horderDao;

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveHorder(Horder vorder) {
        horderDao.saveHorder(vorder);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Horder> getHorderByFuzzy(String today) {
        return horderDao.getHorderByFuzzy(today);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Horder> getALLHorderByName(String name, int showHorderType) {

        return horderDao.getALLHorderByName(name, showHorderType);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Horder> getHorderByPage(int currentPage, String name, int showHorderType) {

        return horderDao.getHorderByPage(currentPage, name, showHorderType);
    }
}
