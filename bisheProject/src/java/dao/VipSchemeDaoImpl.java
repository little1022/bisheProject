package dao;

import model.Hairproject;
import model.Page;
import model.Vipscheme;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;
@Repository("vipSchemeDao")
public class VipSchemeDaoImpl implements VipSchemeDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    @Override
    public List<Vipscheme> getALLVipscheme() {
        Session session =sessionFactory.getCurrentSession();
        String hql = "from Vipscheme ";
        Query query = session.createQuery(hql);
        List<Vipscheme> list = query.getResultList();
        return list;
    }

    @Override
    public List<Vipscheme> getVipschemeByPage(int currentPage) {
        Session session =sessionFactory.getCurrentSession();
        String hql = "from Vipscheme ";
        Query query = session.createQuery(hql);
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(8, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());
        List<Vipscheme>  list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }

    @Override
    public Vipscheme getVipscheme(byte vschId) {
        Session session =sessionFactory.getCurrentSession();
        return session.get(Vipscheme.class,vschId);
    }
}
