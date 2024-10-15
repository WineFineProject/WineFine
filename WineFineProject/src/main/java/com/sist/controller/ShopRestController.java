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
	String[] wtypes= {"","�젅�뱶","�솕�씠�듃","�뒪�뙆�겢留�","二쇱젙媛뺥솕","湲고�"};
	
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
//		�뜝�럥�몥�뜝�럩逾졾뜝�럡�댉占쎈ご�뜝占� 嶺뚮ㅄ維곲뇡�꼻�삕�땻占� => JSON => VueJS�슖�댙�삕 �뜝�럩�쓧�뜝�럥苑�
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
		List<WineVO> otherSeller = sservice.otherWine_seller(wno);
		List<WineVO> otherMaker = sservice.otherWine_maker(wno);		
		
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
		map.put("otherSeller", otherSeller);
		map.put("otherMaker", otherMaker);
		
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
		
	}
	@GetMapping(value = "shop/buy_vue.do", produces = "text/plain;charset=UTF-8")
	public String wine_buy(int wno,HttpSession session) throws Exception{
		WineVO vo = sservice.winebuy(wno);
		String id = (String)session.getAttribute("userId");
		List<MyCouponVO> cvo = sservice.selectCoupon(id);
		String userPoint = sservice.getPoint(id);
		List<DeliveryVO> userDeli = sservice.getDeli(id);
		
		Map map = new HashMap();
		map.put("vo", vo);
		map.put("cvo", cvo);
		map.put("userPoint", userPoint);
		map.put("userDeli", userDeli);
		
		String psseller = vo.getSeller();
		map.put("seller", psseller);
		
		int pswno = vo.getWno();
		map.put("wno", pswno);
		
//		���엯 李얜뒗 for 臾�
		String s = vo.getType();
		int typeIndex = 0;
		
		for(int i = 1 ; i<wtypes.length ;i++) {
			if(wtypes[i].equals(s)) {
				typeIndex = i;
				break;
			}
		}		
		map.put("type", typeIndex);	
		List<PromotionSaleVO> psvo = sservice.promotionGetSale(map);
		map.put("psvo", psvo);
//		蹂댁쑀�븳荑좏룿 list �떎 �굹�삤寃� �븯湲� 
//		二쇱냼吏� 異붽��븯�뒗李� �꽔�뼱�몢湲�   state 1 �씠 湲곕낯 諛곗넚吏� 0�씠 �씠�쇅 ���옣 諛곗넚吏�
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}
	
	
	
	
}





