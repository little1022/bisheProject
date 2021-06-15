package utils;

import model.Page;

public class PageUtils {
    public static Page getPage(int everyPage, int totalCount, int currentPage) {
        Page page = null;
        everyPage = getEveryPage(everyPage);
        currentPage = getCurrentPage(currentPage);
        int totalPage = getTotalPage(everyPage, totalCount);
        int beginIndex = getBeginIndex(everyPage, currentPage);
        boolean hasPrePage = hasPrePage(currentPage);
        boolean hasNextPage = hasNextPage(totalPage, currentPage);
        return page = new Page(everyPage, totalCount, totalPage, currentPage, beginIndex, hasPrePage, hasNextPage);
    }

    /**
     * 设定每一页显示的记录数
     *
     * @param everyPage
     * @return
     */
    public static int getEveryPage(int everyPage) {
        return everyPage == 0 ? 3 : everyPage;
    }

    /**
     * 设定当前页
     *
     * @param currentPage
     * @return
     */
    public static int getCurrentPage(int currentPage) {
        return currentPage == 0 ? 1 : currentPage;
    }

    /**
     * 设定分页的总页数
     *
     * @param everyPage
     * @param totalCount
     * @return
     */
    public static int getTotalPage(int everyPage, int totalCount) {
        int num = totalCount / getEveryPage(everyPage);
        return totalCount % getEveryPage(everyPage) == 0 ? num : num + 1;
    }

    /**
     * 设置起始点
     *
     * @param everyPage
     * @param currentPage
     * @return
     */
    public static int getBeginIndex(int everyPage, int currentPage) {
        return (getCurrentPage(currentPage) - 1) * getEveryPage(everyPage);
    }

    /**
     * 设置是否有上一页
     *
     * @param currentPage
     * @return
     */
    public static boolean hasPrePage(int currentPage) {
        return getCurrentPage(currentPage) == 1 ? false : true;
    }

    /**
     * 设置是否有下一页
     *
     * @param currentPage
     * @return
     */
    public static boolean hasNextPage(int totalPage, int currentPage) {
        return getCurrentPage(currentPage) == totalPage || totalPage == 0 ? false : true;
    }
}
