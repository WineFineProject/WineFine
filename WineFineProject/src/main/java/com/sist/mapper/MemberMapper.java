package com.sist.mapper;

import org.apache.ibatis.annotations.Select;

public interface MemberMapper {
	// ȸ�� ���̵� Ȯ��
	@Select("SELECT COUNT(*) FROM member WHERE id=#{id}")
	public int memberCountId(String id);
	
	// ȸ�� ��й�ȣ ã��
	@Select("SELECT pwd FROM member WHERE id=#{id}")
	public String memberGetPwd(String id);
	
}