package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class BoardRestController {
	@Autowired
	private BoardService bService;

	@GetMapping(value="board/list_vue.do",produces = "text/plain;charset=UTF-8")
	public String board_list(int page, Integer type) throws Exception
	{
		int rowSize=10;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;

		List<BoardVO> list=bService.boardListData(start, end);
		int totalpage=bService.boardTotalPage();
		int ctotalpage=bService.cboardTotalPage(type);

		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;

		if(type==null || type==0)
		{
			type=0;
			if(endPage>totalpage)
				endPage=totalpage;
		}
		else 
		{
			if(endPage>ctotalpage)
				endPage=ctotalpage;
		}

		for (BoardVO board : list) {
			int replyCount = bService.boardReplyCount(board.getBno()); // 각 게시물의 bno로 댓글 수 가져오기
			board.setReplycount(replyCount); 
		}

		List<BoardVO> cList=bService.boardTypeListData(type, start, end);  
		for (BoardVO board : cList) {
			int replyCount = bService.boardReplyCount(board.getBno());
			board.setCreplycount(replyCount); 
		}
		Map map=new HashMap();
		map.put("list", list);
		map.put("cList", cList);
		map.put("curpage",page);
		map.put("startPage", startPage);
		map.put("endPage", endPage);

		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);

		return json;
	}

	@GetMapping(value="board/find_vue.do", produces = "text/plain;charset=UTF-8")
	public String board_find_list(int page, Integer type, String find, Integer isSearch) throws Exception {
		int rowSize = 10;
		int start = (rowSize * page) - (rowSize - 1);
		int end = rowSize * page;

		final int BLOCK = 10;
		int startPage = ((page - 1) / BLOCK * BLOCK) + 1;
		int endPage = ((page - 1) / BLOCK * BLOCK) + BLOCK;

		List<BoardVO> list;
		if (isSearch==0) {
			list = bService.boardfindsListData(find, start, end);

		} else {
			list = bService.boardfindnListData(find, start, end);

		}

		for (BoardVO board : list) {
			int replyCount = bService.boardReplyCount(board.getBno());
			board.setReplycount(replyCount);
		}

		if (type == null) {
			type = 0;
		}
		List<BoardVO> cList;
		if (isSearch==0) {
			cList = bService.boardfindTypesListData(type, find, start, end);
			int ftotalpage=bService.boardsfTotalPage(find);
			int cftotalpage = bService.cboardsfTotalPage(type, find);
			if(type == 0)
			{
				if(endPage>ftotalpage)
					endPage=ftotalpage;
			}
			else {
				if(endPage>cftotalpage)
					endPage=cftotalpage;
			}
		} else {
			cList = bService.boardfindTypenListData(type, find, start, end);
			int cftotalpage = bService.cboardnfTotalPage(type, find);
			int ftotalpage=bService.boardnfTotalPage(find);
			if(type == 0)
			{
				if(endPage>ftotalpage)
					endPage=ftotalpage;
			}
			else {
				if(endPage>cftotalpage)
					endPage=cftotalpage;
			}
		}

		for (BoardVO board : cList) {
			int replyCount = bService.boardReplyCount(board.getBno());
			board.setCreplycount(replyCount);
		}

		Map map = new HashMap();
		map.put("list", list);
		map.put("cList", cList);
		map.put("curpage", page);
		map.put("startPage", startPage);
		map.put("endPage", endPage);

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);

		return json;
	}

	@GetMapping(value="board/detail_vue.do",produces = "text/plain;charset=UTF-8")
	public String board_detail(int bno) throws Exception
	{
		BoardVO vo=bService.boardDetailData(bno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}

	@PostMapping(value="board/insert_vue.do",produces = "text/plain;charset=UTF-8")
	public String board_insert(@ModelAttribute BoardVO vo, HttpServletRequest request)
	{
		String result="";
		try
		{
			bService.boardInsert(vo);
			result="yes";  
		}catch(Exception ex)
		{
			result=ex.getMessage();
		}
		return result;
	}
	
	@GetMapping(value="board/update_vue.do",produces = "text/plain;charset=UTF-8")
	public String board_update(Integer bno) throws Exception
	{
		BoardVO vo=bService.boardUpdateData(bno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	@PostMapping(value="board/update_ok_vue.do",produces = "text/plain;charset=UTF-8")
	public String board_update_ok(BoardVO vo,HttpServletRequest request)
	{
		String result="";
		try
		{
			result=bService.boardUpdate(vo);
		}catch(Exception ex) {ex.printStackTrace();}
		return result;
	}
	@GetMapping(value="board/delete_vue.do",produces = "text/plain;charset=UTF-8")
	public String board_delete(int bno,HttpServletRequest request)
	{
		int count = bService.boardReplyCount(bno);
		if(count>0)
		{
			bService.boardReplyAllDelete(bno);
		}
		String result="";
		bService.boardDelete(bno);
		result="yes";
		return result;
	}
	// 댓글
	public String boardReply_list(int bno) 
	{
		String json="";
		try
		{
			List<BoardReplyVO> list=bService.boardReplyListData(bno);
			int count=bService.boardReplyCount(bno);
			Map map =new HashMap();
			map.put("list", list);
			map.put("count", count);
			ObjectMapper mapper=new ObjectMapper();
			json=mapper.writeValueAsString(map);
		}catch(Exception ex) {}
		return json;
	}

	@GetMapping(value="board/reply_read_vue.do",produces = "text/plain;charset=UTF-8")
	public String reply_read(int bno)
	{
		return boardReply_list(bno);
	}

	@PostMapping(value="board/reply_insert_vue.do",produces = "text/plain;charset=UTF-8")
	public String reply_insert(BoardReplyVO vo) throws Exception
	{
		bService.boardReplyInsert(vo);

		return boardReply_list(vo.getBno());
	}

	@PostMapping(value="board/reReply_insert_vue.do",produces = "text/plain;charset=UTF-8")
	public String rereply_insert(BoardReplyVO vo) throws Exception
	{		
			bService.boardReReplyInsert(vo);
		
		return boardReply_list(vo.getBno());
	}
	@PostMapping(value="board/reReply_count_vue.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String rereply_count(BoardReplyVO vo, HttpSession session) throws Exception {
		String result="";
		int root = vo.getRoot();
		int rereplycount = bService.boardReReplyCount(root);
		return (rereplycount == 0) ? "OK" : "NO";
	}
	@GetMapping(value="board/reply_delete_vue.do",produces = "text/plain;charset=UTF-8")
	public String reply_delete(int bno, int brno, int depth)
	{
		 if (depth == 1) 
		 {
		        bService.boardRepliesDelete(brno);
		 } else if (depth == 2) {
		        
		        bService.boardReplyDelete(brno);
		 }
		    return boardReply_list(bno);
	}

	@PostMapping(value="board/reply_update_vue.do",produces = "text/plain;charset=UTF-8")
	public String reply_update(int bno, BoardReplyVO vo)
	{
		bService.boardReplyUpdate(vo);
		return boardReply_list(bno);
	}
	@PostMapping(value="board/breport_insert.do",produces = "text/plain;charset=UTF-8")
	public String breport_insert (Wine_ReportVO vo) throws Exception
	{
		String result="";
		bService.boardReportInsert(vo);		
		result="OK";
		return result;
	}
	
	//noticeboard
	@GetMapping(value="noticeboard/list_vue.do",produces = "text/plain;charset=UTF-8")
	public String noticeboard_list(int page, Integer type) throws Exception
	{
		int rowSize=10;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;

		List<BoardVO> list=bService.noticeboardListData(start, end);
		int totalpage=bService.noticeboardTotalPage();

		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;

		if(endPage>totalpage)
			endPage=totalpage;
		if(type==null)
			type=0;

		List<BoardVO> cList=bService.noticeboardTypeListData(type, start, end);  

		Map map=new HashMap();
		map.put("list", list);
		map.put("cList", cList);
		map.put("totalpage", totalpage);
		map.put("curpage",page);
		map.put("startPage", startPage);
		map.put("endPage", endPage);

		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);

		return json;
	}

	@GetMapping(value="noticeboard/detail_vue.do",produces = "text/plain;charset=UTF-8")
	public String noticeboard_detail(int bno) throws Exception
	{
		BoardVO vo=bService.noticeboardDetailData(bno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}

	@PostMapping(value="noticeboard/insert_vue.do",produces = "text/plain;charset=UTF-8")
	public String noticeboard_insert(@ModelAttribute BoardVO vo, HttpServletRequest request)
	{
		String result="";
		try
		{
			bService.noticeboardInsert(vo);
			result="yes";  
		}catch(Exception ex)
		{
			result=ex.getMessage();
		}
		return result;
	}

	@GetMapping(value="noticeboard/update_vue.do",produces = "text/plain;charset=UTF-8")
	public String noticeboard_update(Integer bno) throws Exception
	{
		BoardVO vo=bService.noticeboardUpdateData(bno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	@PostMapping(value="noticeboard/update_ok_vue.do",produces = "text/plain;charset=UTF-8")
	public String noticeboard_update_ok(BoardVO vo,HttpServletRequest request)
	{
		String result="";
		try
		{
			result=bService.noticeboardUpdate(vo);
		}catch(Exception ex) {ex.printStackTrace();}
		return result;
	}
	@GetMapping(value="noticeboard/delete_vue.do",produces = "text/plain;charset=UTF-8")
	public String noticeboard_delete(int bno,HttpServletRequest request)
	{
		String result=bService.boardDelete(bno);
		return result;
	}

}
