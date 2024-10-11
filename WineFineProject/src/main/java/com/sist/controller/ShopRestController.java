package com.sist.controller;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.dao.ShopDAO;
import com.sist.dao.WineDAO;
import com.sist.service.ShopService;
import com.sist.vo.*;

@RestController
public class ShopRestController {
	String[] wtypes= {"","레드","화이트","스파클링","주정강화","기타"};
	
	private ShopService sservice;
	@Autowired
	public ShopRestController(ShopService sservice) {
		this.sservice = sservice;
	}
	
	@GetMapping(value = "shop/list_vue.do",produces = "text/plain;charset=UTF-8")
	public String shop_list(int page) throws Exception{
		int rowsize=12;
		int start=(rowsize*page)-(rowsize-1);
		int end=rowsize*page;
		
		List<WineVO> list=sservice.wineListData(start, end);

		int totalpage=sservice.shopTotalPage();
		
		final int BLOCK=10;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
		
		if(endpage>totalpage)
			endpage=totalpage;
//		占쎈쑓占쎌뵠占쎄숲�몴占� 筌뤴뫁釉섓옙苑� => JSON => VueJS嚥∽옙 占쎌읈占쎈꽊
		Map map=new HashMap();
		map.put("list",list);
		map.put("totalpage", totalpage);
		map.put("curpage", page);
		map.put("startPage", startpage);
		map.put("endPage", endpage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "shop/detail_vue.do",produces = "text/plain;charset=UTF-8")
	public String wine_detail(int wno) throws Exception{
		WineVO vo = sservice.wineDetailData(wno);
		List<String> gname = sservice.grapeName(wno);
		List<String> nname = sservice.nationName(wno);
		
		String[] gnolink = vo.getGrape().split(",");
		String[] nnolink = vo.getNation().split(",");	
		String mnolink = vo.getMaker();
		
		Map map = new HashMap();
		map.put("vo", vo);
		map.put("gname", gname);
		map.put("nname", nname);
		map.put("gnolink", gnolink);
		map.put("nnolink", nnolink);
		map.put("mnolink", mnolink);
		
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
		
	}
	@GetMapping(value = "shop/buy_vue.do", produces = "text/plain;charset=UTF-8")
	public String wine_buy(int wno,HttpSession session) throws Exception{
		WineVO vo = sservice.winebuy(wno);
		String id = (String)session.getAttribute("userId");
		List<MyCouponVO> cvo = sservice.selectCoupon(id);
		
		Map map = new HashMap();
		map.put("vo", vo);
		map.put("cvo", cvo);
			
		String psseller = vo.getSeller();
		map.put("seller", psseller);
		int pswno = vo.getWno();
		map.put("wno", pswno);
		
//		타입 찾는 for 문
		String s = vo.getType();
		int typeIndex = 0;
		
		for(int i = 1 ; i<wtypes.length ;i++) {
			if(wtypes[i].equals(s)) {
				typeIndex = i;
				break;
			}
		}		
		map.put("type", typeIndex);	
		PromotionSaleVO psvo = sservice.promotionGetSale(map);
//		보유한쿠폰 list 다 나오게 하기 
//		주소지 추가하는창 넣어두기   state 1 이 기본 배송지 0이 이외 저장 배송지
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}
	
	
	
	
}






