package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MemberDAO;
import com.sist.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO dao;
	@Override
	public String memberLogin(String id, String pwd) {
		return dao.memberLogin(id, pwd);
	}
	@Override
	public List<MemberVO> memberList() {
		// TODO Auto-generated method stub
		return dao.memberList();
	}
	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		dao.deleteMember(id);
	}
	@Override
	public MemberVO memberDetail(String id) {
		// TODO Auto-generated method stub
		return dao.memberDetail(id);
	}
	@Override
	public void updateMember(MemberVO member) {
		// TODO Auto-generated method stub
		dao.deleteMember(null);
	}
	@Override
	public List<MemberVO> adminmemberList() {
		// TODO Auto-generated method stub
		return dao.adminmemberList();
	}
	@Override
	public int memberEmailCheck(String email) {
		return dao.memberEmailCheck(email);
	}
	@Override
	public int memberIdCheck(String userId) {
		return dao.memberIdCheck(userId);
	}
	@Override
	public int memberNickCheck(String nickName) {
		return dao.memberNickCheck(nickName);
	}
	@Override
	public int memberPhoneCheck(String phone) {
		return dao.memberPhoneCheck(phone);
	}
}
