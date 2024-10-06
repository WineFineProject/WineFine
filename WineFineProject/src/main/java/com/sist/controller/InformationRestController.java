package com.sist.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
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
	public String grapeListData() throws Exception 
	{
        List<GrapeVO> grapes=iService.grapeListData();
        Map map=new HashMap();
        map.put("grapes", grapes);
        
        ObjectMapper mapper=new ObjectMapper();
        return mapper.writeValueAsString(map);
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
    public String findGrapes(String fd) throws Exception 
    {
        Map map=new HashMap();
        map.put("fd", fd);
        
        ObjectMapper mapper=new ObjectMapper();
        return mapper.writeValueAsString(map);
    }
	// 생산지역 목록 페이지
	@GetMapping(value = "nation/listVue.do", produces = "text/plain;charset=UTF-8")
	public String nationListData() throws Exception 
	{
	    List<NationVO> nations=iService.nationListData();
	    Map map=new HashMap();
	    map.put("nations", nations);
	        
	    ObjectMapper mapper=new ObjectMapper();
	    return mapper.writeValueAsString(map);
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
    public String makerListData() throws Exception 
	{
        List<MakerVO> makers=iService.makerListData();
        Map map=new HashMap();
        map.put("makers", makers);
        
        ObjectMapper mapper=new ObjectMapper();
        return mapper.writeValueAsString(map);
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
