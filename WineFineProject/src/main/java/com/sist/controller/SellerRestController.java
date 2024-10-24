package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

import oracle.net.aso.l;

@RestController
public class SellerRestController {
	String[] types = { "", "레드", "화이트", "스파클링", "로제", "주정강화", "기타" };
	@Autowired
	private ShopService sService;
	@Autowired
	private CouponService cService;
	@Autowired
	private BannerService bService;
	@Autowired
	private SaleService ssService;
	@Autowired
	private NoticeBoardService nService;
	@Autowired
	private SellerService sellerService;
	
	
	// 占쏙옙占쏙옙 占싯삼옙 占쏙옙占�
	@GetMapping(value = "seller/findWine.do", produces = "text/plain;charset=UTF-8")
	public String sellerFindWine(String fd, HttpSession session) throws Exception {
		Map map = new HashMap();
		String id = (String) session.getAttribute("userId");
		map.put("fd", fd);
		map.put("id", id);
		System.out.println(id);
		System.out.println(fd);
		List<WineVO> list = sService.wineFindList(map);
		JsonMapper mapper = new JsonMapper();
		String json = mapper.writeValueAsString(list);
		return json;
	}

	@PostMapping(value = "seller/couponInsert.do", produces = "text/plain;charset=UTF-8")
	public void sellerCouponInsert(PromotionCouponVO vo, HttpSession session) {
		vo.setUserid((String) session.getAttribute("userId"));
		cService.promotionCouponInput(vo);
	}

