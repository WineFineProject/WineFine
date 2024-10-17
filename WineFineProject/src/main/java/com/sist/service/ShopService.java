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
	public List<PromotionSaleVO> promotionGetSale(Map map);
	public List<WineVO> otherWine_maker(int wno);
	public List<WineVO> otherWine_seller(int wno);
//	포인트 가져오기
	public String getPoint(String id);
//	회원 등급 가져오기
	public String getgrade(String id);

	public List<DeliveryVO> getDeli(String id);
//	사용 적립금 차감하기
	public void usePoint (MemberVO vo);
//	결제 적립금 추가하기
	public void plusPoint (MemberVO vo);	
//	쿠폰 사용
	public void useCoupon(MyCouponVO vo);

//	장바구니 추가
	public void insertCart(Wine_CartVO vo);
//	장바구니 수량 추가
	public void wineCartAccountUpdate(Wine_CartVO vo);
	public int wineCartwnoCount(int wno);
//	구매
	public void insertPayment(Wine_PaymentVO vo);
	public void wineBuyAccountUpdate(Wine_PaymentVO vo);
	public int wineBuywpnoCount(int wpno);
	public List<WineVO> wineFindData(String fd);
	public int wineFindCount(String fd);
}