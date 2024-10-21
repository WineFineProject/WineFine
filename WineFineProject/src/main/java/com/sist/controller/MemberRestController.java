package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

@RestController
public class MemberRestController {
	@Autowired
	private MemberService mService;


	// �쉶�썝 紐⑸줉 �럹�씠吏�
	@GetMapping(value = "seller/memberListVue.do", produces = "text/plain;charset=UTF-8")
	public String memberList(int page) throws Exception {
	  int rowSize=10;
	  int start=(rowSize*page)-(rowSize-1);
	  int end=rowSize*page;
	  
	  List<MemberVO> members=mService.memberList(start, end);
	  int totalpage=mService.memberCount();
	  
	  final int BLOCK=10;
	  int startPage=((page-1)/BLOCK*BLOCK)+1;
	  int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
	  
	  if(endPage>totalpage)
		  endPage=totalpage;
	  
	  Map map=new HashMap(); 
	  map.put("members", members);
	  map.put("curpage", page);
	  map.put("totalpage", totalpage);
	  map.put("startPage", startPage);
	  map.put("endPage", endPage);
	  
	  ObjectMapper mapper=new ObjectMapper();
	  String json=mapper.writeValueAsString(map);
	  
	  return json;
	}
	
	// 愿�由ъ옄 �쉶�썝 紐⑸줉 �럹�씠吏�
	@GetMapping(value = "admin/memberListVue.do", produces = "text/plain;charset=UTF-8")
	public String adminmemberList(int page) throws Exception {
		  int rowSize=10;
		  int start=(rowSize*page)-(rowSize-1);
		  int end=rowSize*page;
		  
		  List<MemberVO> members=mService.adminmemberList(start, end);
		  int totalpage=mService.adminmemberCount();
		  
		  final int BLOCK=10;
		  int startPage=((page-1)/BLOCK*BLOCK)+1;
		  int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		  
		  if(endPage>totalpage)
			  endPage=totalpage;
		  
		  Map map=new HashMap(); 
		  map.put("members", members);
		  map.put("curpage", page);
		  map.put("totalpage", totalpage);
		  map.put("startPage", startPage);
		  map.put("endPage", endPage);
		  
		  ObjectMapper mapper=new ObjectMapper();
		  String json=mapper.writeValueAsString(map);
		  
		  return json;
	}

	@PostMapping(value = "admin/deleteMember.do", produces = "text/plain;charset=UTF-8")
	public String deleteMember(String id) {
		mService.deleteMember(id);
		return "redirect:../admin/memberList.do";
	}

	@GetMapping(value = "admin/memberGradeUp.do", produces = "text/plain;charset=UTF-8")
	public void memberGradeUp(String userId) 
	{
	    mService.gradeIncrement(userId);
	}
	
	@GetMapping(value = "admin/memberGradeDown.do", produces = "text/plain;charset=UTF-8")
	public void memberGradeDowm(String userId) 
	{
		mService.gradeDecrement(userId);
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
	
	// 회원 대기 목록
	@GetMapping(value = "admin/memberWaitVue.do", produces = "text/plain;charset=UTF-8")
	public String adminmemberWait() throws Exception{
		List<MemberVO> members=mService.memberWait();
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(members);
		  
		  return json;
	}
	
	// 판매자 가입 승인
	@GetMapping(value = "admin/accessMember.do", produces = "text/plain;charset=UTF-8")
	public void accessMember(String userId)
	{
		mService.accessMember(userId);
	}
	
	// 판매자 가입 거절
	@GetMapping(value = "admin/noAccessMember.do", produces = "text/plain;charset=UTF-8")
	public void noAccessMember(String userId)
	{
		mService.noAccessMember(userId);
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
