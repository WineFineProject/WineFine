package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.ChartVO;

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
}
