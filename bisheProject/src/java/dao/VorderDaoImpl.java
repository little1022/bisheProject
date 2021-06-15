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
import javax.servlet.http.HttpSession;
import java.util.List;

@Repository("vorderDao")
public class VorderDaoImpl implements VorderDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public void saveVorder(Vorder vorder) {
        Session session =sessionFactory.getCurrentSession();
        session.save(vorder);

    }

    @Override
    public List<Vorder> getVorderByFuzzy(String today) {
        Session session =sessionFactory.getCurrentSession();
        List<Vorder> list =null;
        String hql = "from Vorder as vorder where vorder.vOrderId like :id";
        Query<Vorder> query = session.createQuery(hql,Vorder.class);
        query.setString("id", today+"__________");
        list=query.getResultList();
        return list;
    }

    @Override
    public List<Vorder> getALLVorderByName(String name, int showVorderType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Vorder> list=null;
        switch(showVorderType){
            case 0:hql="from Vorder as vorder where vorder.vipId like :id";
                break;
            case 1:hql="from Vorder as vorder where vorder.salonId = :id ";
                break;
            case 2:hql="from Vorder as vorder ";
                break;
            case 3:hql="from Vorder";
                break;
            case 4:hql="from Vorder as vorder where vorder.salonId = :id and vorder.vschId=1";
                break;
            default:break;
        }
        Query<Vorder> query=session.createQuery(hql, Vorder.class);
        if(showVorderType==0||showVorderType==1||showVorderType==4)
           query.setString("id",name);
        return query.getResultList();
    }

    @Override
    public List<Vorder> getVorderByPage(int currentPage, String name, int showVorderType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Vorder> list=null;
        switch(showVorderType){
            case 0:hql="from Vorder as vorder where vorder.vipId like :id";
                break;
            case 1:hql="from Vorder as vorder ";
                break;
            case 2:hql="from Vorder as vorder ";
                break;
            case 3:hql="from Vorder";
                break;
            case 4:hql="from Vorder as vorder where vorder.salonId = :id and vorder.vschId=1";
                break;
            default:break;
        }
        Query<Vorder> query=session.createQuery(hql, Vorder.class);
        if(showVorderType==0||showVorderType==1||showVorderType==4)
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
