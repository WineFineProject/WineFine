package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.dao.ShopDAO;
import com.sist.dao.WineDAO;
import com.sist.service.LikeService;
import com.sist.service.MemberService;
import com.sist.service.ShopService;
import com.sist.service.WineReviewService;
import com.sist.vo.*;

import oracle.jdbc.proxy.annotation.Post;

@RestController
public class ShopRestController {
	String[] wtypes = { "", "占쎌쟿占쎈굡", "占쎌넅占쎌뵠占쎈뱜", "占쎈뮞占쎈솁占쎄깻筌랃옙", "雅뚯눘�젟揶쏅벤�넅", "疫꿸퀬占�" };
	String[] foods = { "소", "돼지", "양", "치킨", "피자", "비빔밥", "가리비", "아시아", "건육", "케이크", "튀김", "생선", "누들", "과일", "샐러드",
			"치즈", "샴페인" };
	String[] aroma = { "꽃", "돌", "레몬", "말린과일", "베리", "사과", "숙성", "시나몬", "아몬드", "오크통", "크로와상", "파인애플", "파프리카", "허브" };

	private ShopService sservice;
	private MemberService mService;
	private LikeService lservice;

	@Autowired
	public ShopRestController(ShopService sservice, MemberService mService, LikeService lservice) {
		this.sservice = sservice;
		this.mService = mService;
		this.lservice = lservice;
	}

	@Autowired
	WineReviewService wservice;

	@GetMapping(value = "shop/list_vue.do", produces = "text/plain;charset=UTF-8")
	public String shop_list(int page) throws Exception {
		int rowsize = 12;
		int start = (rowsize * page) - (rowsize - 1);
		int end = rowsize * page;

		int wineTcount = sservice.wineCount();
		List<WineVO> list = sservice.wineListData(start, end);

		int totalpage = sservice.shopTotalPage();
		
		final int BLOCK = 10;
		int startpage = ((page - 1) / BLOCK * BLOCK) + 1;
		int endpage = ((page - 1) / BLOCK * BLOCK) + BLOCK;

		if (endpage > totalpage)
			endpage = totalpage;

//		占쎈쐻占쎈윥占쎈ぅ占쎈쐻占쎈윪�얠±�쐻占쎈윞占쎈뙃�뜝�럥�걫占쎈쐻�뜝占� 癲ル슢�뀈泳�怨뀀눀占쎄섶占쎌굲占쎈빝�뜝占� => JSON => VueJS占쎌뒙占쎈뙔占쎌굲 占쎈쐻占쎈윪占쎌벁占쎈쐻占쎈윥�땻占�
		Map map = new HashMap();
		map.put("list", list);
		map.put("totalpage", totalpage);
		map.put("curpage", page);
		map.put("startPage", startpage);
		map.put("endPage", endpage);
		map.put("wineTcount", wineTcount);
		map.put("wtypes", wtypes);
		map.put("foods", foods);
		map.put("aroma", aroma);

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}

	@GetMapping(value = "shop/detail_vue.do", produces = "text/plain;charset=UTF-8")
	public String wine_detail(int wno, int count, HttpSession session) throws Exception {
		String id = (String)session.getAttribute("userId");
		
		WineVO vo = sservice.wineDetailData(wno);
		List<String> gname = sservice.grapeName(wno);
		List<String> nname = sservice.nationName(wno);
		List<WineVO> otherSeller = sservice.otherWine_seller(wno);
		List<WineVO> otherMaker = sservice.otherWine_maker(wno);
		List<WineReviewVO> reviewListData = wservice.reviewList(wno, count);
		int reviewCount = wservice.reviewTotalCount(wno);
		int likeCount = lservice.wineLikeCount(wno);
		String sellerName = sservice.selectUsername (wno);

		
		String[] gnolink = {};
		if (vo.getGrape() != null) {
			gnolink = vo.getGrape().split(",");
		}
		String[] nnolink = vo.getNation().split(",");
		String mnolink = vo.getMaker();

		Map map = new HashMap();
		map.put("vo", vo);
		map.put("gname", gname);
		map.put("nname", nname);
		map.put("gnolink", gnolink);
		map.put("nnolink", nnolink);
		map.put("mnolink", mnolink);
		map.put("otherSeller", otherSeller);
		map.put("otherMaker", otherMaker);
		map.put("reviewListData", reviewListData);
		map.put("count", count); // review List page
		map.put("reviewCount", reviewCount);
		map.put("likeCount", likeCount);
		map.put("sellerName", sellerName);
		
		int reviewCheck = 0;
		if(id != null) {	
			reviewCheck =  wservice.reviewCheck(wno, id);
		}
		map.put("reviewCheck", reviewCheck);
		
		int Lcheck = 0;
		if(id != null) {
			Lcheck = lservice.likeCheck(wno, id);
		}		
		map.put("Lcheck", Lcheck);			

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;

	}

