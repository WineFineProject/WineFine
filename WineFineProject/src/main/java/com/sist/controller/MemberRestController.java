package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
public class MemberRestController {
	@Autowired
	private MemberService mService; 
	
	@PostMapping(value = "member/vueLogin.do", produces = "text/plain;charset=UTF-8")
	public String memberVueLogin(String id, String pwd, HttpSession session) {
		String result=mService.memberLogin(id, pwd);
		if(result=="OK") {
			session.setAttribute("id", id);
		}
		return result;
	}
	
	/*
	 * @GetMapping(value = "seller/memberList.do", produces =
	 * "text/plain;charset=UTF-8") public String memberList() throws Exception {
	 * List<MemberVO> members = mService.memberList(); Map map = new HashMap();
	 * map.put("members", members);
	 * 
	 * ObjectMapper mapper = new ObjectMapper(); return
	 * mapper.writeValueAsString(map); }
	 */
}
