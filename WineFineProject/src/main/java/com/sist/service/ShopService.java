package com.sist.service;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface ShopService {
	public List<WineVO> wineListData(int start,int end);
	public List<WineVO> wineListData2(Map map);
	
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
	public int wineCount();
	public LikeVO wineLikeOff (LikeVO lvo);
	public LikeVO wineLikeOn (LikeVO lvo);
//	신고
	public void insertReport (Wine_ReportVO vo);
	public List<WineVO> adminWineList(Map map);;
	public int adminWinePage();
	public List<Wine_PaymentVO> myPaymentList(Map map);
	public int myPaymentTotalPage(Map map);
	public String selectUsername (int wno);
	public String getSeller(int wno);

//	와인 리스트 + 필터
	public List<WineVO> wineFilter(Map map);
	public int wineTotalCount(Map map);
	
	// 신고
	public void reportWineUpdate(int wno);
	
	// 구매 업데이트
	public void paymentStateUpdate1();
	public void paymentStateUpdate2();
	public void paymentStateUpdate3();
	public List<Wine_PaymentVO> paymentGetAccount();
	public void wineStackUpdate(Wine_PaymentVO vo);
	public void sellerAccUpdate(Wine_PaymentVO vo);
	public void paymentReturnReques(int wpno);
	
	public List<LikeVO> myLikeList(Map map);
	public int myLikeTotalPage(Map map);
	public void likeDelete(int rno);
	
	
	// 셀러 홈
	public Map<String, Integer> sellerHomeSaleInfo(String userid);
	public Map<String, Integer> sellerHomeWineInfo(String userid);
	
	
	public int isPro (Map map);
	
	public List<WineVO> adminAllWineList(Map map);
	public int adminWinetotalCount(Map map);
//	구매자 찾기	
	public int findBuyer (int wno, String userid);
//	블랙 대상 찾기
	public int blackList (String userid,String seller);
	public WineVO wineDetail(int wno);
	
	public void wineAccept(int wno);
	public void wineRejection(int wno);
}