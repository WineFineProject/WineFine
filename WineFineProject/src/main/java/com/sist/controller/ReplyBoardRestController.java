package com.sist.controller;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping(value = "replyboard/findWine.do",produces = "text/plain;charset=UTF-8")
	public String searchWine(String fd, HttpSession session) throws Exception 
	{
        Map map=new HashMap();
        map.put("fd", fd);
        List<WineVO> list = sService.wineFindList(map);
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(list);
        return json;
    }

}
