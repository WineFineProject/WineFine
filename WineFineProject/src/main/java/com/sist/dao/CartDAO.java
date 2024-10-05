package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CartMapper;
import com.sist.vo.CartVO;

@Repository
public class CartDAO {
	@Autowired
	private CartMapper mapper;
	
	public String addCart(CartVO vo) {
		return mapper.addCart(vo);
	}
	
	public List<CartVO> cartListData(String id){
		return mapper.cartListData(id);
	}	
	
}
