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
	@Autowired
	private CouponService cService;
	
	@GetMapping(value = "admin/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String adminVueCouponList() throws Exception{
		Map map=new HashMap();
		List<PromotionCouponVO> waitCoupon=cService.promotionWaitList("");
		List<PromotionCouponVO> activeCoupon=cService.promotionActiveList("");
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
