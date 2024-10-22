package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.SellerDAO;
import com.sist.vo.ChartVO;

@Service
public class SellerServiceImpl implements SellerService{
	@Autowired
	private SellerDAO dao;
	
	@Override
	public List<Integer> sellerVisitWeeks(String pageid) {
		return dao.sellerVisitWeeks(pageid);
	}

	@Override
	public int sellerVisitMax(String pageid) {
		return dao.sellerVisitMax(pageid);
	}

	@Override
	public List<ChartVO> sellerSellTypePrice(String userid) {
		return dao.sellerSellTypePrice(userid);
	}

	@Override
	public List<ChartVO> sellerSellTypeAccount(String userid) {
		return dao.sellerSellTypeAccount(userid);
	}

	@Override
	public List<ChartVO> sellerAddrPrice(String userid) {
		return dao.sellerAddrPrice(userid);
	}
}