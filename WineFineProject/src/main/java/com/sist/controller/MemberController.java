package com.sist.controller;
import com.sist.service.MemberService;
import com.sist.vo.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@Autowired
    private MemberService mService;
	
	@RequestMapping("member/login.do")
	public String memberLogin() {
		return "login";
	}
	@RequestMapping("member/logout.do")
	public String memberLogout(HttpServletRequest request) {
		HttpSession session=request.getSession();
		session.invalidate();
		return "redirect:../main/main.do";
	}
	
	
	// 회원 목록 페이지
	@GetMapping("seller/memberList.do") 
	public String memberList(Model model) {
	List<MemberVO> members=mService.memberList(); 
	model.addAttribute("members", members); 
	return "seller/memberList"; 
	}
	 
	// 관리자 회원 목록 페이지
	@GetMapping("admin/memberList.do") 
	public String adminmemberList(Model model) {
	List<MemberVO> members=mService.adminmemberList(); 
	model.addAttribute("members", members); 
	return "admin/memberList"; 
	}

    // 회원 상세 조회
    @GetMapping("seller/memberDetail.do")
    public String memberDetail(String id, Model model) {
        MemberVO member=mService.memberDetail(id);
        model.addAttribute("member", member);
        return "seller/memberDetail"; 
    }

    // 회원 삭제
    @PostMapping("seller/deleteMember.do")
    public String deleteMember(String id) {
        mService.deleteMember(id);
        return "redirect:../seller/memberList.do"; 
    }

    // 회원 정보 수정
    @GetMapping("seller/updateMember.do")
    public String updateMember(String id, Model model) {
        MemberVO member=mService.memberDetail(id);
        model.addAttribute("member", member);
        return "seller/updateMember"; 
    }
    @PostMapping("seller/updateMemberOk.do")
    public String updateMemberOk(MemberVO member) {
        mService.updateMember(member);
        return "redirect:../seller/memberList.do";
    }
}
