package com.sist.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	@GetMapping("admin/adminHome.do")
	public String adminHome() {
		return "admin/adminHome";
	}
	
	@GetMapping("admin/coupon.do")
	public String adminCoupon() {
		return "admin/coupon";
	}
	@GetMapping("admin/banner.do")
	public String adminBanner() {
		return "admin/banner";
	}
	@GetMapping("admin/sale.do")
	public String adminSale() {
		return "admin/sale";
	}
	@GetMapping("admin/replyboard.do")
	public String adminReplyBoard() {
		return "admin/replyboard";
	}
	@GetMapping("admin/itemList.do")
	public String adminitemList() {
		return "admin/itemList";
	}
	@GetMapping("admin/replydetail.do")
	public String adminReplyBoard(int wrno, Model model) {
		model.addAttribute("wrno", wrno);
		return "admin/replydetail";
	}
	@GetMapping("admin/replyInsert.do")
	public String adminReplyBoardInsert(int wrno, Model model) {
		model.addAttribute("wrno", wrno);
		model.addAttribute("today", new SimpleDateFormat("YY-MM-dd HH:mm").format(new Date()));
		return "admin/replyboardInsert";
	}
	@GetMapping("admin/noticeboard.do")
	public String adminNoticeBoard() {
		return "admin/noticeboard";
	}
	@GetMapping("admin/noticedetail.do")
	public String adminNoticedetail(int bno, Model model)
	{
		model.addAttribute("bno", bno);
		return "admin/noticedetail";
	}
	@GetMapping("admin/noticeinsert.do")
	public String adminNoticeinsert() {
		return "admin/noticeinsert";
	}
	@GetMapping("admin/noticeupdate.do")
	public String adminNoticeupdate(int bno, Model model)
	{
		model.addAttribute("bno", bno);
		return "admin/noticeupdate";
	}
	@GetMapping("admin/wineAccept.do")
	public String adminWineAccept() {
		return "admin/wineAccept";
	}
	@GetMapping("admin/accCheck.do")
	public String adminaccCheck() {
		return "admin/accCheck";
	}
}
