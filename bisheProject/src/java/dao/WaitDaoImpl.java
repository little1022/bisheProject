package dao;

import model.Page;
import model.Vorder;
import model.Wait;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository("waitDao")
public class WaitDaoImpl implements WaitDao {
    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public void saveWait(Wait wait) {
        Session session =sessionFactory.getCurrentSession();
        session.save(wait);
    }

    @Override
    public void updateWait(Wait wait) {
        Session session =sessionFactory.getCurrentSession();
        session.update(wait);
    }

    @Override
    public Wait getWaitByWaitId(int waitId) {
        Session session =sessionFactory.getCurrentSession();
        return session.get(Wait.class,waitId);
    }

    @Override
    public List<Wait> getAllWait() {
        Session session =sessionFactory.getCurrentSession();
        String hql ="from Wait";
        List<Wait> list =null;
        Query<Wait> query=session.createQuery(hql, Wait.class);
        return query.getResultList();
    }

    @Override
    public List<Wait> getAllWaitByVipId(String vipId) {
        Session session =sessionFactory.getCurrentSession();
        String hql ="from Wait as wait where wait.vipId =:id";
        Query<Wait> query=session.createQuery(hql, Wait.class);
        query.setString("id",vipId);
        return query.getResultList();

    }

    @Override
    public List<Wait> getALLWaitByName(String salonId,String name,int showWaitType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Wait> list=null;
        switch(showWaitType){
            case 0:hql="from Wait as wait where wait.salonId like :id0 and wait.vipId like:id order by wait.waitTime desc ";
                break;
            case 1:hql="from Wait as wait where wait.salonId like :id0 and wait.wTag =:id order by wait.waitTime desc";
                break;
            case 2:hql="from Wait as wait where wait.salonId like :id0 and year(wait.waitTime)=:id1 and month(wait.waitTime)=:id2 and day(wait.waitTime)=:id3 ";
                break;
            case 3:hql="from Wait as wait where wait.salonId like :id0 and wait.vipId like :id order by wait.waitTime desc";
                break;
            case 4:hql="from Wait as wait where wait.salonId like :id0 and wait.employeeId = :id and wait.wTag= 0 order by wait.waitTime desc " ;
            default:break;
        }
        Query<Wait> query=session.createQuery(hql, Wait.class);
        query.setString("id0","%"+salonId+"%");
        if(showWaitType==1){
            query.setByte("id",Byte.valueOf(name));
        }
        else
        if(showWaitType==2){
            query.setInteger("id1",Integer.parseInt(name.substring(0,4)));
            query.setInteger("id2",Integer.parseInt(name.substring(5,7)));
            query.setInteger("id3",Integer.parseInt(name.substring(8,10)));
            System.out.println(name.substring(0,4)+" "+name.substring(5,7)+" "+name.substring(8,10));
        }else if(showWaitType ==3||showWaitType ==0){
            query.setString("id","%"+name+"%");
        }

        else{
            query.setString("id",name);
        }
        return query.getResultList();
    }

    @Override
    public List<Wait> getWaitByPage(int currentPage, String salonId,String name, int showWaitType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Wait> list=null;
        switch(showWaitType){
            case 0:hql="from Wait as wait where wait.salonId like :id0 and wait.vipId like:id order by wait.waitTime desc ";
                break;
            case 1:hql="from Wait as wait where wait.salonId like :id0 and wait.wTag =:id order by wait.waitTime desc";
                break;
            case 2:hql="from Wait as wait where wait.salonId like :id0 and year(wait.waitTime)=:id1 and month(wait.waitTime)=:id2 and day(wait.waitTime)=:id3 ";
                break;
            case 3:hql="from Wait as wait where wait.salonId like :id0 and wait.vipId like :id order by wait.waitTime desc";
                break;
            case 4:hql="from Wait as wait where wait.salonId like :id0 and wait.employeeId = :id and wait.wTag= 0 order by wait.waitTime desc " ;
                break;
            default:break;
        }
        Query<Wait> query=session.createQuery(hql, Wait.class);
        query.setString("id0","%"+salonId+"%");
        if(showWaitType==2){
            query.setString("id1",name.substring(0,4));
            query.setString("id2",name.substring(5,7));
            query.setString("id3",name.substring(8,10));
        }else if(showWaitType ==3||showWaitType ==0){
            query.setString("id","%"+name+"%");
        }
        else{
            query.setString("id",name);
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
    public List<Wait> getWaitByVipAndStatus(String vip, byte status) {
        Session session =sessionFactory.getCurrentSession();
        String hql ="from Wait as wait where wait.vipId =:id and wait.wTag =:status ";
        Query<Wait> query=session.createQuery(hql, Wait.class);
        query.setString("id",vip);
        query.setByte("status",status);
        return query.getResultList();
    }
}
