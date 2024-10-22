package com.sist.dao;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAO {
	@Autowired
	private ShopMapper mapper;
	
//	占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈윪�억옙 �뜝�럥�렓�뜝�럥遊얕짆�쉩�쐻占쎈윥獄�占� �뜝�럥�돯�뜝�럥痢듿뜝�럩議�
	public List<WineVO> wineListData(int start,int end){
		return mapper.wineListData(start, end);
	}

//	占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈윪�억옙 �뜝�럥竊륅옙�쐻�뜝占� 占쎈쐻占쎈윥占쎌뱻占쎈쐻占쎈윪�얠쥉異�占쎌돸占쎌굲
	public int shopTotalPage() {
		return mapper.shopTotalPage();
	}
//	�뜝�럡留믣뜝�럡�돪�솻洹ｋ뼬�뵳占�
	public WineVO wineDetailData(int wno) {
	    mapper.hitIncrement(wno);
	    return mapper.wineDetailData(wno);
	}
// 	�뜝�럥竊쀥뜝�럥利꿰춯瑜낆삕 �뤆�룊�삕�뜝�럩二у뜝�럩沅롧뼨�먯삕
	public List<String> grapeName(int wno) {
		return mapper.grapeName(wno);
	}
//	�뜝�럡�룎�뜝�럩逾х춯瑜낆삕 �뤆�룊�삕�뜝�럩二у뜝�럩沅롧뼨�먯삕
	public List<String> nationName(int wno){
		return mapper.nationName(wno);
	}

//	占쏙옙占쎌뵥�뤃�됤꼻
	public WineVO winebuy(int wno) {
		return mapper.winebuy(wno);
	}
//	占쎄텢占쎌뒠 揶쏉옙占쎈뮟占쎈립 �뜎醫뤿？ �뵳�딅뮞占쎈뱜
	public List<MyCouponVO> selectCoupon(String id) {
		return mapper.selectCoupon(id);
	}
//	占쎈막占쎌뵥占쎌몛占쎌뵠 揶쏉옙占쎌삢 占쎈꼥占쏙옙 占쎈늄嚥≪뮆�걟占쎈�� 占쎌넇占쎌뵥占쎈릭疫뀐옙
	public List<PromotionSaleVO> promotionGetSale(Map map) {
		return mapper.promotionGetSale(map);
	}
//	�깮�궛�옄�쓽 �떎瑜� ���씤
	public List<WineVO> otherWine_maker(int wno){
		return mapper.otherWine_maker(wno);
	}	
//	�뙋留ㅼ옄�쓽 �떎瑜� ���씤
	public List<WineVO> otherWine_seller(int wno){
		return mapper.otherWine_seller(wno);
	}
//	�룷�씤�듃 媛��졇�삤湲�
	public String getPoint(String id) {
		return mapper.getPoint(id);
	}

//	�쉶�썝 �벑湲� 媛��졇�삤湲�
	public String getgrade(String id) {
		return mapper.getgrade(id);
	}

//	諛곗넚吏� 媛��졇�삤湲�
	public List<DeliveryVO> getDeli(String id) {
		return mapper.getDeli(id);
	}
	
	
//	�궗�슜 �쟻由쎄툑 李④컧�븯湲�

	public void usePoint (MemberVO vo) {
		mapper.usePoint(vo);
	}
	
//	寃곗젣 �쟻由쎄툑 異붽��븯湲�

	public void plusPoint (MemberVO vo) {
		mapper.plusPoint(vo);
	}
	
//	荑좏룿 �궗�슜

	public void useCoupon(MyCouponVO vo) {
		mapper.useCoupon(vo);
	}	
	
//	�옣諛붽뎄�땲 異붽�
	public void insertCart(Wine_CartVO vo) {
		mapper.insertCart(vo);
	}
//	�옣諛붽뎄�땲 �닔�웾 異붽�
	public void wineCartAccountUpdate(Wine_CartVO vo) {
		mapper.wineCartAccountUpdate(vo);
	}
	public int wineCartwnoCount(int wno) {
		return mapper.wineCartwnoCount(wno);
	}
	
//	援щℓ 異붽�
	public void insertPayment(Wine_PaymentVO vo) {
		mapper.insertPayment(vo);
	}
	public void wineBuyAccountUpdate(Wine_PaymentVO vo) {
		mapper.wineBuyAccountUpdate(vo);
	}
	public int wineBuywpnoCount(int wpno) {
		return mapper.wineBuywpnoCount(wpno);
	}
// 	�떊怨좏븯湲�
	public void insertReport (Wine_ReportVO vo) {
		mapper.insertReport(vo);
	}
	public int wineCount() {
		return mapper.wineCount();
	}

	public LikeVO wineLikeOff (LikeVO lvo) {
		return mapper.wineLikeOff(lvo);
	}
	public LikeVO wineLikeOn (LikeVO lvo) {
		return mapper.wineLikeOn(lvo);
	}
	
	public String selectUsername (int wno) {
		return mapper.selectUsername(wno);
	}

	public List<WineVO> wineFilter(Map map){
		return mapper.wineFilter(map);
	}
	
	




	
}






