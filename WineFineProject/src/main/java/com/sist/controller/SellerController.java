package com.sist.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SellerController {
	@GetMapping("seller/sellerHome.do")
	public String sellerHome() {
		return "seller/sellerHome";
	}
	@GetMapping("seller/coupon.do")
	public String sellerCoupon() {
		return "seller/coupon";
	}
	@GetMapping("seller/banner.do")
	public String sellerBanner() {
		return "seller/banner";
	}
	@GetMapping("seller/sale.do")
	public String sellersale() {
		return "seller/sale";
	}
	@GetMapping("seller/notice.do")
	public String sellerNotice() {
		return "seller/notice";
	}
	@GetMapping("seller/noticeDetail.do")
	public String sellerNoticeDetail(int nbno, Model model) {
		model.addAttribute("nbno", nbno);
		return "seller/noticeDetail";
	}
	@GetMapping("seller/noticeInsert.do")
	public String sellerNoticeInsert() {
		return "seller/noticeInsert";
	}
	@GetMapping("seller/noticeUpdate.do")
	public String sellerNoticeUpdate(int nbno, Model model) {
		model.addAttribute("nbno", nbno);
		return "seller/noticeUpdate";
	}
	@GetMapping("seller/replyboard.do")
	public String sellerReplyBoard() {
		return "seller/replyboard";
	}
	@GetMapping("seller/replyQuest.do")
	public String sellerReplyQuest() {
		return "seller/replyQuest";
	}
	@GetMapping("seller/replydetail.do")
	public String sellerReplyDetail(int wrno, Model model) {
		model.addAttribute("wrno", wrno);
		return "seller/replydetail";
	}
	@GetMapping("seller/chart.do")
	public String sellerChart() {
		return "seller/chart";
	}
	@GetMapping("seller/replyInsert.do")
	public String sellerReplyBoardInsert(int wrno, Model model) {
		model.addAttribute("wrno", wrno);
		model.addAttribute("today", new SimpleDateFormat("YY-MM-dd HH:mm").format(new Date()));
		return "seller/replyboardInsert";
	}
}
