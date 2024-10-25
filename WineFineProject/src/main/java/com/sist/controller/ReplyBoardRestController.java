package com.sist.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class ReplyBoardRestController {
	@Autowired
	private ReplyBoardService rService;
	@Autowired
	private ShopService sService;

	// 와인 검색
	@GetMapping(value = "replyboard/findWine.do", produces = "text/plain;charset=UTF-8")
	public String searchWine(String fd, HttpSession session) throws Exception {
		Map map = new HashMap();
		map.put("fd", fd);
		map.put("id", "");
		List<WineVO> list = sService.wineFindList(map);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		return json;
	}

	// 게시판 목록
	@GetMapping(value = "replyboard/listvue.do", produces = "text/plain;charset=UTF-8")
	public String replyboardList(String page, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userId");
		if (userid == null) {
			userid = "";
		}

		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		Map map = new HashMap();
		int rowSize = 10;
		int start = (rowSize * curpage) - (rowSize - 1);
		int end = rowSize * curpage;
		List<ReplyBoardVO> list = rService.replyListData(start, end, userid);
		int count = rService.replyCount();
		int totalpage = (int) (Math.ceil(count / (double) rowSize));
		count = count - ((curpage * rowSize) - rowSize);
				
		map.put("list", list);
		map.put("curpage", curpage);
		map.put("totalpage", totalpage);
		map.put("count", count);
		map.put("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);

		return json;
	}

	// 게시글 등록
	@PostMapping("replyboard/insertOk.do")
	public String replyboardInsertOk(ReplyBoardVO vo, HttpSession session) {
		vo.setUserid((String) session.getAttribute("userId"));
		vo.setNickname((String) session.getAttribute("nickName"));

		vo.setGroup_step(0);
		vo.setIsreply(0);
		if (vo.getType() != 1)
			vo.setRecvid("admin");
		rService.replyInsert(vo);
		return "redirect:../replyboard/list.do";
	}

	// 게시글 상세
	@GetMapping(value = "replyboard/detailvue.do", produces = "text/plain;charset=UTF-8")
	public String replyboardDetailVue(int wrno) throws Exception {
		ReplyBoardVO vo = rService.replyDetailData(wrno);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(vo);
		return json;
	}

	// 게시글 수정
	@GetMapping(value = "replyboard/updatevue.do", produces = "text/plain;charset=UTF-8")
	public String replyboardUpdate(int wrno) throws Exception {
		ReplyBoardVO vo = rService.replyDetail(wrno);
		System.out.println(vo);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(vo);
		return json;
	}

	@PostMapping(value = "replyboard/updateOkvue.do", produces = "text/plain;charset=UTF-8")
	public String replyboardUpdateOk(ReplyBoardVO vo) {
		System.out.println(vo);
		String result = "";
		try {
			rService.replyUpdateData(vo);
			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage();
		}
		return result;
	}

	// 게시글 삭제
	@GetMapping(value = "replyboard/deletevue.do", produces = "text/plain;charset=UTF-8")
	public String replyboardDelete(int wrno) throws Exception {
		String result = "";
		try {
			rService.replyDelete(wrno);
			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage();
		}
		return result;
	}

	@GetMapping(value = "replyboard/vueSellerReplyList.do", produces = "text/plain;charset=UTF-8")
	public String replyVueSellerReply(int page, HttpSession session) throws Exception{
		String userid = (String) session.getAttribute("userId");

		Map map = new HashMap();
		int rowSize = 10;
		int start = (page-1)*rowSize+1;
		int end = rowSize * page;
		map.put("start", start);
		map.put("end", end);
		map.put("userid", userid);
		List<ReplyBoardVO> list = rService.sellrReplyListData(map);
		int count = rService.sellerReplyCount(userid);
		int totalpage = (int) (Math.ceil(count / (double) rowSize));
		count = count - (page - 1) * rowSize;

		map= new HashMap();
		map.put("list", list);
		map.put("curPage", page);
		map.put("totalPage", totalpage);
		map.put("count", count);
		map.put("today", new SimpleDateFormat("yyy-MM-dd").format(new Date()));

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);

		return json;
	}
	@PostMapping(value = "replyboard/sellerReplyInsert.do", produces = "text/plain;charset=UTF-8")
	public void sellerReplyInsert(ReplyBoardVO vo, HttpSession session) {
		vo.setUserid((String)session.getAttribute("userId"));
		vo.setNickname((String)session.getAttribute("nickName"));
		rService.sellerReplyInsert(vo);
	}
	@PostMapping(value = "replyboard/adminReplyInsert.do", produces = "text/plain;charset=UTF-8")
	public void adminReplyInsert(ReplyBoardVO vo) {
		vo.setUserid("admin");
		vo.setNickname("관리자");
		rService.sellerReplyInsert(vo);
	}
	
	@GetMapping(value = "replyboard/vueAnswerDetail.do", produces = "text/plain;charset=UTF-8")
	public String replyAnswerDetail(int group_id) throws Exception{
		ReplyBoardVO vo=rService.replyAnswerDetailData(group_id);
		ObjectMapper mapper=new ObjectMapper();
		return mapper.writeValueAsString(vo);
	}
	
	@GetMapping(value = "replyboard/vueAnswerDelete.do", produces = "text/plain;charset=UTF-8")
	public void replyAnswerDelete(int wrno) {
		rService.replyAnswerDelete(wrno);
	}
	
	@GetMapping(value = "replyboard/vueSellerUpdate.do", produces = "text/plain;charset=UTF-8")
	public void replySellerUpdate(ReplyBoardVO vo) {
		rService.sellerReplyUpdate(vo);
	}
	
	@GetMapping(value = "replyboard/vueAdminReplyList.do", produces = "text/plain;charset=UTF-8")
	public String replyVueAdminReply(int page) throws Exception{

		Map map = new HashMap();
		int rowSize = 10;
		int start = (page-1)*rowSize+1;
		int end = rowSize * page;
		map.put("start", start);
		map.put("end", end);
		List<ReplyBoardVO> list = rService.adminReplyListData(map);
		int count = rService.replyCount();
		int totalpage = (int) (Math.ceil(count / (double) rowSize));
		count = count - (page - 1) * rowSize;

		map= new HashMap();
		map.put("list", list);
		map.put("curPage", page);
		map.put("totalPage", totalpage);
		map.put("count", count);
		map.put("today", new SimpleDateFormat("yyy-MM-dd").format(new Date()));

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);

		return json;
	}
	// shop게시판 목록
	@GetMapping(value = "replyboard/shoplist_vue.do", produces = "text/plain;charset=UTF-8")
	public String shopReplyboardList(int count, String page, HttpSession session, int wno) throws Exception {
		String userid = (String) session.getAttribute("userId");
		if (userid == null) {
			userid = "";
		}
		
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		Map map = new HashMap();
		int rowSize = 10;
		int start = (rowSize * curpage) - (rowSize - 1);
		int end = rowSize * curpage;
		List<ReplyBoardVO> list = rService.shopReplyListData(count, userid, wno);
		int boTocount = rService.shopReplyCount();
		int totalpage = rService.shopReplyTotalPage();
		
		map.put("list", list);
		map.put("boTocount", boTocount);
		map.put("curpage", curpage);
		map.put("totalpage", totalpage);
		map.put("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}

}
