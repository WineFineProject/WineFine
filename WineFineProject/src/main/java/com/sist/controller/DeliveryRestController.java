package com.sist.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class DeliveryRestController {	
	@Autowired
	private DeliveryService dService;
	
	@GetMapping(value = "delivery/vueDeliveryList.do", produces = "text/plain;charset=UTF-8")
	public String deliveryVueList(HttpSession session) throws Exception{
		String id=(String)session.getAttribute("userId");
		List<DeliveryVO> list=dService.myDeliveryList(id);
		JsonMapper mapper=new JsonMapper();
		return mapper.writeValueAsString(list);
	}
	
	@PostMapping(value = "delivery/vueDeliveryInsert.do", produces = "text/plain;charset=UTF-8")
	public void deliveryInsert(DeliveryVO vo, HttpSession session) {
		System.out.println(vo);
		String id=(String)session.getAttribute("userId");
		vo.setUserId(id);
		dService.myDeliveryInsert(vo);
	}
	
	@GetMapping(value = "delivery/vueDeliveryStateUpdate.do", produces = "text/plain;charset=UTF-8")
	public void deliveryStateUpdate(int wdno, HttpSession session) {
		String id=(String)session.getAttribute("userId");
		dService.myDeliveryStateUpdate(id, wdno);
	}
	
	@GetMapping(value = "delivery/vueDeliveryDelete.do", produces = "text/plain;charset=UTF-8")
	public void deliveryDelete(int wdno) {
		dService.myDeliveryDelete(wdno);
	}
}
