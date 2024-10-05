package com.sist.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.vo.CartVO;


public interface CartService {
	public String addCart(CartVO vo);
	public List<CartVO> cartListData(String id);
}
