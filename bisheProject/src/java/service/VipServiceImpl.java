package service;

import dao.VipDao;
import model.Vip;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service("vipService")
public class VipServiceImpl implements VipService {
    @Resource
    private VipDao vipDao;
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Vip getVip(String vipId) {
        return vipDao.getVip(vipId);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vip> getAllVip() {
        return vipDao.getAllVip();
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vip> getVipByPage(int currentPage,String vipName,int tag) {
        return vipDao.getVipByPage(currentPage,vipName,tag);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Vip> getVipByFuzzy(String vipId,String vipName) {
        return vipDao.getVipByFuzzy(vipId,vipName);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveVip(Vip vip) {
         vipDao.saveVip(vip);
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean updateVip(Vip vip) {
        vipDao.updateVip(vip);
        return true;
    }
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean deleteVip(Vip vip) {
        vipDao.deleteVip(vip);
        return true;
    }
}
