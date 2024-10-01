package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CouponMapper;
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
}
