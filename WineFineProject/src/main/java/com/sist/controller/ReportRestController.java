package com.sist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.ReportService;
import com.sist.vo.MemberVO;
import com.sist.vo.Wine_ReportVO;

@RestController
public class ReportRestController {
  @Autowired
  private ReportService rService;
  
  @GetMapping(value = "admin/reportListVue.do", produces = "text/plain;charset=UTF-8")
  public String reportList(int page) throws Exception
  {
	  int rowSize=10;
	  int start=(rowSize*page)-(rowSize-1);
	  int end=rowSize*page;
	  
	  List<Wine_ReportVO> report=rService.reportListData(start, end);
	  int count=rService.reportListCount();
	  int totalpage=(int)(Math.ceil(count)/(double)rowSize);
	  final int BLOCK=10;
	  int startPage=((page-1)/BLOCK*BLOCK)+1;
	  int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
	  
	  if(endPage>totalpage)
		  endPage=totalpage;
	  
	  Map map=new HashMap(); 
	  map.put("report", report);
	  map.put("count", count);
	  map.put("curpage", page);
	  map.put("totalpage", totalpage);
	  map.put("startPage", startPage);
	  map.put("endPage", endPage);
	  
	  ObjectMapper mapper=new ObjectMapper();
	  String json=mapper.writeValueAsString(map);
	  
	  return json;
  }
  
  @GetMapping(value = "admin/reportBoardVue.do", produces = "text/plain;charset=UTF-8")
  public String reportboard(int wreno,int type) throws Exception
  {
	  Wine_ReportVO vo=new Wine_ReportVO();
	  try {
		  if(type==1)
			  vo=rService.reportBoardData(wreno);
		  else if(type==2)
			  vo=rService.reportReplyData(wreno);
		  else if(type==3)
			  vo=rService.reportWineData(wreno);
		  else if(type==4)
			  vo=rService.reportReviewData(wreno);
		  
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	  System.out.println(vo);
	  ObjectMapper mapper=new ObjectMapper();
	  String json=mapper.writeValueAsString(vo);
	  return json;
	  
  }
}
