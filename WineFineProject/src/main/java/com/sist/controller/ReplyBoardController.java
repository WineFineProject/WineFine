package com.sist.controller;
import com.sist.vo.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.*;
@Controller
public class ReplyBoardController {
	private ReplyBoardService rService;
	@Autowired
	public ReplyBoardController(ReplyBoardService rService)
	{
		this.rService=rService;
	}
	@GetMapping("replyboard/list.do")
	public String replyboardList(String page,Model model)
	{
		if(page==null)
			   page="1";
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		int rowSize=10;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		List<ReplyBoardVO> list=rService.replyListData(start, end);   
		int count=rService.replyCount();
		int totalpage=(int)(Math.ceil(count/(double)rowSize));
		count=count-((curpage*rowSize)-rowSize);
		
		model.addAttribute("list", list);
		model.addAttribute("curpage", curpage);
		model.addAttribute("totalpage", totalpage);
		model.addAttribute("count", count);
		model.addAttribute("today", new SimpleDateFormat("yyy-MM-dd").format(new Date()));
		return "replyboard/list";
	}
	

}
