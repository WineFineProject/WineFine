package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.SaleDAO;
import com.sist.vo.PromotionSaleVO;

@Service
public class SaleServiceImpl implements SaleService{
	@Autowired
	private SaleDAO dao;
	@Override
	public void promotionApproval(int psno) {
		dao.promotionApproval(psno);
	}
	@Override
	public void promotionRejection(int psno) {
		dao.promotionRejection(psno);
	}
	@Override
	public void promotionSaleInput(PromotionSaleVO vo) {
		dao.promotionSaleInput(vo);
	}
	@Override
	public List<PromotionSaleVO> saleActiveList(String id) {
		return dao.saleActiveList(id);
	}
	@Override
	public List<PromotionSaleVO> saleWaitList(String id) {
		return dao.saleWaitList(id);
	}
	@Override
	public List<PromotionSaleVO> sellerSaleActiveList(String id) {
		return dao.sellerSaleActiveList(id);
	}
}
