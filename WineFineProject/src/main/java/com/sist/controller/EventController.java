package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.EventService;
import com.sist.vo.EventVO;

@Controller
public class EventController {
   @Autowired
   private EventService eService;
   
   @GetMapping("event/list.do")
   public String eventList()
   {
	   return "event/list";
   }
   
   @GetMapping("event/detail.do")
   public String eventDetail(int weno,Model model)
   {
	   model.addAttribute("weno", weno);
	   return "event/detail";
   }
}
