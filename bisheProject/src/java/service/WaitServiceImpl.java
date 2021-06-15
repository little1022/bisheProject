package service;

import dao.WaitDao;
import model.Wait;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("waitService")
public class WaitServiceImpl implements  WaitService {
    @Resource
    private WaitDao waitDao;

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveWait(Wait wait) {
        waitDao.saveWait(wait);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void updateWait(Wait wait) {
        waitDao.updateWait(wait);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public Wait getWaitByWaitId(int waitId) {
        return waitDao.getWaitByWaitId(waitId);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Wait> getWaitByVipAndStatus(String vip, byte status) {
        return waitDao.getWaitByVipAndStatus(vip,status);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Wait> getAllWait() {
        return waitDao.getAllWait();
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Wait> getAllWaitByVipId(String vipId) {
        return waitDao.getAllWaitByVipId(vipId);
    }

    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Wait> getALLWaitByName(String salonId,String name, int showWaitType) {
        return waitDao.getALLWaitByName(salonId,name,showWaitType);
    }


    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<Wait> getWaitByPage(int currentPage,String salonId, String name, int showWaitType) {
        return waitDao.getWaitByPage(currentPage,salonId,name,showWaitType);
    }
}
