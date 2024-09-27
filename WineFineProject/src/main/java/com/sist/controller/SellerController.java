package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SellerController {
	@GetMapping("seller/sellerHome.do")
	public String sellerHome() {
		return "seller/sellerHome";
	}
}
