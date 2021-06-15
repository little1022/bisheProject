package service;

import model.Hairproject;

import java.util.List;

public interface HairProjectService {
    List<Hairproject> getAllHairProject();
    List<Hairproject> getHairProjectByPage(int currentPage);
    Hairproject getHairProjectById(byte hairId);
}
