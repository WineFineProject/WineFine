package com.sist.service;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Service;

import com.sist.vo.CartVO;
import com.sist.vo.WineVO;


public interface CartService {
	public String addCart(CartVO vo);
	public List<CartVO> cartListData(String id);
	public WineVO getWine(int wno);
	public int updateCart(int cno,int count,String id);
	public int delCart(int cno);
}
