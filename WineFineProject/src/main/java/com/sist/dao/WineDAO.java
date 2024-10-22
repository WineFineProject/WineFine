package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.WineMapper;
import com.sist.vo.WineVO;
import com.sist.vo.Wine_PaymentVO;

import java.util.*;

@Repository
public class WineDAO {
	@Autowired
	private WineMapper mapper;
	
	public List<WineVO> wineListData2(Map map){
		return mapper.wineListData2(map);
	}
	
	public int wineTotalCount(Map map) {
		return mapper.wineTotalCount(map);
	}
	
	public int wineTotalPage() {
		return mapper.wineTotalPage();
	}
	
	public List<WineVO> wineFindList(Map map){
		return mapper.wineFindList(map);
	}
	
	public List<WineVO> wineFindData(String fd){
		return mapper.wineFindData(fd);
	}
	
	public int wineFindCount(String fd) {
		return mapper.wineFindCount(fd);
	}
	
	public List<WineVO> adminWineList(Map map){
		return mapper.adminWineList(map);
	}
	public int adminWinePage() {
		return mapper.adminWinePage();
	}
	
	public List<Wine_PaymentVO> myPaymentList(Map map){
		return mapper.myPaymentList(map);
	}
	
	public int myPaymentTotalPage(Map map){
		return mapper.myPaymentTotalPage(map);
	}
	
	public String getSeller(int wno) {
		return mapper.getSeller(wno);
	}
}
