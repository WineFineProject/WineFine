package com.sist.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.web.server.ServerHttpSecurity.HttpsRedirectSpec;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.*;
import com.sist.vo.*;

import oracle.jdbc.proxy.annotation.Post;

@RestController
public class MyPageRestController {
	String[] types= { "", "레드", "화이트", "스파클링", "로제", "주정강화", "기타" };
	@Autowired
	private CouponService cService;
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private MypageService mService;
	
	@Autowired
	private ShopService sService;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	// 회원정보 수정
	@GetMapping(value = "mypage/my_edit2_member_vue.do", produces = "text/plain;charset=UTF-8")
	public String myInfo(@SessionAttribute("userId") String userId) throws Exception
	{	
		
		MemberVO vo = mService.getMyId(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
	/*
	 * @PostMapping(value = "mypage/edit2_ok_vue_do",produces =
	 * "text/plain;charset=UTF-8") public String myInfo_ok(@RequestBody MemberVO vo,
	 * 
	 * @SessionAttribute("userId") String userId) throws Exception {
	 * vo.setUserId(userId);
	 * 
	 * MemberVO updateMember = mService.updateMyInfo(vo);
	 * 
	 * ObjectMapper mapper = new ObjectMapper(); String json =
	 * mapper.writeValueAsString(updateMember); return json; }
	 */
	
	
	 @GetMapping("/mypage/nickname_check_vue.do")
	    public String nickCheck(HttpSession session,String nickName,String userId) {
		 String sessionUserId = (String) session.getAttribute("userId");
	     int count = mService.nickCheck(nickName, userId);	     
	     return count == 0 ? "yes" : "no";
	    }
	 
	 @GetMapping("/mypage/phone_check_vue.do")
	    public String phoneCheck(HttpSession session,String phone, String userId) {
		 	String sessionUserId = (String) session.getAttribute("userId");
//		 	Map map = new HashMap();
//	     
//		 	map.put("phone",phone);
//	     	map.put("userId", userId);
	        int count = mService.phoneCheck(phone, userId);
	        return count == 0 ? "yes" : "no";
	    }
	
	 @GetMapping("/mypage/email_check_vue.do")
	    public String emailCheck(HttpSession session,String email, String userId) {
		 	String sessionUserId = (String) session.getAttribute("userId");
//		 	Map map = new HashMap();
//	     
//	     	map.put("email",email);
//	     	map.put("userId", userId);
	        int count = mService.emailCheck(email, userId);
	        return count == 0 ? "yes" : "no";
	    }
	 
	 @PostMapping("/mypage/verify_password.do")
	 public String verifyPassword(String userId, String currentPassword, HttpSession session)
	 {
		 System.out.println("===== 비밀번호 확인 디버깅 =====");
	        System.out.println("전달된 userId: " + userId);
	        System.out.println("전달된 비밀번호: " + currentPassword);
	        
	        try {
	            String dbPassword = mService.memberGetPwd(userId);
	            System.out.println("DB 저장 비밀번호: " + dbPassword);
	            
	            if (dbPassword == null) {
	                System.out.println("DB에서 비밀번호를 찾을 수 없습니다.");
	                return "no";
	            }
	            
	            // BCrypt matches 메서드로 비밀번호 비교
	            boolean matches = encoder.matches(currentPassword, dbPassword);
	            System.out.println("비밀번호 일치 여부: " + matches);
	            
	            return matches ? "yes" : "no";
	            
	        } catch (Exception e) {
	            System.out.println("에러 발생: " + e.getMessage());
	            e.printStackTrace();
	            return "no";
	        }
	    }	    
		
	 @PostMapping(value = "mypage/my_edit2_member_ok_vue.do", produces = "text/plain;charset=UTF-8")
		public String myInfo_ok(MemberVO vo) throws Exception
		{
			String result="";
			   try
			   {
				   System.out.println("Recv MemberVO: "+vo); // MemberVO Log
				   mService.updateMyInfo(vo);
				   result="yes";
				   
			   }catch(Exception ex)
			   {
				   ex.printStackTrace();
				   result=ex.getMessage();   
			   }
			   return result;
		
		}

	
	@GetMapping(value = "mypage/vueCouponList.do", produces = "text/plain;charset=UTF-8")
	public String mypageVueCouponList(HttpSession session) throws Exception{
		Map map=new HashMap();
		String id=(String)session.getAttribute("userId");
		List<PromotionCouponVO> activeCoupon=cService.promotionCouponListData(id);
		List<MyCouponVO> myCoupon=cService.mypageMyCouponList(id);
		for(MyCouponVO vo:myCoupon) {
			if(vo.getPvo().getType()==1) {
				vo.setSellname("전체");
			}
			else if(vo.getPvo().getType()==2) {
				vo.setSellname(types[vo.getPvo().getType()]);
			}
			else if(vo.getPvo().getType()==3) {
				vo.setSellname(vo.getPvo().getWvo().getNamekor());
			}
		}
		for(PromotionCouponVO vo:activeCoupon) {
			if(vo.getType()==1) {
				vo.setTargetname("전체");
			}
			else if(vo.getType()==2) {
				vo.setTargetname(types[vo.getType()]);
			}
			else if(vo.getType()==3) {
				vo.setTargetname(vo.getWvo().getNamekor());
			}
		}
		map.put("myCoupon", myCoupon);
		map.put("activeCoupon", activeCoupon);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@PostMapping(value = "mypage/vueGetCoupon.do", produces = "text/plain;charset=UTF-8")
	public void mypageVueGetCoupon(MyCouponVO vo, HttpSession session) {
		vo.setRecvid((String) session.getAttribute("userId"));
		cService.getCoupon(vo);
	}
	
	  // 작성 게시글 리스트 
	  @GetMapping(value="mypage/myboardlist_vue.do",produces ="text/plain;charset=UTF-8") 
	  public String mypage_boardList(HttpSession session,int page,int type) throws Exception 
	  { 
			int rowSize = 10;
			int start = (rowSize * page) - (rowSize - 1);
			int end = rowSize * page;

			String userid = (String)session.getAttribute("userId");
			Map map = new HashMap();
			
			map.put("userid", userid);
			map.put("start", start);
			map.put("end", end);

			List<BoardVO> boardList = mService.myBoardListData(map);
			List<ReplyBoardVO> replyList = mService.myReplyListData(map);
			List<BoardReplyVO> boardReplyList = mService.myboardReplyListData(map);
			
			
			int totalpage=0;
			
			switch (type) {
			case 1:
				totalpage=mService.myPageBoardTotalPage(map);
				map.put("list", boardList);
				break;
			case 2:
				totalpage=mService.myReplyTotalPage(map);
				map.put("list", replyList);
				break;
			case 3:
				totalpage=mService.myboardReplyTotalPage(map);
				map.put("list", boardReplyList);
				break;
			}

			map.put("totalpage", totalpage);
			map.put("curpage", page);
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map);
			return json;
	  }
	 
	  @GetMapping(value="mypage/vueLikeList.do",produces ="text/plain;charset=UTF-8")
	  public String mypageVueLikeList(int page, HttpSession session) throws Exception{
	  	Map map=new HashMap();
	  	String id=(String)session.getAttribute("userId");

	  	int rowSize = 10;
			int start = (rowSize * page) - (rowSize - 1);
			int end = rowSize * page;

			map.put("start", start);
			map.put("end", end);
			map.put("userid", id);

			List<LikeVO> list=sService.myLikeList(map);
			int totalPage=sService.myLikeTotalPage(map);
			
			map=new HashMap();
			
			map.put("list", list);
			map.put("totalPage", totalPage);
			map.put("curPage", page);
			
			ObjectMapper mapper=new ObjectMapper();
			return mapper.writeValueAsString(map);
	  }
	
	  @GetMapping(value="mypage/vueLikeDelete.do",produces ="text/plain;charset=UTF-8")
	  public void mypageVueLikeDelete(int lno) {
	  	sService.likeDelete(lno);
	  }
	  
	  @GetMapping(value="mypage/getinfo_vue.do",produces ="text/plain;charset=UTF-8")
	  public String exit_getinfo(String userid) throws Exception {
		 int pCount = mService.ingpaycount(userid);
		 int rCount = mService.myreservecount(userid);
		 String json="";
		 
		 Map map = new HashMap();
		 map.put("pCount", pCount);
		 map.put("rCount", rCount);
		 
		 ObjectMapper mapper=new ObjectMapper();
		 json=mapper.writeValueAsString(map);
		 
		 return json;
	  }
	  
	  @GetMapping(value="mypage/pwdCheck_vue.do",produces ="text/plain;charset=UTF-8")
	  public String exit_pwdCheck(String userid, String inputpwd) throws Exception {
		 
		 String result="";
		 String pwd = mService.pwdCheck(userid);
		 if (encoder.matches(inputpwd, pwd)) {
		        result = "yes"; 
		    } else {
		        result = "no"; 
		    }
		 
		 return result;
	  }
	  
	  @GetMapping(value="mypage/memberExit_vue.do",produces ="text/plain;charset=UTF-8")
	  public String memberExit(String userid, int rCount, HttpSession session) throws Exception {
		 
		 String result="";
		 mService.reservedelete(userid);
		 mService.bchangenick(userid);
		 mService.brchangenick(userid);
		 mService.reviewdelete(userid);
		 mService.likedelete(userid);
		 mService.Authorityupdate(userid);
		 mService.pwdcancel(userid);
		 
		 session.invalidate();
		 result="yes";
		 
		 return result;
	  }
	  
		@GetMapping(value = "mypage/updatePwd.do", produces = "text/plain;charset=UTF-8")
		public void updatePwd(HttpSession session,String userpwd) throws Exception {
			String id = (String) session.getAttribute("userId");
			userpwd=encoder.encode(userpwd);
			mService.updatePwd(id, userpwd);
		}
}
