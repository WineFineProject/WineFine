package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

import java.util.*;

public interface CartMapper {
	// 추가
	@Insert("INSERT INTO cart(cno,id,wno,price,count) "
			+ "VALUES(cart_cno_seq.NEXTVAL,#{id},#{wno},#{price},#{count})")
	public String addCart(CartVO vo);
	
	// 목록
	@Select("SELECT c.cno,w.wno,w.namekor,w.poster,w.price,c.count "
			+ "FROM cart c,wine w "
			+ "WHERE c.id=#{id} AND w.wno=c.wno")
	public List<CartVO> cartListData(String id);
	
	// 수정(개수 변경)
	
	// 삭제
	 
	
}
