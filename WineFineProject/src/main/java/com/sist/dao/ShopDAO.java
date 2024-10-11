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
	
//	占쏙옙占쎌뵥 �뵳�딅뮞占쎈뱜 �빊�뮆�젾
	public List<WineVO> wineListData(int start,int end){
		return mapper.wineListData(start, end);
	}
//	占쏙옙占쎌뵥 �룯占� 占쎈읂占쎌뵠筌욑옙
	public int shopTotalPage() {
		return mapper.shopTotalPage();
	}
//	�긽�꽭蹂닿린
	public WineVO wineDetailData(int wno) {
	    mapper.hitIncrement(wno);
	    return mapper.wineDetailData(wno);
	}
// 	�룷�룄紐� 媛��졇�삤湲�
	public List<String> grapeName(int wno) {
		return mapper.grapeName(wno);
	}
//	�굹�씪紐� 媛��졇�삤湲�
	public List<String> nationName(int wno){
		return mapper.nationName(wno);
	}

//	와인구매
	public WineVO winebuy(int wno) {
		return mapper.winebuy(wno);
	}
//	사용 가능한 쿠폰 리스트
	public List<MyCouponVO> selectCoupon(String id) {
		return mapper.selectCoupon(id);
	}
//	쿠폰 사용하기
	public MyCouponVO useCoupon(String id) {
		return mapper.useCoupon(id);
	}
//	할인율이 가장 높은 프로모션 확인하기
	public PromotionSaleVO promotionGetSale(Map map) {
		return mapper.promotionGetSale(map);
	}





	
}







