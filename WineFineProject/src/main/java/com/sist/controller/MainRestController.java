package com.sist.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.dao.*;
import com.sist.service.BannerService;
import com.sist.vo.*;

@RestController
public class MainRestController {
	@Autowired
	WineDAO dao;
	@Autowired
	private BannerService bService;
	@GetMapping(value = "main/list.do", produces = "text/plain;charset=UTF-8")
	public String mainList(int page, @RequestParam Map params) {
		String json = "";
		int start = (page - 1) * 12 + 1;
		params.put("start", start);
		List<WineVO> list = dao.wineListData(params);
		params.put("list", list);
		int totalPage = dao.wineTotalPage();
		int startPage = (page - 1) / 10 * 10 + 1;
		int endPage = startPage + 10 - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		params.put("startPage", startPage);
		params.put("endPage", endPage);
		params.put("totalPage", totalPage);
		params.put("curPage", page);

		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(params);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	/*	public String mainList(int page, @RequestParam Map params) {
			System.out.println(params);
			String json="";
			int start=(page-1)*12+1;
			int end=start+12-1;
			System.out.println(params.get("types"));
			params.put("start", start);
			params.put("end", end);
			List<WineVO> list=dao.wineListData(params);
			params.put("list", list);
			int totalPage=dao.wineTotalPage();
			int startPage=(page-1)/10*10+1;
			int endPage=startPage+10-1;
			if(endPage>totalPage)
				endPage=totalPage;
			params.put("startPage", startPage);
			params.put("endPage", endPage);
			params.put("totalPage", totalPage);
			params.put("curPage", page);
			
			ObjectMapper mapper=new ObjectMapper();
			try {
				json=mapper.writeValueAsString(params);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			return json;
		}
	*/
	@GetMapping(value = "main/vueMain.do", produces = "text/plain;charset=UTF-8")
	public String mainVue() throws Exception{
		List<PromotionBannerVO> list=bService.promotionBannerList();
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(list);
	}
	@GetMapping(value = "main/vuePromotion.do", produces = "text/plain;charset=UTF-8")
	public void mainVuePromotion(int pbno) {
		bService.promotionclick(pbno);
	}
}
