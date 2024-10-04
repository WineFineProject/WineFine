package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CartMapper;
import com.sist.vo.CartVO;

@Repository
public class CartDAO {
	@Autowired
	private CartMapper mapper;
	
	public int addCart(CartVO vo) {
		return mapper.addCart(vo);
	}
	
	
}
