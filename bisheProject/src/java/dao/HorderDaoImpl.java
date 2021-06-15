package dao;

import model.Employee;
import model.Horder;
import model.Page;
import model.Vorder;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;
@Repository("horderDao")
public class HorderDaoImpl implements HorderDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public void saveHorder(Horder horder) {
        Session session = sessionFactory.getCurrentSession();
        session.save(horder);
    }

    @Override
    public List<Horder> getHorderByFuzzy(String today) {
        Session session =sessionFactory.getCurrentSession();
        List<Horder> list =null;
        String hql = "from Horder as horder where horder.hOrderId like :id";
        Query<Horder> query = session.createQuery(hql,Horder.class);
        query.setString("id", today+"__________");
        list=query.getResultList();
        return list;
    }


    @Override
    public List<Horder> getALLHorderByName(String name, int showHorderType) {

        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Horder> list=null;
        switch(showHorderType){
            case 0:hql="from Horder as horder where horder.vipId like :id";
                break;
            case 1:hql="from Horder as horder ";
                break;
            case 2:hql="from Horder as horder ";
                break;
            case 3:hql="from Horder";
                break;
            case 4:hql="from Horder as horder where horder.employeeId =:id";
                break;
            case 5:hql=" FROM Horder as horder WHERE horder.employeeId IN (SELECT e.employeeId FROM Employee as e WHERE e.salonId =:id)";
                break;
            default:break;
        }
        Query<Horder> query=session.createQuery(hql, Horder.class);
        if(showHorderType ==0 ||showHorderType==4||showHorderType==5)
          query.setString("id",name);
        return query.getResultList();
    }

    @Override
    public List<Horder> getHorderByPage(int currentPage, String name, int showHorderType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Horder> list=null;
        switch(showHorderType){
            case 0:hql="from Horder as horder where horder.vipId like :id";
                break;
            case 1:hql="from Horder as horder ";
                break;
            case 2:hql="from Horder as horder ";
                break;
            case 3:hql="from Horder";
                break;
            case 4:hql="from Horder as horder where horder.employeeId =:id";
                break;
            case 5:hql=" FROM Horder as horder WHERE horder.employeeId IN (SELECT e.employeeId FROM Employee as e WHERE e.salonId =:id)";
                break;
            default:break;
        }
        Query<Horder> query=session.createQuery(hql, Horder.class);
        if(showHorderType ==0 ||showHorderType==4||showHorderType==5)
            query.setString("id",name);
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(8, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());
        list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }
}
