package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.ChartVO;
import com.sist.vo.PromotionBannerVO;
import com.sist.vo.PromotionCouponVO;
import com.sist.vo.PromotionSaleVO;

public interface SellerService {
	public List<Integer> sellerVisitWeeks(String pageid);
	public int sellerVisitMax(String pageid);
	public List<ChartVO> sellerSellTypePrice(String userid);
	public List<ChartVO> sellerSellTypeAccount(String userid);
	public List<ChartVO> sellerAddrPrice(String userid);
	public int sellerGetAccPoint(String userid);
	public Map<String, Integer> sellerMoreInfoCount(String userid);
	public Map<String, Integer> sellerPaymentInfoCount(String userid);
	public List<ChartVO> sellerWeekChart(String userid);
	public List<ChartVO> sellerSalePromotionChart(int psno);
	public List<ChartVO> sellerCouponPromotionChart(int pcno);
	public List<ChartVO> sellerBannerPromotionChart(int pbno);
	public ChartVO sellerVisitChart(String userid);
	public List<PromotionCouponVO> chartCouponList(String userid);
	public List<PromotionBannerVO> chartBannerList(String userid);
	public List<PromotionSaleVO> chartSaleList(String userid);
}
