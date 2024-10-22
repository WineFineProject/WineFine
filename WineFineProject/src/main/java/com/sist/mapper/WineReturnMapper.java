package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;

import com.sist.vo.WineReturnVO;

public interface WineReturnMapper {
	@Insert("INSERT INTO wine_return VALUES((SELECT NVL(MAX(reno)+1, 1) FROM wine_return), #{sendid}, #{recvid}, #{wpno}, #{content}, #{subject}, sysdate)")
	public void returnRequestInsert(WineReturnVO vo);
}
