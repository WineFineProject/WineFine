package com.sist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.BoardService;
import com.sist.service.ReportService;
import com.sist.service.ShopService;
import com.sist.service.WineReviewService;
import com.sist.vo.MemberVO;
import com.sist.vo.Wine_ReportVO;

@RestController
public class ReportRestController {
  @Autowired
  private ReportService rService;
  @Autowired
  private BoardService bService;
  @Autowired
  private ShopService sService;
  @Autowired
  private WineReviewService wService;
  @GetMapping(value = "admin/reportListVue.do", produces = "text/plain;charset=UTF-8")
  public String reportList(int page) throws Exception
  {
	  int rowSize=10;
	  int start=(rowSize*page)-(rowSize-1);
	  int end=rowSize*page;
	  Map map=new HashMap();
	  map.put("start", start);
	  map.put("end", end);
	  
	  List<Wine_ReportVO> report=rService.reportListData(map);
	  int count=rService.reportListCount();
	  int totalpage=(int)(Math.ceil(count)/(double)rowSize);
	  final int BLOCK=10;
	  int startPage=((page-1)/BLOCK*BLOCK)+1;
	  int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
	  
	  if(endPage>totalpage)
		  endPage=totalpage;
	  
	  map=new HashMap(); 
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
	  ObjectMapper mapper=new ObjectMapper();
	  String json=mapper.writeValueAsString(vo);
	  return json;
	  
  }
  @GetMapping(value = "admin/reportDelete.do",produces = "text/plain;charset=UTF-8")
  public void reportDelete(int tno,int type) 
  {
	  try {
		  if(type==1) {
			  bService.boardReplyAllDelete(tno);
		      bService.boardDelete(tno);
		  }
		  if(type==2){
			  int depth=bService.boardInfo(tno);
			  if(depth==1)
				  bService.boardRepliesDelete(tno);
			  else
				  bService.boardReplyDelete(tno);
		  }
		  if(type==3) {  
			  sService.reportWineUpdate(tno);
		  }
		  if(type==4) {
			  wService.mypageReviewDelete(tno);
		  }
	  }catch(Exception ex)
	  {
		  ex.printStackTrace();
	  }
	  
  }
  @GetMapping(value = "admin/reportState.do",produces = "text/plain;charset=UTF-8")
  public void reportState(int wreno)
  {
	  rService.reportState(wreno);
  }
}
