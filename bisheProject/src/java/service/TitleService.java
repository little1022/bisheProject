package service;

import model.Title;

import java.util.List;

public interface TitleService {
    Title getTitle(byte titleId);
    List<Title> getAllTitle();
    void saveTitle(Title title);
    boolean updateTitle(Title title);
    List<Title> getTitleByPage(int currentPage);
}
