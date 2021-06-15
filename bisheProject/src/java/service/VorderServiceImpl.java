package service;

import dao.VipDao;
import dao.VorderDao;
import model.Vorder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("vorderService")
public class VorderServiceImpl implements VorderService {
    @Resource
    private VorderDao vorderDao;

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveVorderDao(Vorder vorder) {
        vorderDao.saveVorder(vorder);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vorder> getVorderByFuzzy(String today) {
        return vorderDao.getVorderByFuzzy(today);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vorder> getALLVorderByName(String name, int showVorderType) {
        return vorderDao.getALLVorderByName(name, showVorderType);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vorder> getVorderByPage(int currentPage, String name, int showVorderType) {
        return vorderDao.getVorderByPage(currentPage, name, showVorderType);
    }
}
