package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.service.ItemService;
import com.sist.vo.WineVO;

@RestController
public class ItemRestController {
	@Autowired
	private ItemService iService;
	
	@PostMapping(value="seller/register_vue.do",produces = "text/plain;charset=UTF-8")
	public String seller_register(@ModelAttribute WineVO vo)
	{
		String result="";
		iService.wineItemInsert(vo);
		result="yes";
		return result;
	}
}
