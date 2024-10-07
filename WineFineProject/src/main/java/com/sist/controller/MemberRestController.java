package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;
import java.util.*;

import javax.servlet.http.HttpSession;

@RestController
public class MemberRestController {
	@Autowired
	private MemberService mService;


	// 회원 목록 페이지
	@GetMapping(value = "seller/memberListVue.do", produces = "text/plain;charset=UTF-8")
	public String memberList() throws Exception {
		List<MemberVO> members=mService.memberList();
		Map map=new HashMap();
		map.put("members", members);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	// 관리자 회원 목록 페이지
	@GetMapping(value = "admin/memberListVue.do", produces = "text/plain;charset=UTF-8")
	public String adminmemberList() throws Exception {
		List<MemberVO> members=mService.adminmemberList();
		Map map = new HashMap();
		map.put("members", members);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}

	// 회원 상세 조회
	@GetMapping(value = "seller/memberDetailVue.do", produces = "text/plain;charset=UTF-8")
	public String memberDetail(String id) throws Exception {
		MemberVO member = mService.memberDetail(id);
		Map map = new HashMap();
		map.put("member", member);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	// 멤버 아이디 중복체크
	@GetMapping(value = "member/memberIdCheck.do", produces = "text/plain;charset=UTF-8")
	public String memberIdCheck(String userId) {
		int count=mService.memberIdCheck(userId);
		return String.valueOf(count);
	}

	// 멤버 닉네임 중복체크
	@GetMapping(value = "member/memberNickCheck.do", produces = "text/plain;charset=UTF-8")
	public String memberNickCheck(String nickName) {
		int count=mService.memberNickCheck(nickName);
		return String.valueOf(count);
	}
	
	// 멤버 전화번호 중복체크
	@GetMapping(value = "member/memberPhoneCheck.do", produces = "text/plain;charset=UTF-8")
	public String memberPhoneCheck(String phone) {
		int count=mService.memberPhoneCheck(phone);
		return String.valueOf(count);
	}
	
	// 멤버 이메일 중복체크
	@GetMapping(value = "member/memberEmailCheck.do", produces = "text/plain;charset=UTF-8")
	public String memberEmailCheck(String email) {
		int count=mService.memberEmailCheck(email);
		return String.valueOf(count);
	}

}
