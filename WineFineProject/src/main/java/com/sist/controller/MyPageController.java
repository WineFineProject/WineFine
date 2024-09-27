package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {
 @GetMapping("mypage/mypageHome.do")
 public String mypageHome() {
	 return "mypage/mypageHome";
 }
}
