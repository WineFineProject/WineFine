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
	public WineVO winebuy(int wno);
	public List<MyCouponVO> selectCoupon(String id);
	public MyCouponVO useCoupon(String id);
	public List<PromotionSaleVO> promotionGetSale(Map map);
	public List<WineVO> otherWine_maker(int wno);
	public List<WineVO> otherWine_seller(int wno);
	public String getPoint(String id);
	public List<DeliveryVO> getDeli(String id);

}