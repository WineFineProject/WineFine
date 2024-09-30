package com.sist.mapper;

import org.apache.ibatis.annotations.Select;

public interface MemberMapper {
	@Select("SELECT COUNT(*) FROM member WHERE id=#{id}")
	public int memberCountId(String id);
	
	@Select("SELECT pwd FROM member WHERE id=#{id}")
	public String memberGetPwd(String id);
	
}