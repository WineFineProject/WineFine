package com.sist.controller;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.mapper.ShopMapper;
import com.sist.service.MemberService;
import com.sist.service.ShopService;
import com.sist.vo.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ShopController {
	@Autowired
	private MemberService mService;
	@Autowired
	private ShopService sService;
	@GetMapping("shop/mainhome.do")
	public String mainhome() {
		return "shop/mainhome";
	}
	
	@RequestMapping("shop/list.do")
	public String wine_list(FilterVO vo, Model model, HttpSession session) {
		String id = (String)session.getAttribute("userId");
		model.addAttribute("sessionid",id);
		model.addAttribute("search", vo);
		return "shop/list";
	}
	
	@GetMapping("shop/detailBefore.do")
	public String shopDetailBefore(int wno, RedirectAttributes ra) {
		ra.addAttribute("wno", wno);
		String id=sService.getSeller(wno);
		mService.visitCheck(id);
		return "redirect:../shop/detail.do";
	}
	
	@GetMapping("shop/detail.do")
	public String shop_detail(int wno, Model model, HttpSession session) {
		String id = (String)session.getAttribute("userId");
		model.addAttribute("wno",wno);
		model.addAttribute("session",id);
		return "shop/detail";
	}
	
	@GetMapping("shop/buy.do")
	public String buy(int wno,Model model, HttpSession session ) {
		
		String sessionId=(String)session.getAttribute("userId");
		model.addAttribute("sessionId",sessionId);
		model.addAttribute("wno",wno);
		return "shop/buy";
	}
	
	@GetMapping("wine/quickfind.do")
	public String wine_find(Model model)
	{
		model.addAttribute("msg","빠른검색");
		return "wine/quickfind";
	}
	
}