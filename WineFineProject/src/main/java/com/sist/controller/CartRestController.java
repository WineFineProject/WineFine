package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.CartVO;
import com.sist.vo.WineVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.dao.CartDAO;
import com.sist.service.CartService;


@RestController
public class CartRestController {
	@Autowired
	private CartService cService;
	@Autowired
	private CartDAO cDao;
	
	@GetMapping(value = "cart/inMyCart_vue.do",produces = "text/plain;charset=UTF-8")
	public String inMyCart(@RequestParam(required = false) String id) throws Exception
	{
		 if (id == null) {
		        return "redirect:/member/login.do";
		    }
		List<CartVO> cartListData = cDao.cartListData(id);
		
		//WineVO wineData = cDao.getWine(wno);
				
		Map map = new HashMap();
		map.put("list", cartListData);
		//map.put("wine",wineData);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return "json";
	}
	
//	@GetMapping(value = "cart/insert_vue_ok.do", produces = "text/plain;charset=UTF-8")
//	public String addCart(CartVO vo)
//	{
//		return cService.addCart(vo);
//	}
//	
//	@GetMapping(value = "cart/update_vue_ok.do",produces = "text/plain;charset=UTF-8")
//	public int updateCart(int cno)
//	{
//		return cService.updateCart(cno);
//	}
//	
//	@GetMapping(value = "cart/delete_vue.do",produces = "text/plain;charset=UTF-8")
//	public int delCart(int cno)
//	{
//		return cService.delCart(cno);
//	}
	
	
}	
