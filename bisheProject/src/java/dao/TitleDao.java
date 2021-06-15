package dao;

import model.Title;

import java.util.List;

public interface TitleDao {
    Title getTitle(byte titleId);
    List<Title> getAllTitle(String titleId);
    List<Title> getAllTitle();
    void saveTitle(Title title);
    boolean updateTitle(Title title);
    List<Title> getTitleByPage(int currentPage);
}
