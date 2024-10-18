package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MemberMapper;
import com.sist.vo.BlackListVO;
import com.sist.vo.MemberVO;

@Repository
public class MemberDAO {
	@Autowired
	private MemberMapper mapper;

	public String memberLogin(String id, String pwd) {
		String result = "NO";
		int count = mapper.memberCountId(id);
		if (count == 0)
			result = "NOID";
		else {
			String tmp = mapper.memberGetPwd(id);
			if (tmp.equals(pwd)) {
				result = "OK";
			} else {
				result = "NOPWD";
			}
		}
		return result;
	}

	// �쉶�썝 紐⑸줉 議고쉶
	public List<MemberVO> memberList(int start, int end) {
		return mapper.memberList(start, end);
	}

	public int memberCount() {
		return mapper.memberCount();
	}
	
	// 愿�由ъ옄 �쉶�썝 紐⑸줉 議고쉶
	public List<MemberVO> adminmemberList(int start, int end) {
		return mapper.adminmemberList(start, end);
	}
	
	public int adminmemberCount() {
		return mapper.adminmemberCount();
	}
    // 등급 조절
	public void gradeIncrement(String userId)
	{
		mapper.gradeIncrement(userId);
	}
	
	public void gradeDecrement(String userId)
	{
		mapper.gradeDecrement(userId);
	}
	
	// �쉶�썝 �궘�젣
	public void deleteMember(String id) {
		mapper.deleteMember(id);
	}

	// �쉶�썝 �긽�꽭 議고쉶
	public MemberVO memberDetail(String id) {
		return mapper.memberDetail(id);
	}

	// �쉶�썝 �젙蹂� �닔�젙
	public void updateMember(MemberVO member) {
		mapper.updateMember(member);
	}
	
	public int memberPhoneCheck(String phone) {
		return mapper.memberPhoneCheck(phone);
	}
	
	public int memberEmailCheck(String email) {
		return mapper.memberEmailCheck(email);
	}
	
	public int memberNickCheck(String nickName) {
		return mapper.memberNickCheck(nickName);
	}
	
	public int memberIdCheck(String userId) {
		return mapper.memberIdCheck(userId);
	}
	
	public void insertAuthority(String userId) {
		mapper.insertAuthority(userId);
	}
  public void insertMember(MemberVO vo) {
  	mapper.insertMember(vo);
  }
  public MemberVO memberSessionData(String userId) {
  	return mapper.memberSessionData(userId);
  }
  public void memberLastLogin(String userId) {
  	mapper.memberLastLogin(userId);
  }
}
