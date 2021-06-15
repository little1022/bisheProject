package service;

import model.UserinfoEntity;

import java.util.List;

public interface UserService {

    UserinfoEntity getUser(String userId);
    List<UserinfoEntity> getAllUser();
    List<UserinfoEntity> getUserByPage(int currentPage,String userId,int tag);
    List<UserinfoEntity> getUserByFuzzy( String userId);  //模糊查询
    void saveUser(UserinfoEntity userinfoEntity);
    boolean updateUser(UserinfoEntity userinfoEntity);
    boolean deleteUser(UserinfoEntity userinfoEntity);
}
