package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CartDAO;
import com.sist.vo.CartVO;

@Service
public class CartServiceImpl implements CartService{
	@Autowired
	private CartDAO dao;
	
	@Override
	public String addCart(CartVO vo) {
		return dao.addCart(vo);
	}
	@Override
	public List<CartVO> cartListData(String id) {
		// TODO Auto-generated method stub
		return dao.cartListData(id);
	}

}
