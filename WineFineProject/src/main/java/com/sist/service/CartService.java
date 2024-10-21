package com.sist.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Service;

import com.sist.vo.CartVO;
import com.sist.vo.WineVO;


public interface CartService {
	public String addCart(CartVO vo);
	public WineVO getWine(int wno,int cno);
	public int updateCart(int cno,int count,String id);
	public int delCart(int cno);
	public int myCartCount(String userId);
	public List<CartVO> cartListData(Map map);
	public int cartTotalPage(Map map);
	public void deleteCart(int cno);
}
