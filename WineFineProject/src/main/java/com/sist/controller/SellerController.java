package com.sist.controller;

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
	@GetMapping("seller/noticeInsert.do")
	public String sellerNoticeInsert() {
		return "seller/noticeInsert";
	}
	@GetMapping("seller/noticeUpdate.do")
	public String sellerNoticeUpdate(int nbno, Model model) {
		model.addAttribute("nbno", nbno);
		return "seller/noticeUpdate";
	}
	
}
