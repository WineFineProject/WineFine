package com.sist.controller;
import java.util.*;

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
	private ShopService sservice;
	@Autowired
	public ShopRestController(ShopService sservice) {
		this.sservice = sservice;
	}
	@Autowired
	private WineDAO wdao;
	@Autowired
	private ShopDAO sdao;
	
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
		WineVO vo = sdao.wineDetailData(wno);
		List<String> gname = sdao.grapeName(wno);
		List<String> nname = sdao.nationName(wno);
		
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
	public String wine_buy(int wno, String id) throws Exception{
		WineVO vo = sdao.winebuy(wno);
		List<MyCouponVO> cvo = sdao.selectCoupon(id);
		
		Map map = new HashMap();
		map.put("vo", vo);
		map.put("cvo", cvo);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		return json;
	}
	
	
	
	
}






