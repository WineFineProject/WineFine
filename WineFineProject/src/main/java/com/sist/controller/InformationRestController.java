package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.InformationService;
import com.sist.vo.*;
import java.util.*;
@RestController
public class InformationRestController {
	@Autowired
	private InformationService iService;
	
	// 포도 목록 페이지
	@GetMapping(value = "grape/listVue.do", produces ="text/plain;charset=UTF-8")
	public String grapeListData(int page, String fd) throws Exception 
	{
		Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		map.put("start", start);
		map.put("end", end);
		map.put("fd", fd);
		List<GrapeVO> grapes=iService.grapeListData(map);
		  
        int count=iService.grapeTotalPage(map);
        int totalpage=(int)(Math.ceil(count/12.0));
        final int BLOCK=10;
  	    int startPage=((page-1)/BLOCK*BLOCK)+1;
  	    int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
  	    
  	    if(endPage>totalpage)
		    endPage=totalpage;
  	    
        map.put("grapes", grapes);
        map.put("curpage", page);
  	    map.put("totalpage", totalpage);
  	    map.put("startPage", startPage);
  	    map.put("endPage", endPage);
        map.put("count", count);
        ObjectMapper mapper=new ObjectMapper();
        String json=mapper.writeValueAsString(map);
        return json;
    }
	// 포도 상세 페이지
	@GetMapping(value = "grape/detailVue.do", produces = "text/plain;charset=UTF-8")
    public String grapeDetailData(int no) throws Exception 
	{
        GrapeVO vo=iService.grapeDetailData(no);
        ObjectMapper mapper=new ObjectMapper();
        String json=mapper.writeValueAsString(vo);
        
        return json;
    }
	// 포도 품종 검색
    @GetMapping(value = "grape/find.do", produces = "text/plain;charset=UTF-8")
    public String findGrapes(int page,String fd) throws Exception 
    {
    	int rowSize=12;
 	    int start=(rowSize*page)-(rowSize-1);
 	    int end=rowSize*page;
 	    Map map=new HashMap();
 	    map.put("start",start);
 	    map.put("end", end);
 	    map.put("fd", fd);
 	    
 	    List<GrapeVO> list=iService.grapeListData(map);
 	    int totalpage=iService.grapeTotalPage(map);
 	    
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
	   
	    ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(map);
	    return json;
    }
	// 생산지역 목록 페이지
	@GetMapping(value = "nation/listVue.do", produces = "text/plain;charset=UTF-8")
	public String nationListData(int page, String fd) throws Exception 
	{
		Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		map.put("start", start);
		map.put("end", end);
		map.put("fd", fd);
		
	    List<NationVO> nations=iService.nationListData(map);
	    int count=iService.nationTotalPage(map);
        int totalpage=(int)(Math.ceil(count/12.0));
        
        final int BLOCK=10;
  	    int startPage=((page-1)/BLOCK*BLOCK)+1;
  	    int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
  	    
  	    if(endPage>totalpage)
		    endPage=totalpage;
  	    
        map.put("nations", nations);
        map.put("curpage", page);
  	    map.put("totalpage", totalpage);
  	    map.put("startPage", startPage);
  	    map.put("endPage", endPage);
  	    map.put("count", count);
	        
  	    ObjectMapper mapper=new ObjectMapper();
        String json=mapper.writeValueAsString(map);
        return json;
	}
	// 생산지역 상세 페이지
	@GetMapping(value = "nation/detailVue.do", produces = "text/json;charset=UTF-8")
    public String nationDetailData(int no) throws Exception 
	{
        NationVO vo=iService.nationDetailData(no);
        ObjectMapper mapper=new ObjectMapper();
        String json=mapper.writeValueAsString(vo);
        
        return json;
    }
	// 생산자 목록 
	@GetMapping(value = "maker/listVue.do", produces = "text/json;charset=UTF-8")
    public String makerListData(int page, String fd) throws Exception 
	{
		Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		map.put("start", start);
		map.put("end", end);
		map.put("fd", fd);
		
        List<MakerVO> makers=iService.makerListData(map);
        int count=iService.makerTotalPage(map);
        int totalpage=(int)(Math.ceil(count/12.0));
        
        final int BLOCK=10;
  	    int startPage=((page-1)/BLOCK*BLOCK)+1;
  	    int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
  	    
  	    if(endPage>totalpage)
		    endPage=totalpage;
  	    
        map.put("makers", makers);
        map.put("curpage", page);
  	    map.put("totalpage", totalpage);
  	    map.put("startPage", startPage);
  	    map.put("endPage", endPage);
  	    map.put("count", count);
	        
  	    ObjectMapper mapper=new ObjectMapper();
        String json=mapper.writeValueAsString(map);
        return json;
    }
	// 생산자 상세 
	@GetMapping(value = "maker/detailVue.do", produces = "text/json;charset=UTF-8")
	public String makerDetailData(int no) throws Exception 
	{
	    MakerVO vo=iService.makerDetailData(no);
	    ObjectMapper mapper=new ObjectMapper();
        String json=mapper.writeValueAsString(vo);
        
        return json;
	}
}
