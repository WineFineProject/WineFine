package com.sist.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ItemController {
	@GetMapping("seller/register.do")
	   public String seller_register()
	   {
		   return "seller/register";
	   }
}