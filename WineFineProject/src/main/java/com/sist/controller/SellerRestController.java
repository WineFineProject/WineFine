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

	// 占쏙옙占쏙옙 占싯삼옙 占쏙옙占�
	@GetMapping(value = "seller/findWine.do", produces = "text/plain;charset=UTF-8")
	public String sellerFindWine(String fd, HttpSession session) throws Exception {
		Map map = new HashMap();
		String id = (String) session.getAttribute("userId");
		map.put("fd", fd);
		map.put("id", id);
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
		List<PromotionCouponVO> waitCoupon = cService.promotionWaitList(id);
		List<PromotionCouponVO> activeCoupon = cService.sellerPromotionActiveList(id);
		for (PromotionCouponVO vo : activeCoupon) {
			if (vo.getType() == 1) {
				vo.setTargetname("전체");
			} else if (vo.getType() == 2) {
				vo.setTargetname(types[vo.getType()]);
			} else if (vo.getType() == 3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		for (PromotionCouponVO vo : waitCoupon) {
			if (vo.getType() == 1) {
				vo.setTargetname("전체");
			} else if (vo.getType() == 2) {
				vo.setTargetname(types[vo.getType()]);
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
}
