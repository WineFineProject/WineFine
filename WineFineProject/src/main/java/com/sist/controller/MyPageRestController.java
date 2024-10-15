package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.web.server.ServerHttpSecurity.HttpsRedirectSpec;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

import oracle.jdbc.proxy.annotation.Post;

@RestController
public class MyPageRestController {
	String[] types= { "", "레드", "화이트", "스파클링", "로제", "주정강화", "기타" };
	@Autowired
	private CouponService cService;
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private MypageService mService;
	
	
	@GetMapping(value = "mypage/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String mypageVueCouponList(HttpSession session) throws Exception{
		Map map=new HashMap();
		String id=(String)session.getAttribute("userId");
		List<PromotionCouponVO> activeCoupon=cService.promotionCouponListData(id);
		List<MyCouponVO> myCoupon=cService.mypageMyCouponList(id);
		for(MyCouponVO vo:myCoupon) {
			if(vo.getPvo().getType()==1) {
				vo.setSellname("전체");
			}
			else if(vo.getPvo().getType()==2) {
				vo.setSellname(types[vo.getPvo().getType()]);
			}
			else if(vo.getPvo().getType()==3) {
				vo.setSellname(vo.getPvo().getWvo().getNamekor());
			}
		}
		for(PromotionCouponVO vo:activeCoupon) {
			if(vo.getType()==1) {
				vo.setTargetname("전체");
			}
			else if(vo.getType()==2) {
				vo.setTargetname(types[vo.getType()]);
			}
			else if(vo.getType()==3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		map.put("myCoupon", myCoupon);
		map.put("activeCoupon", activeCoupon);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@PostMapping(value = "mypage/vueGetCoupon.do", produces = "text/plain;charset=UTF-8")
	public void mypageVueGetCoupon(MyCouponVO vo, HttpSession session) {
		vo.setRecvid((String) session.getAttribute("userId"));
		cService.getCoupon(vo);
	}
	
	
	
	// 작성 게시글 리스트 mypage/myboardlist.do
	@GetMapping(value="mypage/myboardlist_vue.do",produces = "text/plain;charset=UTF-8")
	  public String mypage_reserve(HttpSession session) throws Exception
	  {
		  String nickname=(String)session.getAttribute("nickName");
		  List<BoardVO> list=mService.myboardListData(nickname, start, end);
		  
		  ObjectMapper mapper=new ObjectMapper();
		  String json=mapper.writeValueAsString(list);
		  return json;
	  }
	

}
