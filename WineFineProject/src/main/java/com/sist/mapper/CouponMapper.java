package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.sist.vo.*;

public interface CouponMapper {
	// ���� ���θ�� ���
	@Insert("INSERT INTO promotion_coupon VALUES((SELECT NVL(MAX(PCNO)+1, 1) FROM promotion_coupon), "
			+ "#{title}, #{userid}, #{discount}, #{type}, #{target}, #{startDay}, #{endDay}, 0)")
	public void promotionCouponInput(PromotionCouponVO vo);
	
	// ���δ�� ���� ���
	@Select("SELECT pcno, title, userid, discount, type, target, TO_CHAR(startdate, 'YYYY-MM-DD') as startDay, TO_CHAR(enddate, 'YYYY-MM-DD') as endDay "
			+ "FROM promotion_coupon WHERE enddate>sysdate AND state=0 AND userid LIKE '%'||#{id}||'%'")
	public List<PromotionCouponVO> promotionWaitList(String id);
	
	// �������� ���� ���
	@Select("SELECT pcno, title, userid, discount, type, target, TO_CHAR(startdate, 'YYYY-MM-DD') as startDay, TO_CHAR(enddate, 'YYYY-MM-DD') as endDay "
			+ "FROM promotion_coupon WHERE (sysdate BETWEEN startdate AND endDate) AND state=1 AND userid LIKE '%'||#{id}||'%'")
	public List<PromotionCouponVO> promotionActiveList(String id);
	
	// ���� ��� ���� ����
	@Update("UPDATE promotion_coupon SET state=1 WHERE pcno=#{pcno}")
	public void promotionApproval(int pcno);
	
	// ���� ��� ���� ����
	@Update("Update promotion_coupon SET state=2 WHERE pcno=#{pcno}")
	public void promotionRejection(int pcno);
	
	
	public List<PromotionCouponVO> promotionCouponListData(String id);
	
	public void getCoupon(MyCouponVO vo);
	
}
