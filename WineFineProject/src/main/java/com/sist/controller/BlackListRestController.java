package com.sist.controller;
import com.sist.service.BlackListService;
import com.sist.vo.*;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class BlackListRestController {
   @Autowired
   private BlackListService bService;
   
   @PostMapping(value = "seller/blackListInsert.do", produces = "text/json;charset=UTF-8")
   public void blackListInsert(BlackListVO vo,HttpSession session) 
   {
       vo.setSendid((String)session.getAttribute("userId"));
	   bService.blackListInsert(vo);
   }
}
