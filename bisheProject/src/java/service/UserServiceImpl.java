package service;

import dao.UserDao;
import model.UserinfoEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public UserinfoEntity getUser(String userId) {
        return userDao.getUser(userId);
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public void saveUser(UserinfoEntity userinfoEntity) {
        userDao.saveUser(userinfoEntity);
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean updateUser(UserinfoEntity userinfoEntity) {
        userDao.updateUser(userinfoEntity);
        return true;
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public boolean deleteUser(UserinfoEntity userinfoEntity) {
        userDao.deleteUser(userinfoEntity);
        return false;
    }
    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<UserinfoEntity> getAllUser() {
        return userDao.getAllUser();
    }

    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<UserinfoEntity> getUserByPage(int currentPage,String userId,int tag) {
        return userDao.getUserByPage(currentPage,userId,tag);
    }

    // 注入事务管理
    @Transactional(rollbackFor = {Exception.class,RuntimeException.class})
    @Override
    public List<UserinfoEntity> getUserByFuzzy(String userId) {
        return userDao.getUserByFuzzy(userId);
    }


}
