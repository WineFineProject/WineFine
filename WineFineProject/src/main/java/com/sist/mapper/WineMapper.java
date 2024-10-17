package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface WineMapper {
	//���� ��� ���
	public List<WineVO> wineListData(Map map);
	
	//���� �˻� ��� ���
	public List<WineVO> wineFindList(Map map);
	
	//���� ������ ���
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int wineTotalPage();

	public List<WineVO> wineFindData(String fd);
	
}
