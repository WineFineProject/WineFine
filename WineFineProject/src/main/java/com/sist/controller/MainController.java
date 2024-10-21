package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.service.*;

@Controller
public class MainController {
	@Autowired
	private SaleService saleService;
	@Autowired
	private CouponService cService;
	@Autowired
	private MemberService mService;
	@GetMapping("main/main.do")
	public String mainHome() {
		return "main";
	}
	@GetMapping("main/find.do")
	public String mainFind(String fd, Model model) {
		if(fd==null)
			fd="";
		model.addAttribute("fd", fd);
		return "main/find";
	}
	@GetMapping("main/start.do")
	public String mainStart() {
		saleService.promotionSaleEndUpdate();
		cService.promotionCouponEndUpdate();
		mService.visitCheck("home");
		return "redirect:../main/main.do";
	}
}
