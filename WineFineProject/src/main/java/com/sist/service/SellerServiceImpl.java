package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.SellerDAO;

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

}
