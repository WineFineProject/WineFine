package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.WineMapper;
import com.sist.vo.WineVO;
import java.util.*;

@Repository
public class WineDAO {
	@Autowired
	private WineMapper mapper;
	
	public List<WineVO> wineListData(Map map){
		return mapper.wineListData(map);
	}
	
	public int wineTotalPage() {
		return mapper.wineTotalPage();
	}
	
	public List<WineVO> wineFindList(Map map){
		return mapper.wineFindList(map);
	}
}
