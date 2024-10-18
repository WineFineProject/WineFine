package com.sist.controller;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.BlackListService;
import com.sist.service.MemberService;
import com.sist.vo.*;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class BlackListRestController {
   @Autowired
   private BlackListService bService;
   @PostMapping(value = "seller/blackListInsert.do", produces = "text/plain;charset=UTF-8")
   public void blackListInsert(BlackListVO vo,HttpSession session) 
   {
       vo.setSendid((String)session.getAttribute("userId"));
	   bService.blackListInsert(vo);
   }
   
   @GetMapping(value = "seller/blackListVue.do", produces = "text/plain;charset=UTF-8")
   public String blackListData(HttpSession session, int page,String fd,String option) throws Exception
   {
	   if(fd==null)
		 fd="";  
	   if(option==null)
		   option="userName";
	   
	   String id=(String)session.getAttribute("userId");
	   int rowSize=10;
	   int start=(rowSize*page)-(rowSize-1);
	   int end=rowSize*page;
	   
	   final int BLOCK=10;
	   int startPage=((page-1)/BLOCK*BLOCK)+1;
	   int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		  
	   Map map=new HashMap(); 
	   map.put("fd", fd);
	   map.put("userId", id);
	   map.put("option", option);
	   map.put("start", start);
	   map.put("end", end);
	   
	   int totalpage=bService.blackListCount(map);
	   if(endPage>totalpage)
		   endPage=totalpage;
	   
	   List<MemberVO> black=bService.blackList(map);
	   map.put("curpage", page);
	   map.put("totalpage", totalpage);
	   map.put("startPage", startPage);
	   map.put("endPage", endPage);
	   map.put("black", black);
	   
	   ObjectMapper mapper=new ObjectMapper();
	   String json=mapper.writeValueAsString(map);
		  
	   return json;
   }
   @GetMapping(value = "seller/blackListDelete.do", produces = "text/plain;charset=UTF-8")
   public void blackListDelete(HttpSession session,String recvid,String sendid) throws Exception
   {
	   String id=(String)session.getAttribute("userId");
   }
}