	@PostMapping(value = "shop/cart_insert.do", produces = "text/plain;charset=UTF-8")
	public String wine_cart(int wno, int account, HttpSession session) throws Exception {
		String result = "";
		try {
			String id = (String) session.getAttribute("userId");
			Wine_CartVO vo = new Wine_CartVO();
			vo.setWno(wno);
			vo.setUserid(id);
			vo.setAccount(account);

			int count = sservice.wineCartwnoCount(wno);
			if (count == 0) {
				sservice.insertCart(vo);
			} else {
				sservice.wineCartAccountUpdate(vo);
			}
			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage();
		}
		return result = "";
	}

	@GetMapping(value = "shop/buypage_vue.do", produces = "text/plain;charset=UTF-8")
	public String wine_buy(int wno, HttpSession session) throws Exception {
		WineVO vo = sservice.winebuy(wno);
		String id = (String) session.getAttribute("userId");
		List<MyCouponVO> cvo = sservice.selectCoupon(id);
		String userPoint = sservice.getPoint(id);
		String userGrade = sservice.getgrade(id);
		List<DeliveryVO> userDeli = sservice.getDeli(id);

		Map map = new HashMap();
		map.put("vo", vo);
		map.put("cvo", cvo);
		map.put("userPoint", userPoint);
		map.put("userDeli", userDeli);
		map.put("userGrade", userGrade);

		String psseller = vo.getSeller();
		map.put("seller", psseller);

		int pswno = vo.getWno();
		map.put("wno", pswno);

//		占쏙옙占쎌뿯 筌≪뼔�뮉 for �눧占�
		String s = vo.getType();
		int typeIndex = 0;

		for (int i = 1; i < wtypes.length; i++) {
			if (wtypes[i].equals(s)) {
				typeIndex = i;
				break;
			}
		}
		map.put("type", typeIndex);
		List<PromotionSaleVO> psvo = sservice.promotionGetSale(map);
		map.put("psvo", psvo);

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}

	@PostMapping(value = "shop/payment_vue.do", produces = "text/plain;charset=UTF-8")
	public String wine_payment(Wine_PaymentVO vo, MyCouponVO mvo, MemberVO memvo, int mipoint, HttpSession session) {
		String result = "";
		try {
			String id = (String) session.getAttribute("userId");
			memvo.setUserId(id);
			vo.setUserid(id);

			sservice.insertPayment(vo);
			sservice.useCoupon(mvo);

			sservice.usePoint(memvo);// mipoint 諛쏆븘�빞�븿
			sservice.plusPoint(memvo);// plpoint 諛쏆븘�빞�븿

			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage();
		}

		return result;
	}

	@PostMapping(value = "shop/seller_report.do", produces = "text/plain;charset=UTF-8")
	public String wine_sellerReport(Wine_ReportVO revo, HttpSession session) {
		String result = "";
		try {
			String id = (String) session.getAttribute("userId");
			revo.setUserid(id);

			sservice.insertReport(revo);

			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage();
		}
		return result;
	}

	@GetMapping(value = "shop/review_delete", produces = "text/plain;charset=UTF-8")
	public String review_delete(WineReviewVO vo, HttpSession session) {
		String id = (String) session.getAttribute("userId");
		String result = "";
		try {
			wservice.reviewDelete(vo);
			vo.setUserid(id);
			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage();
		}
		return result;
	}

	@GetMapping(value = "mypage/vueMyPaymentList.do", produces = "text/plain;charset=UTF-8")
	public String mypageVueMyPayment(int page, HttpSession session) throws Exception {
		Map map = new HashMap();

		String id = (String) session.getAttribute("userId");

		MemberVO mvo = mService.memberDetail(id);
		int rowsize = 10;
		int start = (rowsize * page) - (rowsize - 1);
		int end = rowsize * page;

		map.put("start", start);
		map.put("end", end);
		map.put("userId", id);
		map.put("grade", mvo.getGrade());
		List<Wine_PaymentVO> list = sservice.myPaymentList(map);
		int totalPage = sservice.myPaymentTotalPage(map);

		map = new HashMap();
		map.put("list", list);
		map.put("curPage", page);
		map.put("totalPage", totalPage);

		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}

	@GetMapping(value = "shop/likeOn.do", produces = "text/plain;charset=UTF-8")
	public String likeOn(int wno, LikeVO lvo, HttpSession session) throws Exception {
		String id = (String) session.getAttribute("userId");

		int likeOn = lservice.wineLikeOn(wno, id);

		return "";
	}

	@GetMapping(value = "shop/likeOff.do", produces = "text/plain;charset=UTF-8")
	public String likeOff(int wno, HttpSession session) throws Exception {
		String id = (String) session.getAttribute("userId");

		int likeOff = lservice.wineLikeOff(wno, id);

		return "";
	}

}
