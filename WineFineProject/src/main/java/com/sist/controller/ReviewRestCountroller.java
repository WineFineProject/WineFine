package com.sist.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.service.WineReviewServiceImpl;
import com.sist.vo.WineReviewVO;

@RestController
public class ReviewRestCountroller {
	@Autowired
	private WineReviewServiceImpl wservice;
	
	@PostMapping(value = "shop/review_insert.do",produces = "text/plain;charset=UTF-8")
	public String review_insert(HttpSession session, int wno, WineReviewVO vo) {
		String result = "";
		String id=(String)session.getAttribute("userId");
		String nickName=(String)session.getAttribute("nickName");
		try {
			vo.setUserid(id);
			vo.setNickname(nickName);
			
			wservice.reviewInsert(vo);
			
			result = "yes";
		}catch(Exception ex) {
			result = ex.getMessage();
		}
		return result;
	}
	
}
