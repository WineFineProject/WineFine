package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CartDAO;
import com.sist.vo.CartVO;
import com.sist.vo.WineVO;

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
		
		return dao.cartListData(id);
	}
	@Override
	public WineVO getWine(int wno,int cno) {
		// TODO Auto-generated method stub
		return dao.getWine(wno,cno);
	}
	@Override
	public int updateCart(int cno, int count, String id) {
		// TODO Auto-generated method stub
		return dao.updateCart(cno, count, id);
	}
	@Override
	public int delCart(int cno) {
		// TODO Auto-generated method stub
		return dao.delCart(cno);
	}

}
