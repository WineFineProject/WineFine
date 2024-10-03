package com.sist.controller;

import org.springframework.stereotype.Controller;
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
}
