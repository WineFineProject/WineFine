package com.sist.mapper;

import org.apache.ibatis.annotations.Select;

public interface MemberMapper {
	// 회원 아이디 확인
	@Select("SELECT COUNT(*) FROM member WHERE id=#{id}")
	public int memberCountId(String id);
	
	// 회원 비밀번호 찾기
	@Select("SELECT pwd FROM member WHERE id=#{id}")
	public String memberGetPwd(String id);
	
}