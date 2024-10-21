package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class AdminRestController {
	String[] types= { "", "레드", "화이트", "스파클링", "로제", "주정강화", "기타" };
	@Autowired
	private CouponService cService;
	@Autowired
	private BannerService bService;
	@Autowired
	private SaleService sService;
	@Autowired
	private ShopService ssService;
	@Autowired
	private AdminService aService;
	@GetMapping(value = "admin/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String adminVueCouponList() throws Exception{
		Map map=new HashMap();
		List<PromotionCouponVO> waitCoupon=cService.promotionWaitList();
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
	@GetMapping(value = "admin/vueBannerList.do", produces = "text/plain;charset=UTF-8")
	public String adminVueBannerList() throws Exception{
		Map map=new HashMap();
		List<PromotionBannerVO> waitBanner=bService.promotionWaitBanner("");
		List<PromotionBannerVO> activeBanner=bService.promotionActiveBanner("");
		map.put("waitBanner", waitBanner);
		map.put("activeBanner", activeBanner);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	@GetMapping(value = "admin/vueBannerApproval.do", produces = "text/plain;charset=UTF-8")
	public void adminVueBannerApproval(int pbno) {
		bService.promotionApproval(pbno);
	}
	@GetMapping(value = "admin/vueBannerRejection.do", produces = "text/plain;charset=UTF-8")
	public void adminVueBannerRejection(int pbno) {
		bService.promotionRejection(pbno);
	}
	
	@GetMapping(value = "admin/vueSaleList.do", produces = "text/plain;charset=UTF-8")
	public String adminVueSaleList() throws Exception{
		Map map=new HashMap();
		List<PromotionSaleVO> waitSale=sService.saleWaitList("");
		List<PromotionSaleVO> activeSale=sService.saleActiveList("");
		for(PromotionSaleVO vo:activeSale) {
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
		for(PromotionSaleVO vo:waitSale) {
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
		map.put("waitSale", waitSale);
		map.put("activeSale", activeSale);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	@GetMapping(value = "admin/vueSaleApproval.do", produces = "text/plain;charset=UTF-8")
	public void adminVueSaleApproval(int psno) {
		sService.promotionApproval(psno);
	}
	@GetMapping(value = "admin/vueSaleRejection.do", produces = "text/plain;charset=UTF-8")
	public void adminVueSaleRejection(int psno) {
		sService.promotionRejection(psno);
	}
	
	@GetMapping(value = "admin/vueWineList.do", produces = "text/plain;charset=UTF-8")
	public String adminWineList(int page) throws Exception{
		int rowSize=10;
		int start=(page-1)*rowSize+1;
		int end=page*rowSize;
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		List<WineVO> list=ssService.adminWineList(map);
		int totalPage=ssService.adminWinePage();
		
		map=new HashMap();
		map.put("list", list);
		map.put("curPage", page);
		map.put("totalPage", totalPage);
		
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	@GetMapping(value = "admin/vueHomeInfo.do", produces = "text/plain;charset=UTF-8")
	public String adminVueHome() throws Exception{
		List<Integer> list=aService.visitWeeks();
		int maxVisit=aService.visitMax();
		Map map=new HashMap();
		
		int noneCoupon=aService.noneCoupon();
		int noneSale=aService.noneSale();
		int noneBanner=aService.noneBanner();
		int noneItem=aService.noneItem();
		int noneAnswer=aService.noneAnswer();
		int nonePayment=aService.nonePayment();
		
		map.put("dates", list);
		map.put("maxVisit", maxVisit);
		map.put("noneCoupon", noneCoupon);
		map.put("noneSale", noneSale);
		map.put("noneBanner", noneBanner);
		map.put("noneItem", noneItem);
		map.put("noneAnswer", noneAnswer);
		map.put("nonePayment", nonePayment);
		
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
}
