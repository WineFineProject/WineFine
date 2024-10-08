package com.sist.service;

import java.util.*;

import com.sist.vo.*;

public interface ShopService {
	public List<WineVO> wineListData(int start,int end);
	public int shopTotalPage();
	public List<WineVO> wineFindList(Map map);
	public WineVO wineDetailData(int wno);
	public List<String> grapeName(int wno);
	public List<String> nationName(int wno);

}
