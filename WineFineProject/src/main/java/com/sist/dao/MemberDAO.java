package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MemberMapper;
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

	// 회원 목록 조회
	public List<MemberVO> memberList() {
		return mapper.memberList();
	}

	// 관리자 회원 목록 조회
	public List<MemberVO> adminmemberList() {
		return mapper.adminmemberList();
	}

	// 회원 삭제
	public void deleteMember(String id) {
		mapper.deleteMember(id);
	}

	// 회원 상세 조회
	public MemberVO memberDetail(String id) {
		return mapper.memberDetail(id);
	}

	// 회원 정보 수정
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
}
