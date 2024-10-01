package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;

import com.sist.vo.PromotionCouponVO;

public interface CouponMapper {
	// 쿠폰 프로모션 등록
	@Insert("INSERT INTO promotion_coupon VALUES((SELECT NVL(MAX(PCNO), 1) FROM promotion_coupon), "
			+ "#{title}, #{userid}, #{discount}, #{type}, #{target}, #{startDay}, #{endDay}, 0)")
	public void promotionCouponInput(PromotionCouponVO vo);
}
