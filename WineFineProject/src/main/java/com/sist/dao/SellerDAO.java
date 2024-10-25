package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.SellerMapper;
import com.sist.vo.ChartVO;
import com.sist.vo.PromotionBannerVO;
import com.sist.vo.PromotionCouponVO;
import com.sist.vo.PromotionSaleVO;

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
	
	public int sellerGetAccPoint(String userid) {
		return mapper.sellerGetAccPoint(userid);
	}
	public Map<String, Integer> sellerMoreInfoCount(String userid){
		return mapper.sellerMoreInfoCount(userid);
	}
	public Map<String, Integer> sellerPaymentInfoCount(String userid){
		return mapper.sellerPaymentInfoCount(userid);
	}
	public List<ChartVO> sellerWeekChart(String userid){
		return mapper.sellerWeekChart(userid);
	}
	public List<ChartVO> sellerSalePromotionChart(int psno){
		return mapper.sellerSalePromotionChart(psno);
	}
	public List<ChartVO> sellerCouponPromotionChart(int pcno){
		return mapper.sellerCouponPromotionChart(pcno);
	}
	public List<ChartVO> sellerBannerPromotionChart(int pbno){
		return mapper.sellerBannerPromotionChart(pbno);
	}
	public ChartVO sellerVisitChart(String userid) {
		return mapper.sellerVisitChart(userid);
	}
	
	public List<PromotionCouponVO> chartCouponList(String userid){
		return mapper.chartCouponList(userid);
	}
	public List<PromotionBannerVO> chartBannerList(String userid){
		return mapper.chartBannerList(userid);
	}
	public List<PromotionSaleVO> chartSaleList(String userid){
		return mapper.chartSaleList(userid);
	}
}
