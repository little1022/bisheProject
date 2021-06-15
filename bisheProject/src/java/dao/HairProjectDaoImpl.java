package dao;

import model.Hairproject;
import model.Page;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository("hairProjectDao")
public class HairProjectDaoImpl implements HairProjectDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public List<Hairproject> getAllHairProject() {
        Session session =sessionFactory.getCurrentSession();
        String hql = "from Hairproject ";
        Query query = session.createQuery(hql);
        List<Hairproject> list = query.getResultList();
        return list;
    }

    @Override
    public List<Hairproject> getHairProjectByPage(int currentPage) {
        Session session =sessionFactory.getCurrentSession();
        String hql = "from Hairproject ";
        Query query = session.createQuery(hql);
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(8, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());
        List<Hairproject>  list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }

    @Override
    public Hairproject getHairProjectById(byte hairId) {
        Session session =sessionFactory.getCurrentSession();
        return session.get(Hairproject.class,hairId);
    }
}
