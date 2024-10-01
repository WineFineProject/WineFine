package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.sist.vo.*;

public interface CouponMapper {
	// 쿠폰 프로모션 등록
	@Insert("INSERT INTO promotion_coupon VALUES((SELECT NVL(MAX(PCNO), 1) FROM promotion_coupon), "
			+ "#{title}, #{userid}, #{discount}, #{type}, #{target}, #{startDay}, #{endDay}, 0)")
	public void promotionCouponInput(PromotionCouponVO vo);
	
	public List<PromotionCouponVO> promotionCouponListData(String id);
	
	public void getCoupon(MyCouponVO vo);
	
}
