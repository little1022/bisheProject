package dao;

import model.Page;
import model.UserinfoEntity;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository("userDao")
public class UserDaoImpl implements UserDao {
    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;
    @Override
    public UserinfoEntity getUser(String userId) {
        Session session=sessionFactory.getCurrentSession();
        return session.get(UserinfoEntity.class,userId);
    }

    @Override
    public void saveUser(UserinfoEntity userinfoEntity) {
        Session session=sessionFactory.getCurrentSession();
        session.save(userinfoEntity);
        System.out.println("======="+userinfoEntity.getUserId());

    }

    @Override
    public boolean updateUser(UserinfoEntity userinfoEntity) {
        Session session=sessionFactory.getCurrentSession();
        session.update(userinfoEntity);
        return true;
    }

    @Override
    public boolean deleteUser(UserinfoEntity userinfoEntity) {
        Session session=sessionFactory.getCurrentSession();
        session.delete(userinfoEntity);
        return true;
    }
    @Override
    public List<UserinfoEntity> getAllUser() {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from UserinfoEntity ";
        Query query = session.createQuery(hql);
        List<UserinfoEntity> users = query.list();
        return users;
    }

    @Override
    public List<UserinfoEntity> getUserByPage(int currentPage,String userId,int tag){
        List<UserinfoEntity> list =null;
        String hql=null;
        Session session=sessionFactory.getCurrentSession();
        if(tag ==0){
            hql = "from UserinfoEntity";
        }
        else {
            hql = "from UserinfoEntity as userinfoEntity where userinfoEntity.userId like :id";
        }

        Query<UserinfoEntity> query = session.createQuery(hql,UserinfoEntity.class);
        if(tag ==1) {
            query.setString("id", "%"+userId+"%");
        }
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(3, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());

        list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }

    //模糊查询
    @Override
    public List<UserinfoEntity> getUserByFuzzy(String userId) {
        List<UserinfoEntity> list =null;
        Session session=sessionFactory.getCurrentSession();
        String hql = "from UserinfoEntity as userinfoEntity where userinfoEntity.userId like :id";
        Query<UserinfoEntity> query = session.createQuery(hql,UserinfoEntity.class);
        query.setString("id", "%"+userId+"%");
        list=query.getResultList();
        return list;
    }
}
