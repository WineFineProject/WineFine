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
		 if (id == null || id.isEmpty()) {
		        return "redirect:/member/login.do"; // 또는 적절한 에러 응답
		    }
		List<CartVO> cartListData = cDao.cartListData(id);
		
		Map map = new HashMap();
		map.put("list", cartListData);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return "json";
	}
}	
