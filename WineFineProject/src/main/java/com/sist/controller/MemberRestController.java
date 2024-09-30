package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.service.*;
import com.sist.vo.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
public class MemberRestController {
	@Autowired
	private MemberService mService;
	
	@GetMapping(value = "member/vueLogin.do", produces = "text/plain;charset=UTF-8")
	public String memberVueLogin(String id, String pwd, HttpServletRequest request) {
		String result=mService.memberLogin(id, pwd);
		if(result=="OK") {
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
		}
		return result;
	}
}
