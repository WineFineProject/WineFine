package com.sist.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.WineReviewService;
import com.sist.service.WineReviewServiceImpl;
import com.sist.vo.WineReviewVO;
import com.sist.vo.WineVO;

import oracle.net.aso.l;

import java.util.*;
@RestController
public class ReviewRestCountroller {
	@Autowired
	private WineReviewService wservice;
	
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
		System.out.printf(id);
		System.out.printf(nickName);
		return result;
	}
	
	@GetMapping(value = "mypage/myReviewList.do",produces = "text/plain;charset=UTF-8")
	public String mypageReviewList(int page, HttpSession session) throws Exception{
		Map map=new HashMap();
		
		String id=(String)session.getAttribute("userId");
		int rowSize=10;
		int start=(page-1)*rowSize+1;
		int end=page*rowSize;
		
		map.put("start", start);
		map.put("end", end);
		map.put("userId", id);
		
		List<WineReviewVO> list=wservice.myReviewList(map);
		int totalPage=wservice.myReviewTotalPage(map);
		map= new HashMap();
		map.put("list", list);
		map.put("curPage", page);
		map.put("totalPage", totalPage);
		
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	@GetMapping(value = "mypage/myReviewDelete.do", produces = "text/plain;charset=UTF-8")
	public void mypageReviewDelete(int wrvno, int wno, HttpSession session) {

		wservice.mypageReviewDelete(wrvno);
		
	}
}
