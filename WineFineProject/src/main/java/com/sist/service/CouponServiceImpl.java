package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CouponDAO;
import com.sist.vo.MyCouponVO;
import com.sist.vo.PromotionCouponVO;

@Service
public class CouponServiceImpl implements CouponService{
	@Autowired
	private CouponDAO dao;
	@Override
	public void promotionCouponInput(PromotionCouponVO vo) {
		dao.promotionCouponInput(vo);
	}
	@Override
	public List<PromotionCouponVO> promotionCouponListData(String id) {
		return dao.promotionCouponListData(id);
	}
	
	@Override
	public void getCoupon(MyCouponVO vo) {
		dao.getCoupon(vo);
	}
	@Override
	public List<PromotionCouponVO> promotionActiveList(String id) {
		return dao.promotionActiveList(id);
	}
	@Override
	public List<PromotionCouponVO> promotionWaitList() {
		return dao.promotionWaitList();
	}
	@Override
	public void promotionApproval(int pcno) {
		dao.promotionApproval(pcno);
	}
	@Override
	public void promotionRejection(int pcno) {
		dao.promotionRejection(pcno);
	}
	@Override
	public List<MyCouponVO> mypageMyCouponList(String id) {
		return dao.mypageMyCouponList(id);
	}
	@Override
	public List<PromotionCouponVO> sellerPromotionActiveList(String id) {
		return dao.sellerPromotionActiveList(id);
	}
	
	@Override
	public List<PromotionCouponVO> sellerPromotionWaitList(String id) {
		return dao.sellerPromotionWaitList(id);
	}
	@Override
	public void promotionCouponEndUpdate() {
		dao.promotionCouponEndUpdate();
	}
}
