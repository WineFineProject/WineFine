package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.sist.vo.*;

public interface CouponMapper {
	// ���� ���θ�� ���
	@Insert("INSERT INTO promotion_coupon VALUES((SELECT NVL(MAX(PCNO)+1, 1) FROM promotion_coupon), "
			+ "#{title}, #{userid}, #{discount}, #{type}, #{target}, #{startDay}, #{endDay}, 0)")
	public void promotionCouponInput(PromotionCouponVO vo);
	
	public List<PromotionCouponVO> promotionWaitList(String id);
	
	public List<PromotionCouponVO> promotionActiveList(String id);
	
	// ���� ��� ���� ����
	@Update("UPDATE promotion_coupon SET state=1 WHERE pcno=#{pcno}")
	public void promotionApproval(int pcno);
	
	// ���� ��� ���� ����
	@Update("Update promotion_coupon SET state=2 WHERE pcno=#{pcno}")
	public void promotionRejection(int pcno);
	
	// mypage ��� ���� ����
	public List<MyCouponVO> mypageMyCouponList(String id);
	
	public List<PromotionCouponVO> promotionCouponListData(String id);
	
	public void getCoupon(MyCouponVO vo);
	
	public List<PromotionCouponVO> sellerPromotionActiveList(String id);
}
