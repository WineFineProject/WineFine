package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BlackListController {
	@GetMapping("seller/blackList.do")
	public String blackList(Model model) 
	{
		return "seller/blackList";
	}
}
