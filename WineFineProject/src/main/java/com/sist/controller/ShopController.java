package com.sist.controller;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.mapper.ShopMapper;
import com.sist.service.ShopService;
import com.sist.vo.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShopController {
	@Autowired
	private ShopService pservice;
	
	@GetMapping("shop/mainhome.do")
	public String mainhome() {
		return "shop/mainhome";
	}
	
	@GetMapping("shop/list.do")
	public String wine_list() {
		return "shop/list";
	}
	
	@GetMapping("shop/detail.do")
	public String shop_detail(int wno, Model model, HttpSession session,int page) {
		String id = (String)session.getAttribute("userId");
		model.addAttribute("wno",wno);
		model.addAttribute("session",id);
		model.addAttribute("page", page);
		return "shop/detail";
	}
	
	@GetMapping("shop/buy.do")
	public String buy(int wno,Model model, HttpSession session ) {
		
		String sessionId=(String)session.getAttribute("userId");
		model.addAttribute("sessionId",sessionId);
		model.addAttribute("wno",wno);
		return "shop/buy";
	}
	
}