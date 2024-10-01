package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CouponMapper;
import com.sist.vo.PromotionCouponVO;

@Repository
public class CouponDAO {
	@Autowired
	private CouponMapper mapper;
	
	public void promotionCouponInput(PromotionCouponVO vo) {
		mapper.promotionCouponInput(vo);
	}
}
