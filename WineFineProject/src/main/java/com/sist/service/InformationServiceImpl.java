package com.sist.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.*;
import com.sist.dao.*;

@Service
public class InformationServiceImpl implements InformationService {
	@Autowired
	private InformationDAO dao;

	@Override
	public List<GrapeVO> grapeListData(Map map) {
		// TODO Auto-generated method stub
		return dao.grapeListData(map);
	}

	@Override
	public int grapeTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.grapeTotalPage(map);
	}

	@Override
	public GrapeVO grapeDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.grapeDetailData(no);
	}

	@Override
	public List<WineVO> grapeRelatedWines(Map map) {
		// TODO Auto-generated method stub
		return dao.grapeRelatedWines(map);
	}

	@Override
	public List<NationVO> nationListData(Map map) {
		// TODO Auto-generated method stub
		return dao.nationListData(map);
	}

	@Override
	public int nationTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.nationTotalPage(map);
	}

	@Override
	public NationVO nationDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.nationDetailData(no);
	}

	@Override
	public List<WineVO> nationRelatedWines(Map map) {
		// TODO Auto-generated method stub
		return dao.nationRelatedWines(map);
	}

	@Override
	public List<MakerVO> makerListData(Map map) {
		// TODO Auto-generated method stub
		return dao.makerListData(map);
	}

	@Override
	public int makerTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.makerTotalPage(map);
	}

	@Override
	public MakerVO makerDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.makerDetailData(no);
	}

	@Override
	public List<WineVO> makerRelatedWines(Map map) {
		// TODO Auto-generated method stub
		return dao.makerRelatedWines(map);
	}

	@Override
	public int grapeFindCount(String fd) {
		return dao.grapeFindCount(fd);
	}
	
	@Override
	public List<GrapeVO> grapeFindData(String fd) {
		return dao.grapeFindData(fd);
	}
	
	@Override
	public int makerFindCount(String fd) {
		return dao.makerFindCount(fd);
	}
	
	@Override
	public List<MakerVO> makerFindData(String fd) {
		return dao.makerFindData(fd);
	}
	
	@Override
	public int nationFindCount(String fd) {
		return dao.nationFindCount(fd);
	}
	
	@Override
	public List<NationVO> nationFindData(String fd) {
		return dao.nationFindData(fd);
	}
}
