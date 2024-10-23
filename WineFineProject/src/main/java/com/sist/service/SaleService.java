package com.sist.service;

import java.util.List;

import com.sist.vo.PromotionSaleVO;

public interface SaleService {
	public void promotionSaleInput(PromotionSaleVO vo);
	public void promotionApproval(int psno);
	public void promotionRejection(int psno);
	public List<PromotionSaleVO> saleWaitList(String id);
	public List<PromotionSaleVO> saleActiveList(String id);
	public List<PromotionSaleVO> sellerSaleActiveList(String id);
	public void promotionSaleEndUpdate();
	public void saleDelete(int pbno);
}
