package dao;

import model.Hairproject;
import model.Page;
import model.Title;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import utils.PageUtils;

import javax.annotation.Resource;
import java.util.List;

@Repository("titleDao")
public class TitleDaoImpl implements TitleDao {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;
    @Override
    public Title getTitle(byte titleId) {
        Session session=sessionFactory.getCurrentSession();
        return session.get(Title.class,titleId);
    }

    @Override
    public void saveTitle(Title title) {
        Session session=sessionFactory.getCurrentSession();
        session.save(title);
        System.out.println("======="+title.toString());
    }

    @Override
    public boolean updateTitle(Title title) {
        Session session=sessionFactory.getCurrentSession();
        session.update(title);
        return true;
    }

    @Override
    public List<Title> getTitleByPage(int currentPage) {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Title ";
        Query query = session.createQuery(hql);
        int tote=query.list().size();
        System.out.println(tote+"kk");
        Page page= PageUtils.getPage(8, tote, currentPage);

        query.setMaxResults(page.getEveryPage());
        query.setFirstResult(page.getBeginIndex());
        List<Title>  list = query.getResultList();
        System.out.println("DDDD"+list);
        return list;
    }

    @Override
    public List<Title> getAllTitle(String titleId) {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Title ";
        Query query = session.createQuery(hql);
        List<Title> allTitle = query.getResultList();
        return allTitle;
    }

    @Override
    public List<Title> getAllTitle() {
        Session session=sessionFactory.getCurrentSession();
        String hql = "from Title ";
        Query query = session.createQuery(hql);
        List<Title> allTitle = query.getResultList();
        return allTitle;

    }
}
