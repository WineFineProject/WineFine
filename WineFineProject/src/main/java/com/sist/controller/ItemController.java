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
	@GetMapping("seller/itemlist.do")
	   public String seller_itemlist()
	   {
		   return "seller/itemlist";
	   }
	@GetMapping("seller/edit.do")
	   public String seller_edit()
	   {
		   return "seller/edit";
	   }
	@GetMapping("shop/sellerShop.do")
	public String seller_shop()
	{
		return "shop/sellerShop";
	}
}
