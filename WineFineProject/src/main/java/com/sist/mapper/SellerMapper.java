package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.sist.vo.ChartVO;

public interface SellerMapper {
	public List<Integer> sellerVisitWeeks(String pageid);
	@Select("SELECT max(count(*)) FROM wine_visit WHERE trunc(visitdate) BETWEEN trunc(sysdate-6) AND trunc(sysdate) AND pageid=#{pageid} GROUP BY trunc(visitdate)")
	public int sellerVisitMax(String pageid);
	public List<ChartVO> sellerSellTypePrice(String userid);
	public List<ChartVO> sellerSellTypeAccount(String userid);
	public List<ChartVO> sellerAddrPrice(String userid);
}
