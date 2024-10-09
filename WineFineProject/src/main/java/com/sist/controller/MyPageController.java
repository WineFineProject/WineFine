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
 @GetMapping("mypage/myBoardList.do")
 public String mypageBoardList(String id){
	 return "mypage/myBoardList"; 
 } //작성리뷰
 
 //좋아요
 
 //배송주소 등록
 @GetMapping("mypage/delivery.do")
 public String mypageDelivery() {
	 return "mypage/delivery";
 }
}
