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


	// �쉶�썝 紐⑸줉 �럹�씠吏�
	@GetMapping(value = "seller/memberListVue.do", produces = "text/plain;charset=UTF-8")
	public String memberList() throws Exception {
		List<MemberVO> members=mService.memberList();
		Map map=new HashMap();
		map.put("members", members);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	// 愿�由ъ옄 �쉶�썝 紐⑸줉 �럹�씠吏�
	@GetMapping(value = "admin/memberListVue.do", produces = "text/plain;charset=UTF-8")
	public String adminmemberList() throws Exception {
		List<MemberVO> members=mService.adminmemberList();
		Map map = new HashMap();
		map.put("members", members);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}

	// �쉶�썝 �긽�꽭 議고쉶
	@GetMapping(value = "seller/memberDetailVue.do", produces = "text/plain;charset=UTF-8")
	public String memberDetail(String id) throws Exception {
		MemberVO member = mService.memberDetail(id);
		Map map = new HashMap();
		map.put("member", member);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	// 硫ㅻ쾭 �븘�씠�뵒 以묐났泥댄겕
	@GetMapping(value = "member/vueCheckId.do", produces = "text/plain;charset=UTF-8")
	public String memberIdCheck(String userId) {
		int count=mService.memberIdCheck(userId);
		return String.valueOf(count);
	}

	// 硫ㅻ쾭 �땳�꽕�엫 以묐났泥댄겕
	@GetMapping(value = "member/vueCheckNick.do", produces = "text/plain;charset=UTF-8")
	public String memberNickCheck(String nickName) {
		int count=mService.memberNickCheck(nickName);
		return String.valueOf(count);
	}
	
	// 硫ㅻ쾭 �쟾�솕踰덊샇 以묐났泥댄겕
	@GetMapping(value = "member/vueCheckPhone.do", produces = "text/plain;charset=UTF-8")
	public String memberPhoneCheck(String phone) {
		int count=mService.memberPhoneCheck(phone);
		return String.valueOf(count);
	}
	
	// 硫ㅻ쾭 �씠硫붿씪 以묐났泥댄겕
	@GetMapping(value = "member/vueCheckEmail.do", produces = "text/plain;charset=UTF-8")
	public String memberEmailCheck(String email) {
		int count=mService.memberEmailCheck(email);
		return String.valueOf(count);
	}

}
