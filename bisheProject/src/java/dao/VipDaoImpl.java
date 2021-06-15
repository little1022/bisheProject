package dao;

import model.Page;
import model.UserinfoEntity;
import model.Vip;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository("vipDao")
public class VipDaoImpl implements VipDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;
    @Override
    public Vip getVip(String vipId) {
        Session session=sessionFactory.getCurrentSession();
        return session.get(Vip.class,vipId);
    }

    @Override
    public List<Vip> getAllVip() {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Vip ";
        Query query = session.createQuery(hql);
        List<Vip> vips = query.getResultList();
        return vips;
    }

    @Override
    public List<Vip> getVipByPage(int currentPage,String vipName,int tag) {
        Session session=sessionFactory.getCurrentSession();
        List<Vip> list =null;
        String hql=null;
        if(tag ==0)
            hql= "from Vip ";
        else
            hql = "from Vip as vip where vip.vipId like :id or vip.vipName like :name";

        Query<Vip> query = session.createQuery(hql,Vip.class);
        if(tag ==1) {
            query.setString("id", "%" + vipName + "%");
            query.setString("name", "%" + vipName + "%");
        }
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(8, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());

        list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }

    @Override
    public List<Vip> getVipByFuzzy(String vipId,String vipName) {
        Session session=sessionFactory.getCurrentSession();
        List<Vip> list =null;
        String hql = "from Vip as vip where vip.vipId like :id or vip.vipName like :name";
        Query<Vip> query = session.createQuery(hql,Vip.class);
        query.setString("id", "%"+vipId+"%");
        query.setString("name", "%"+vipName+"%");
        list=query.getResultList();
        return list;
    }

    @Override
    public void saveVip(Vip vip) {
        Session session=sessionFactory.getCurrentSession();
        session.save(vip);
        System.out.println(vip.toString());

    }

    @Override
    public boolean updateVip(Vip vip) {
        Session session=sessionFactory.getCurrentSession();
        session.update(vip);
        return true;
    }

    @Override
    public boolean deleteVip(Vip vip) {
        Session session=sessionFactory.getCurrentSession();
        session.delete(vip);
        return true;
    }
}
