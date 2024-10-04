package com.sist.service;

import java.util.List;

import com.sist.vo.MemberVO;

public interface MemberService {
	public String memberLogin(String id, String pwd);
	public List<MemberVO> memberList(); 
	public void deleteMember(String id); 
	public MemberVO memberDetail(String id); 
    public void updateMember(MemberVO member); 
}
