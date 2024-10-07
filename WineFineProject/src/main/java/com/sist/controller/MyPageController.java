package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {
 @GetMapping("mypage/mypageHome.do")
 public String mypageHome() {
	 return "mypage/mypageHome";
 }
 
 @GetMapping("mypage/coupon.do")
 public String mypageCoupon() {
	 return "mypage/coupon";
 }
 //구매내역
 //예약내역
 
 //작성한글
 @GetMapping("mypage/myBoard.do")
 public String mypageBoardList(String id){
	 return "mypage/myBoard"; 
 } //작성리뷰
 
 //좋아요
 
}
