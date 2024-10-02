package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class SellerRestController {
	String[] types= {"", "레드", "화이트", "스파클링", "로제", "주정강화", "기타"};
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
	
	@GetMapping(value = "seller/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueCouponList(HttpSession session) throws Exception{
		Map map=new HashMap();
		String id=(String)session.getAttribute("id");
		List<PromotionCouponVO> waitCoupon=cService.promotionWaitList(id);
		List<PromotionCouponVO> activeCoupon=cService.sellerPromotionActiveList(id);
		for(PromotionCouponVO vo:activeCoupon) {
			if(vo.getType()==1) {
				vo.setTargetname("전체");
			}
			else if(vo.getType()==2) {
				vo.setTargetname(types[vo.getType()]);
			}
			else if(vo.getType()==3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		for(PromotionCouponVO vo:waitCoupon) {
			if(vo.getType()==1) {
				vo.setTargetname("전체");
			}
			else if(vo.getType()==2) {
				vo.setTargetname(types[vo.getType()]);
			}
			else if(vo.getType()==3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		map.put("waitCoupon", waitCoupon);
		map.put("activeCoupon", activeCoupon);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
}
