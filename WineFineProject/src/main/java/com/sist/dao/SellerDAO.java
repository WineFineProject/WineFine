package com.sist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.SellerMapper;
import com.sist.vo.ChartVO;

@Repository
public class SellerDAO {
	@Autowired
	private SellerMapper mapper;
	
	public List<Integer> sellerVisitWeeks(String pageid){
		return mapper.sellerVisitWeeks(pageid);
	}
	public int sellerVisitMax(String pageid) {
		return mapper.sellerVisitMax(pageid);
	}
	public List<ChartVO> sellerSellTypePrice(String userid){
		return mapper.sellerSellTypePrice(userid);
	}
	public List<ChartVO> sellerSellTypeAccount(String userid){
		return mapper.sellerSellTypeAccount(userid);
	}
	
	public List<ChartVO> sellerAddrPrice(String userid){
		return mapper.sellerAddrPrice(userid);
	}
}
