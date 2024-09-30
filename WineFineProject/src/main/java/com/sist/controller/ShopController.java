package com.sist.controller;
import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShopController {
	@GetMapping("shop/list.do")
	public String wine_list() {
		return "shop/list";
	}
}
