package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sist.vo.*;
import com.sist.mapper.*;
import java.util.*;

@Repository
public class SaleDAO {
	@Autowired
	private SaleMapper mapper;

	public void promotionSaleInput(PromotionSaleVO vo) {
		mapper.promotionSaleInput(vo);
	}

	public void promotionApproval(int psno) {
		mapper.promotionApproval(psno);
	}

	public void promotionRejection(int psno) {
		mapper.promotionRejection(psno);
	}

	public List<PromotionSaleVO> saleWaitList(String id) {
		return mapper.saleWaitList(id);
	}

	public List<PromotionSaleVO> saleActiveList(String id) {
		return mapper.saleActiveList(id);
	}

	public List<PromotionSaleVO> sellerSaleActiveList(String id) {
		return mapper.sellerSaleActiveList(id);
	}
}
