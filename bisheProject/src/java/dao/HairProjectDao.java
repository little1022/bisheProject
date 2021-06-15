package dao;

import model.Hairproject;
import model.UserinfoEntity;

import java.util.List;

public interface HairProjectDao {
    List<Hairproject> getAllHairProject();
    List<Hairproject> getHairProjectByPage(int currentPage);
    Hairproject getHairProjectById(byte hairId);
}
