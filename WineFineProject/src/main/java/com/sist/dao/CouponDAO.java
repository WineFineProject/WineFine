package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CouponMapper;
import com.sist.mapper.SaleMapper;
import com.sist.vo.*;

@Repository
public class CouponDAO {
	@Autowired
	private CouponMapper mapper;
	
	public void promotionCouponInput(PromotionCouponVO vo) {
		mapper.promotionCouponInput(vo);
	}
	
	public List<PromotionCouponVO> promotionCouponListData(String id){
		return mapper.promotionCouponListData(id);
	}
	
	public void getCoupon(MyCouponVO vo) {
		mapper.getCoupon(vo);
	}
	
	public List<PromotionCouponVO> promotionWaitList(){
		return mapper.promotionWaitList();
	}
	
	public List<PromotionCouponVO> promotionActiveList(String id){
		return mapper.promotionActiveList(id);
	}
	
	public void promotionApproval(int pcno) {
		mapper.promotionApproval(pcno);
	}
	
	public void promotionRejection(int pcno) {
		mapper.promotionRejection(pcno);
	}
	
	public List<MyCouponVO> mypageMyCouponList(String id){
		return mapper.mypageMyCouponList(id);
	}

	public List<PromotionCouponVO> sellerPromotionActiveList(String id){
		return mapper.sellerPromotionActiveList(id);
	}
	
	public List<PromotionCouponVO> sellerPromotionWaitList(String id){
		return mapper.sellerPromotionWaitList(id);
	}
	
	public void promotionCouponEndUpdate() {
		mapper.promotionCouponEndUpdate();
	}
	public void couponDelete(int pcno) {
		mapper.couponDelete(pcno);
	}
	
	public List<MyCouponVO> canUseCoupon(Map map){
		return mapper.canUseCoupon(map);
	}
}
