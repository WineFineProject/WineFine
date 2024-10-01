package com.sist.controller;
import java.util.*;

import com.sist.mapper.ShopMapper;
import com.sist.service.ShopService;
import com.sist.vo.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShopController {
	@Autowired
	private ShopService pservice;
	
	@GetMapping("shop/list.do")
	public String wine_list() {
		return "shop/list";
	}
	
	@GetMapping("shop/detail.do")
	public String shop_detail(int wno) {
//		WineVO vo = pservice.detail
		return "";
	}
}
