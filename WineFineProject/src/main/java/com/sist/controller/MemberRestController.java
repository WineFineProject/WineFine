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

	@PostMapping(value = "member/vueLogin.do", produces = "text/plain;charset=UTF-8")
	public String memberVueLogin(String id, String pwd, HttpSession session) {
		String result = mService.memberLogin(id, pwd);
		MemberVO vo=mService.memberDetail(id);
		if (result == "OK") {
			session.setAttribute("id", vo.getId());
			session.setAttribute("nickname", vo.getNickname());
			session.setAttribute("admin", vo.getAdmin());
		}
		return result;
	}

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

}
