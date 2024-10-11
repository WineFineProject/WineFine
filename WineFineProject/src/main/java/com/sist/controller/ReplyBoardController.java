package com.sist.controller;
import com.sist.vo.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.sist.service.*;
@Controller
public class ReplyBoardController {
	private ReplyBoardService rService;
	@Autowired
	public ReplyBoardController(ReplyBoardService rService)
	{
		this.rService=rService;
	}
	// 게시판 목록
	@GetMapping("replyboard/list.do")
	public String replyboardList() 
	{
		return "replyboard/list";
	}
	// 회원 게시글 작성
	@GetMapping("replyboard/insert1.do")
	public String replyboardInsert1()
	{
		return "replyboard/insert1";
	}
	// 판매자 게시글 작성
	@GetMapping("replyboard/insert2.do")
	public String replyboardInsert2()
	{
		return "replyboard/insert2";
	}
	// 문의 게시판 상세
	@GetMapping("replyboard/detail.do")
	public String replyboardDetail(int wrno, Model model)
	{
		model.addAttribute("wrno", wrno);
		return "replyboard/detail";
	}
	// 게시글 수정
	@GetMapping("replyboard/update.do")
	public String replyboardUpdate(int wrno, Model model)
	{
		model.addAttribute("wrno", wrno);
		return "replyboard/update";
	}

}
