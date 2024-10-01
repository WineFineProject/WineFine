package com.sist.service;

import java.util.List;

import com.sist.vo.*;

public interface CouponService {
	public void promotionCouponInput(PromotionCouponVO vo);
	public List<PromotionCouponVO> promotionCouponListData(String id);
	public void getCoupon(MyCouponVO vo);
}