	@GetMapping(value = "seller/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueCouponList(HttpSession session) throws Exception {
		Map map = new HashMap();
		String id = (String) session.getAttribute("userId");
		List<PromotionCouponVO> waitCoupon = cService.sellerPromotionWaitList(id);
		List<PromotionCouponVO> activeCoupon = cService.sellerPromotionActiveList(id);
		for (PromotionCouponVO vo : activeCoupon) {
			if (vo.getType() == 1) {
				vo.setTargetname("전체");
			} else if (vo.getType() == 2) {
				vo.setTargetname(types[vo.getTarget()]);
			} else if (vo.getType() == 3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		for (PromotionCouponVO vo : waitCoupon) {
			if (vo.getType() == 1) {
				vo.setTargetname("전체");
			} else if (vo.getType() == 2) {
				vo.setTargetname(types[vo.getTarget()]);
			} else if (vo.getType() == 3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		map.put("waitCoupon", waitCoupon);
		map.put("activeCoupon", activeCoupon);
		JsonMapper mapper = new JsonMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}

	@PostMapping(value = "seller/vueBannerInsert.do", produces = "text/plain;charset=UTF-8")
	public void sellerVueBannerInsert(PromotionBannerVO vo, HttpSession session) {
		vo.setUserid((String) session.getAttribute("userId"));
		bService.promotionBannerInput(vo);
	}

	@GetMapping(value = "seller/vueBannerList.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueBannerList(HttpSession session) throws Exception {
		String id = (String) session.getAttribute("userId");
		List<PromotionBannerVO> activeBanner = bService.promotionActiveBanner(id);
		List<PromotionBannerVO> waitBanner = bService.promotionWaitBanner(id);
		Map map = new HashMap();
		map.put("activeBanner", activeBanner);
		map.put("waitBanner", waitBanner);
		JsonMapper mapper = new JsonMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}

	@GetMapping(value = "seller/vueSaleList.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueSaleList(HttpSession session) throws Exception {
		Map map = new HashMap();
		String id = (String) session.getAttribute("userId");
		List<PromotionSaleVO> waitSale = ssService.saleWaitList(id);
		List<PromotionSaleVO> activeSale = ssService.sellerSaleActiveList(id);
		for (PromotionSaleVO vo : activeSale) {
			if (vo.getType() == 1) {
				vo.setTargetname("전체");
			} else if (vo.getType() == 2) {
				vo.setTargetname(types[vo.getType()]);
			} else if (vo.getType() == 3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		for (PromotionSaleVO vo : waitSale) {
			if (vo.getType() == 1) {
				vo.setTargetname("전체");
			} else if (vo.getType() == 2) {
				vo.setTargetname(types[vo.getType()]);
			} else if (vo.getType() == 3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		map.put("waitSale", waitSale);
		map.put("activeSale", activeSale);
		JsonMapper mapper = new JsonMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}

	@PostMapping(value = "seller/vueSaleInsert.do", produces = "text/plain;charset=UTF-8")
	public void sellerVueSaleInsert(PromotionSaleVO vo, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		vo.setUserid(id);
		ssService.promotionSaleInput(vo);
	}

	@PostMapping(value = "seller/insertNotice.do", produces = "text/plain;charset=UTF-8")
	public void sellerInsertNotice(NoticeBoardVO vo, int isNotice, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		String nickname = (String) session.getAttribute("nickName");
		vo.setUserid(id);
		vo.setNickname(nickname);
		System.out.println(vo);
		nService.noticeBoardInsert(vo);
		if(isNotice==1) {
			Map map=new HashMap();
			if(vo.getType()==2)
				map.put("target", types[vo.getTarget()]);
			else {
				map.put("target", vo.getTarget());
			}
			map.put("seller", id);
			map.put("nbno", nService.noticeGetNum());
			nService.noticeBoardPopupUpdate(map);
		}
	}

	@PostMapping(value = "seller/vueNoticeUpdate.do", produces = "text/plain;charset=UTF-8")
	public void sellerVueNoticeUpdate(NoticeBoardVO vo, int isNotice, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		String nickname = (String) session.getAttribute("nickName");
		vo.setUserid(id);
		vo.setNickname(nickname);
		System.out.println(vo);
		nService.noticeBoardUpdate(vo);
		if(isNotice==1) {
			Map map=new HashMap();
			if(vo.getType()==2)
				map.put("target", types[vo.getTarget()]);
			else {
				map.put("target", vo.getTarget());
			}
			map.put("seller", id);
			map.put("nbno", vo.getNbno());
			nService.noticeGetNum();
		}
	}

	@GetMapping(value = "seller/noticeList.do", produces = "text/plain;charset=UTF-8")
	public String sellerNoticeList(int page, HttpSession session) throws Exception {
		String id = (String) session.getAttribute("userId");
		Map map = new HashMap();
		int start = (page - 1) * 10 + 1;
		int end = start + 10 - 1;
		map.put("start", start);
		map.put("end", end);
		map.put("id", id);
		List<NoticeBoardVO> list = nService.sellerNoticeList(map);
		int count = nService.sellerNoticeTotalPage(map);
		int totalPage = (int) (Math.ceil(count / 10.0));
		count = count - (page - 1) * 10;
		map.put("count", count);
		map.put("totalPage", totalPage);
		map.put("curPage", page);
		map.put("list", list);

		JsonMapper mapper = new JsonMapper();
		return mapper.writeValueAsString(map);
	}

	@GetMapping(value = "seller/vueNoticeDetail.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueNoticeDetail(int nbno) throws Exception {
		NoticeBoardVO vo = nService.noticeDetail(nbno);
		JsonMapper mapper = new JsonMapper();
		return mapper.writeValueAsString(vo);
	}

	@GetMapping(value = "seller/vueNoticeDetailData.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueNoticeDetailData(int nbno) throws Exception {
		NoticeBoardVO vo = nService.noticeDetailData(nbno);
		JsonMapper mapper = new JsonMapper();
		return mapper.writeValueAsString(vo);
	}
	@GetMapping(value = "seller/vueSellerHomeInfo.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueHomeInfo(HttpSession session) throws Exception{
		String id=(String)session.getAttribute("userId");
		
		Map map=new HashMap();
		
		List<Integer> dates=sellerService.sellerVisitWeeks(id);
		int maxVisit=sellerService.sellerVisitMax(id);
		int accPoint=sellerService.sellerGetAccPoint(id);
		map.put("dates", dates);
		map.put("maxVisit", maxVisit);
		map.put("accPoint", accPoint);
		
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	@GetMapping(value = "seller/vueSellerTypeChart.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueTypeChart(HttpSession session) throws Exception{
		String id=(String)session.getAttribute("userId");
		Map map=new HashMap();
		List<ChartVO> pList=sellerService.sellerSellTypePrice(id);
		List<ChartVO> aList=sellerService.sellerSellTypeAccount(id);
		List<ChartVO> rList=sellerService.sellerAddrPrice(id);
		
		map.put("pList", pList);
		map.put("aList", aList);
		map.put("rList", rList);
		
		
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	@GetMapping(value = "seller/vueSellerSaleInfo.do", produces = "text/plain;charset=UTF-8")
	public String sellerVueSaleInfo(HttpSession session) throws Exception{
		Map map=new HashMap();
		String id=(String)session.getAttribute("userId");
		Map<String, Integer> statemap=sService.sellerHomeSaleInfo(id);
		Map<String, Integer> typemap=sService.sellerHomeWineInfo(id);
		Map<String, Integer> paymap=sellerService.sellerPaymentInfoCount(id);
		Map<String, Integer> etcmap=sellerService.sellerMoreInfoCount(id);
		System.out.println(typemap);
		map.put("state", statemap);
		map.put("type", typemap);
		map.put("pay", paymap);
		map.put("etc", etcmap);
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	@GetMapping(value = "seller/vueBannerDelete.do", produces = "text/plain;charset=UTF-8")
	public void sellerVueBannerDelete(int pbno) {
		bService.bannerDelete(pbno);
	}
	@GetMapping(value = "seller/vueSaleDelete.do", produces = "text/plain;charset=UTF-8")
	public void sellerVueSaleDelete(int psno) {
		ssService.saleDelete(psno);
	}
	@GetMapping(value = "seller/vueCouponDelete.do", produces = "text/plain;charset=UTF-8")
	public void sellerVueCouponDelete(int pcno) {
		cService.couponDelete(pcno);
	}
	@GetMapping(value = "seller/vueSellerPromotionChart.do", produces = "text/plain;charset=UTF-8")
	public String sellerVuePromotionChart(int no, int type) throws Exception{
		Map map=new HashMap();
		if(type==1) {
			List<ChartVO> list=sellerService.sellerSalePromotionChart(no);
			map.put("list", list);
		}
		else if(type==2) {
			List<ChartVO> list=sellerService.sellerCouponPromotionChart(no);
			map.put("list", list);
		}
		else if(type==3) {
			List<ChartVO> list=sellerService.sellerBannerPromotionChart(no);
			map.put("list", list);
		}
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
}
