package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;

import com.sist.vo.*;

public interface CartMapper {
	// 추가
	@Insert("INSERT INTO cart(cno,id,wno,price,count) "
			+ "VALUES(cart_cno_seq.NEXTVAL,#{id},#{wno},#{price},#{count})")
	public int addCart(CartVO vo);
	
	// 수정(개수 변경)
	
	// 삭제
}
