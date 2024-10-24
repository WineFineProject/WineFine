package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.SellerDAO;
import com.sist.vo.ChartVO;

@Service
public class SellerServiceImpl implements SellerService {
	@Autowired
	private SellerDAO dao;

	@Override
	public List<Integer> sellerVisitWeeks(String pageid) {
		return dao.sellerVisitWeeks(pageid);
	}

	@Override
	public int sellerVisitMax(String pageid) {
		return dao.sellerVisitMax(pageid);
	}

	@Override
	public List<ChartVO> sellerSellTypePrice(String userid) {
		return dao.sellerSellTypePrice(userid);
	}

	@Override
	public List<ChartVO> sellerSellTypeAccount(String userid) {
		return dao.sellerSellTypeAccount(userid);
	}

	@Override
	public List<ChartVO> sellerAddrPrice(String userid) {
		return dao.sellerAddrPrice(userid);
	}

	@Override
	public int sellerGetAccPoint(String userid) {
		return dao.sellerGetAccPoint(userid);
	}

	@Override
	public Map<String, Integer> sellerMoreInfoCount(String userid) {
		return dao.sellerMoreInfoCount(userid);
	}

	@Override
	public Map<String, Integer> sellerPaymentInfoCount(String userid) {
		return dao.sellerPaymentInfoCount(userid);
	}
	
	@Override
	public List<ChartVO> sellerWeekChart(String userid) {
		return dao.sellerWeekChart(userid);
	}

	@Override
	public List<ChartVO> sellerSalePromotionChart(int psno) {
		return dao.sellerSalePromotionChart(psno);
	}

	@Override
	public List<ChartVO> sellerCouponPromotionChart(int pcno) {
		return dao.sellerCouponPromotionChart(pcno);
	}

	@Override
	public List<ChartVO> sellerBannerPromotionChart(int pbno) {
		return dao.sellerBannerPromotionChart(pbno);
	}
}
