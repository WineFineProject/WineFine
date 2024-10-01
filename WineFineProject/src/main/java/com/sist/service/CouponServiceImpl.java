package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CouponDAO;
import com.sist.vo.PromotionCouponVO;

@Service
public class CouponServiceImpl implements CouponService{
	@Autowired
	private CouponDAO dao;
	@Override
	public void promotionCouponInput(PromotionCouponVO vo) {
		dao.promotionCouponInput(vo);
	}
}
