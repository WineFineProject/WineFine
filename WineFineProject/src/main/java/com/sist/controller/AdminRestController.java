package com.sist.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class AdminRestController {
	String[] types= {"", "레드", "화이트", "스파클링", "로제", "주정강화", "기타"};
	@Autowired
	private CouponService cService;
	
	@GetMapping(value = "admin/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String adminVueCouponList() throws Exception{
		Map map=new HashMap();
		List<PromotionCouponVO> waitCoupon=cService.promotionWaitList("");
		List<PromotionCouponVO> activeCoupon=cService.promotionActiveList("");
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
	@GetMapping(value = "admin/vueCouponApproval.do", produces = "text/plain;charset=UTF-8")
	public void adminVueCouponApproval(int pcno) {
		cService.promotionApproval(pcno);
	}
	@GetMapping(value = "admin/vueCouponRejection.do", produces = "text/plain;charset=UTF-8")
	public void adminVueCouponRejection(int pcno) {
		cService.promotionRejection(pcno);
	}
}
