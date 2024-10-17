package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.MypageService;
import com.sist.vo.BoardVO;

@Controller
public class MyPageController {
 @GetMapping("mypage/mypageHome.do")
 public String mypageHome() {
	 return "mypage/mypageHome";
 }

 // 정보 보기 , 수정
 @GetMapping("mypage/my_edit_member.do")
 public String myEdit() {
	 return "mypage/my_edit_member";
 }
 @GetMapping("mypage/my_edit2_member.do")
 public String myEdit2() {
	 return "mypage/my_edit2_member";
 }
 
 @GetMapping("mypage/coupon.do")
 public String mypageCoupon() {
	 return "mypage/coupon";
 }
 //구매내역
 
 //예약내역
 
 //작성한글
 @GetMapping("mypage/myboardlist.do")
 public String mypageBoardList(String nickName){
	 
	 return "mypage/myboardlist"; 
 } 
 //작성리뷰
 
 //좋아요
 
 //배송주소 등록
 @GetMapping("mypage/delivery.do")
 public String mypageDelivery() {
	 return "mypage/delivery";
 }
}
