package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;import org.springframework.security.config.web.server.ServerHttpSecurity.HttpsRedirectSpec;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

import oracle.jdbc.proxy.annotation.Post;

@RestController
public class MyPageRestController {
	String[] types= {"", "    ", "ȭ  Ʈ", "    Ŭ  ", "    ", "      ȭ", "  Ÿ"};
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
				vo.setSellname("  ü");
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
				vo.setTargetname("  ü");
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
	
	
	// 작성 게시글 리스트 
	@PostMapping(value = "mypage/myBoardList_vue.do", produces = "text/plain;charset=UTF-8")
	public String myBoardList(int page, Integer type, HttpSession session) throws Exception {
	    // 세션에서 사용자 정보 가져오기
		
	    String nickname = (String)session.getAttribute("nickName");
	    
		/*
		 * if (page == null) { page = 1; }
		 */
	    
	    int rowSize = 10;
	    int start = (rowSize * page) - (rowSize - 1);
	    int end = rowSize * page;

	    // 사용자의 게시글 목록 가져오기
	    List<BoardVO> list = mService.myBoardListData(nickname, start, end);
	    int totalpage = mService.myPageBoardTotalPage(nickname);
	    int ctotalpage = mService.myPageCBoardTotalPage(nickname,type);

	    final int BLOCK = 10;
	    int startPage = ((page - 1) / BLOCK * BLOCK) + 1;
	    int endPage = ((page - 1) / BLOCK * BLOCK) + BLOCK;

	    if (type == null || type == 0) {
	        type = 0;
	        if (endPage > totalpage)
	            endPage = totalpage;
	    } else {
	        if (endPage > ctotalpage)
	            endPage = ctotalpage;
	    }

	    // 각 게시글의 댓글 수 가져오기
	    for (BoardVO board : list) {
	        int replyCount = bService.boardReplyCount(board.getBno());
	        board.setReplycount(replyCount);
	    }

	    // 카테고리별 게시글 목록 가져오기
	    List<BoardVO> cList = mService.boardTypeListData(nickname, BLOCK, startPage, endPage);
	    for (BoardVO board : cList) {
	        int replyCount = bService.boardReplyCount(board.getBno());
	        board.setCreplycount(replyCount);
	    }

	    Map<String, Object> map = new HashMap<>();
	    map.put("list", list);
	    map.put("cList", cList);
	    map.put("curpage", page);
	    map.put("totalpage", totalpage);
	    map.put("ctotalpage", ctotalpage);
	    map.put("startPage", startPage);
	    map.put("endPage", endPage);

	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(map);
	    
	    return json;
	}
}
