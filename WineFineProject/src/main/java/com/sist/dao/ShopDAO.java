package com.sist.dao;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAO {
	@Autowired
	private ShopMapper mapper;
	
//	�뜝�룞�삕�뜝�럩逾� 占쎈뎨占쎈봾裕욃뜝�럥諭� 占쎈퉲占쎈츊占쎌졑
	public List<WineVO> wineListData(int start,int end){
		return mapper.wineListData(start, end);
	}
//	�뜝�룞�삕�뜝�럩逾� 占쎈／�뜝占� �뜝�럥�쓡�뜝�럩逾좂춯�쉻�삕
	public int shopTotalPage() {
		return mapper.shopTotalPage();
	}
//	占쎄맒占쎄쉭癰귣떯由�
	public WineVO wineDetailData(int wno) {
	    mapper.hitIncrement(wno);
	    return mapper.wineDetailData(wno);
	}
// 	占쎈７占쎈즲筌륅옙 揶쏉옙占쎌죬占쎌궎疫뀐옙
	public List<String> grapeName(int wno) {
		return mapper.grapeName(wno);
	}
//	占쎄돌占쎌뵬筌륅옙 揶쏉옙占쎌죬占쎌궎疫뀐옙
	public List<String> nationName(int wno){
		return mapper.nationName(wno);
	}

//	���씤援щℓ
	public WineVO winebuy(int wno) {
		return mapper.winebuy(wno);
	}
//	�궗�슜 媛��뒫�븳 荑좏룿 由ъ뒪�듃
	public List<MyCouponVO> selectCoupon(String id) {
		return mapper.selectCoupon(id);
	}
//	荑좏룿 �궗�슜�븯湲�
	public MyCouponVO useCoupon(String id) {
		return mapper.useCoupon(id);
	}
//	�븷�씤�쑉�씠 媛��옣 �넂�� �봽濡쒕え�뀡 �솗�씤�븯湲�
	public List<PromotionSaleVO> promotionGetSale(Map map) {
		return mapper.promotionGetSale(map);
	}
//	생산자의 다른 와인
	public List<WineVO> otherWine_maker(int wno){
		return mapper.otherWine_maker(wno);
	}	
//	판매자의 다른 와인
	public List<WineVO> otherWine_seller(int wno){
		return mapper.otherWine_seller(wno);
	}
//	포인트 가져오기
	public String getPoint(String id) {
		return mapper.getPoint(id);
	}
//	배송지 가져오기
	public List<DeliveryVO> getDeli(String id) {
		return mapper.getDeli(id);
	}





	
}






