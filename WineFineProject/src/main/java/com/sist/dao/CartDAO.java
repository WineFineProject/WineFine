package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CartMapper;
import com.sist.vo.CartVO;
import com.sist.vo.WineVO;

@Repository
public class CartDAO {
	@Autowired
	private CartMapper mapper;
	
	public String addCart(CartVO vo) {
		return mapper.addCart(vo);
	}
	
	public WineVO getWine(int wno,int cno) {
		return mapper.getWine(wno,cno);
	}

	public int updateCart(int cno,int count,String id)
	{
		return mapper.updateCart(cno, count, id);
	}

	public int delCart(int cno) {
		return mapper.delCart(cno);
	}
	
	public int myCartCount(String userId) {
		return mapper.myCartCount(userId);
	}
	public List<CartVO> cartListData(Map map){
		return mapper.cartListData(map);
	}
	public int cartTotalPage(Map map) {
		return mapper.cartTotalPage(map);
	}
	public void deleteCart(int cno) {
		mapper.deleteCart(cno);
	}
}
