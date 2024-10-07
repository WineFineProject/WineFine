package com.sist.controller;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.BlackListService;
import com.sist.vo.*;
@Controller
public class BlackListController {
	@Autowired
	private BlackListService bService;
	
	@GetMapping("seller/blackList.do")
	public String blackList() 
	{
		return "seller/blackList";
	}
}
