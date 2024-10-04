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
	public List<GrapeVO> grapeListData() {
		// TODO Auto-generated method stub
		return dao.grapeListData();
	}

	@Override
	public GrapeVO grapeDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.grapeDetailData(no);
	}

	@Override
	public List<NationVO> nationListData() {
		// TODO Auto-generated method stub
		return dao.nationListData();
	}
	
	@Override
	public NationVO nationDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.nationDetailData(no);
	}

	@Override
	public List<MakerVO> makerListData() {
		// TODO Auto-generated method stub
		return dao.makerListData();
	}

	@Override
	public MakerVO makerDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.makerDetailData(no);
	}

}
