package com.sist.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

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
 @GetMapping("mypage/myReserve.do")
 public String mypageReserve(Model model) {
	 String today=new SimpleDateFormat("YYYY-MM-dd").format(new Date());
	 model.addAttribute("today", today);
	 return "mypage/myReserve";
 }
 //작성한 글
 @GetMapping("mypage/myboardlist.do")
 public String mypageBoardList(String nickName){
	 
	 return "mypage/myboardlist"; 
 } 
 //작성 리뷰
 @GetMapping("mypage/myReview.do")
	public String mypageReview() {
		return "mypage/myReview";
	}
 //좋아요
 @GetMapping("mypage/myLike.do")
 public String mypageLike() {
	 return "mypage/myLike";
 }
 
 //배송주소 등록
 @GetMapping("mypage/delivery.do")
 public String mypageDelivery() {
	 return "mypage/delivery";
 }
 @GetMapping("mypage/myPayment.do")
 public String mypagePayment() {
	 return "mypage/myPayment";
 }
 //회원 탈퇴
 @GetMapping("mypage/my_member_exit.do")
 public String mypagememberexit() {
	 return "mypage/my_member_exit";
 }
 //비밀번호 변경
 @GetMapping("mypage/mypwd.do")
 public String myPwd() {
	 return "mypage/mypwd";
 }
}
