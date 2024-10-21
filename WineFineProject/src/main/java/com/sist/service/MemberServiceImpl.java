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
	public List<MemberVO> memberList(int start, int end) {
		// TODO Auto-generated method stub
		return dao.memberList(start, end);
	}
	@Override
	public int memberCount() {
		// TODO Auto-generated method stub
		return dao.memberCount();
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
	public List<MemberVO> adminmemberList(int start, int end) {
		// TODO Auto-generated method stub
		return dao.adminmemberList(start, end);
	}
	@Override
	public int adminmemberCount() {
		// TODO Auto-generated method stub
		return dao.adminmemberCount();
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
	@Override
	public void insertAuthority(String userId) {
		dao.insertAuthority(userId);
	}
	@Override
	public void insertMember(MemberVO vo) {
		dao.insertMember(vo);
	}
	@Override
	public MemberVO memberSessionData(String userId) {
		return dao.memberSessionData(userId);
	}
	@Override
	public void memberLastLogin(String userId) {
		dao.memberLastLogin(userId);
	}
	@Override
	public void gradeIncrement(String userId) {
		// TODO Auto-generated method stub
		dao.gradeIncrement(userId);
	}
	@Override
	public void gradeDecrement(String userId) {
		// TODO Auto-generated method stub
		dao.gradeDecrement(userId);
	}
	
	@Override
	public void visitCheck(String pageid) {
		dao.visitCheck(pageid);
	}
	@Override
	public List<MemberVO> memberWait() {
		// TODO Auto-generated method stub
		return dao.memberWait();
	}
	@Override
	public void accessMember(String id) {
		// TODO Auto-generated method stub
		dao.accessMember(id);
	}
	@Override
	public void noAccessMember(String id) {
		// TODO Auto-generated method stub
		dao.noAccessMember(id);
	}
}
