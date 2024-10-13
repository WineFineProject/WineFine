package com.sist.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sist.vo.MemberVO;

public interface MemberService {
	public String memberLogin(String id, String pwd);
	public List<MemberVO> memberList();
	public List<MemberVO> adminmemberList(int start, int end);
	public int adminmemberCount();
	public void deleteMember(String id);
	public MemberVO memberDetail(String id);
	public void updateMember(MemberVO member);
	public int memberPhoneCheck(String phone);
	public int memberEmailCheck(String email);
	public int memberNickCheck(String nickName);
	public int memberIdCheck(String userId);
	public void insertAuthority(String userId);
  public void insertMember(MemberVO vo);
  public MemberVO memberSessionData(String userId);
}
