package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
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
}
