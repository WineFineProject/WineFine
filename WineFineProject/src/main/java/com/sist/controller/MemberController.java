package com.sist.controller;

import com.sist.service.MemberService;
import com.sist.vo.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Autowired
	private MemberService mService;

	@RequestMapping("member/login.do")
	public String memberLogin() {
		return "login";
	}

	@RequestMapping("member/logout.do")
	public String memberLogout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:../main/main.do";
	}

	// �쉶�썝 紐⑸줉 �럹�씠吏�
	@GetMapping("seller/memberList.do")
	public String memberList(Model model) {

		return "seller/memberList";
	}

	@GetMapping("admin/memberList.do")
	public String adminmemberList(Model model) {

		return "admin/memberList";
	}

	@GetMapping("seller/memberDetail.do")
	public String memberDetail(String id, Model model) {
		MemberVO member = mService.memberDetail(id);
		model.addAttribute("member", member);
		return "seller/memberDetail";
	}

	@GetMapping("admin/memberWait.do")
	public String memberWait() {
		
		return "admin/memberWait";
	}
	
	@GetMapping("seller/updateMember.do")
	public String updateMember(String id, Model model) {
		MemberVO member = mService.memberDetail(id);
		model.addAttribute("member", member);
		return "seller/updateMember";
	}

	@PostMapping("seller/updateMemberOk.do")
	public String updateMemberOk(MemberVO member) {
		mService.updateMember(member);
		return "redirect:../seller/memberList.do";
	}

	@PostMapping("member/joinOk.do")
	public String memberJoinOk(MemberVO vo) {
		System.out.println(vo);
		String enPwd=encoder.encode(vo.getUserPwd());
		vo.setUserPwd(enPwd);
		if (vo.getPhone1() != "") {
			vo.setPhone(vo.getPhone1() + "-" + vo.getPhone2() + "-" + vo.getPhone3());
		}
		else {
			vo.setPhone("");
		}
		mService.insertMember(vo);
		mService.insertAuthority(vo.getUserId());
		return "redirect:../main/main.do";
	}
}
