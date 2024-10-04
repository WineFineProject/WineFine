package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.sist.dao.CartDAO;
import com.sist.vo.CartVO;

public class CartServiceImpl implements CartService{
	@Autowired
	private CartDAO dao;
	@Override
	public int addCart(CartVO vo) {
		return dao.addCart(vo);
	}

}
