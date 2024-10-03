package com.sist.controller;

import org.springframework.stereotype.Controller;
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
}
