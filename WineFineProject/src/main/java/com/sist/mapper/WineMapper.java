package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface WineMapper {
	//와인 목록 출력
	public List<WineVO> wineListData(Map map);
	
	//와인 검색 목록 출력
	public List<WineVO> wineFindList(String fd);
	
	//와인 페이지 출력
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int wineTotalPage();

	
}
