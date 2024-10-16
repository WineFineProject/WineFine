package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
@RestController
public class EventRestController {
  @Autowired
  private EventService eService;
  
  @GetMapping(value="event/listVue.do",produces = "text/plain;charset=UTF-8")
  public String eventList(int page) throws Exception
  {
	    Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		map.put("start", start);
		map.put("end", end);
	   
	   List<EventVO> list=eService.eventListData(start, end);
	   int count=eService.eventTotalPage();
       int totalpage=(int)(Math.ceil(count/12.0));
	   final int BLOCK=10;
	   int startPage=((page-1)/BLOCK*BLOCK)+1;
	   int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
	   
	   if(endPage>totalpage)
		   endPage=totalpage;
	   
	   map=new HashMap();
	   map.put("list", list);
	   map.put("curpage", page);
	   map.put("totalpage", totalpage);
	   map.put("startPage", startPage);
	   map.put("endPage", endPage);
	   map.put("count", count);
	   
	   ObjectMapper mapper=new ObjectMapper();
	   String json=mapper.writeValueAsString(map);
	   
	   return json;
	   
  }
  
  @GetMapping(value="event/detailVue.do",produces = "text/plain;charset=UTF-8")
  public String eventDetail(int weno) throws Exception
  {
	   EventVO vo=eService.eventDetailData(weno);
	   
	   String[] posters = vo.getPoster().split(","); 
	   List<String> pList=new ArrayList<String>();
	   
	   Map map=new HashMap();
	   map.put("pList",posters);
	   map.put("vo", vo);
	   ObjectMapper mapper=new ObjectMapper();
	   String json=mapper.writeValueAsString(map);
	   
	   return json;
  }
  
  @PostMapping(value = "event/reserveInsert.do",produces = "text/plain;charset=UTF-8")
  public void reserveInsert(ReserveVO vo, HttpSession session) throws Exception
  {
	  vo.setUserid((String)session.getAttribute("userId"));
	  System.out.println(vo);
	  eService.reserveInsert(vo);
  }
  
  @GetMapping(value = "event/reservePerson.do",produces = "text/plain;charset=UTF-8")
  public String reservePerson(ReserveVO vo) throws Exception
  {
	  return String.valueOf(eService.reservePerson(vo));
  }
}
