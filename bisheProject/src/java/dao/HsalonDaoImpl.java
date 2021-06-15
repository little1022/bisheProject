package dao;

import model.Employee;
import model.Hsalon;
import model.Page;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;
@Repository("hsalonDao")
public class HsalonDaoImpl implements HsalonDao {
    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public Hsalon getHsalon(String salonId) {
        Session session=sessionFactory.getCurrentSession();
        return session.get(Hsalon.class,salonId);
    }

    @Override
    public void saveHsalon(Hsalon hsalon) {
        Session session=sessionFactory.getCurrentSession();
        session.save(hsalon);
        System.out.println(hsalon.toString());

    }

    @Override
    public boolean updateHsalon(Hsalon hsalon) {
        Session session=sessionFactory.getCurrentSession();
        session.update(hsalon);
        return true;
    }

    @Override
    public List<Hsalon> getALLHsalonByName(String salonId,String name, int showHsalonType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Hsalon> list=null;
        switch(showHsalonType){
            case 0:hql="from Hsalon as hsalon where hsalon.salonId like:id1 and (hsalon.address like:id or hsalon.salonName like :id)";
                break;
            case 1:
            case 2:
            case 3:hql="from Hsalon as hsalon where hsalon.salonId like:id1 and hsalon.salonId =:id";
                break;
            case 4:hql="from Hsalon as hsalon where hsalon.salonId like:id1";
                break;
            default:break;
        }
        Query<Hsalon> query=session.createQuery(hql, Hsalon.class);
        if(showHsalonType==0)
            query.setString("id","%"+name+"%");
        else if(showHsalonType!=4)
              query.setString("id",name);
        query.setString("id1","%"+salonId+"%");
        return query.getResultList();
    }

    @Override
    public List<Hsalon> getHsalonByPage(int currentPage, String salonId,String name, int showHsalonType) {
        Session session =sessionFactory.getCurrentSession();
        String hql =null;
        List<Hsalon> list=null;
        switch(showHsalonType){
            case 0:hql="from Hsalon as hsalon where hsalon.salonId like:id1 and (hsalon.address like:id or hsalon.salonName like :id)";
                break;
            case 1:
            case 2:
            case 3:hql="from Hsalon as hsalon where hsalon.salonId like:id1 and hsalon.salonId =:id";
                break;
            case 4:hql="from Hsalon as hsalon where hsalon.salonId like:id1";
                break;
            default:break;
        }
        Query<Hsalon> query=session.createQuery(hql, Hsalon.class);
        if(showHsalonType==0)
            query.setString("id","%"+name+"%");
        else if(showHsalonType!=4)
               query.setString("id",name);
        query.setString("id1","%"+salonId+"%");
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
    public List<Hsalon> getAllHsalon() {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Hsalon ";
        Query query = session.createQuery(hql);
        List<Hsalon> hsalons = query.list();
        return hsalons;
    }
}
