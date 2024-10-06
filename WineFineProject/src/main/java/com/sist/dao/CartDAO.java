package com.sist.dao;

import java.util.List;

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
	
	public List<CartVO> cartListData(String id){
		return mapper.cartListData(id);
	}	
	
	public WineVO getWine(int wno) {
		return mapper.getWine(wno);
	}

	public int updateCart(int cno,int count,String id)
	{
		return mapper.updateCart(cno, count, id);
	}

	public int delCart(int cno) {
		return mapper.delCart(cno);
	}
	
}
