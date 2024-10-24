package com.sist.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.service.*;
import com.sist.vo.Wine_PaymentVO;

@Controller
public class MainController {
	@Autowired
	private ShopService shopService;
	@Autowired
	private SaleService saleService;
	@Autowired
	private CouponService cService;
	@Autowired
	private MemberService mService;
	@GetMapping("main/main.do")
	public String mainHome(Model model) {
		model.addAttribute("msg", "상품목록");
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
		List<Wine_PaymentVO> list= shopService.paymentGetAccount();
		for(Wine_PaymentVO vo:list) {
			System.out.println(vo);
			shopService.sellerAccUpdate(vo);
			shopService.wineStackUpdate(vo);
		}
		shopService.paymentStateUpdate1();
		shopService.paymentStateUpdate2();
		shopService.paymentStateUpdate3();
		saleService.promotionSaleEndUpdate();
		cService.promotionCouponEndUpdate();
		mService.visitCheck("home");
		return "redirect:../main/main.do";
	}
}
