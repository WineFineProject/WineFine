package com.sist.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class SellerRestController {
	@Autowired
	private ShopService sService;
	@Autowired
	private CouponService cService;
	//와인 검색 출력
	@GetMapping(value = "seller/findWine.do",produces = "text/plain;charset=UTF-8")
	public String sellerFindWine(String fd) throws Exception{
		List<WineVO> list=sService.wineFindList(fd);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	
	@PostMapping(value = "seller/couponInsert.do", produces = "text/plain;charset=UTF-8")
	public void sellerCouponInsert(PromotionCouponVO vo) {
		System.out.println(vo);
		cService.promotionCouponInput(vo);
	}
}
