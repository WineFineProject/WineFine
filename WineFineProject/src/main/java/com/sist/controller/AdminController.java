package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	@GetMapping("admin/adminHome.do")
	public String adminHome() {
		return "admin/adminHome";
	}
}
