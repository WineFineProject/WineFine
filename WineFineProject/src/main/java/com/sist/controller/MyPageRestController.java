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
	
	// 회원정보 수정
	@GetMapping(value = "my_edit2_member_vue.do", produces = "text/plain;charset=UTF-8")
	public String myInfo(@SessionAttribute("userId") String userId) throws Exception
	{	
		
		MemberVO vo=mService.getMyId(userId);
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
	@PostMapping(value = "mypage/edit2_ok_vue_do", produces = "application/json")
	public String myInfo_ok(HttpSession session,@RequestBody MemberVO updatedInfo) throws Exception
	{
		String id = (String)session.getAttribute("userId");
		
		session.setAttribute("userId", id);
	
		MemberVO currentInfo = mService.getMyId(id);
	    
	    // 업데이트할 정보 설정
	    currentInfo.setNickName(updatedInfo.getNickName());
	    currentInfo.setPost(updatedInfo.getPost());
	    currentInfo.setAddr1(updatedInfo.getAddr1());
	    currentInfo.setAddr2(updatedInfo.getAddr2());
	    currentInfo.setPhone(updatedInfo.getPhone());
	    currentInfo.setEmail(updatedInfo.getEmail());
	    
	    mService.updateMyInfo(currentInfo);
	    
	    // 업데이트된 정보 다시 조회
	    MemberVO updatedMember = mService.getMyId(id);
	    
	    // 세션 업데이트
	    session.setAttribute("nickName", updatedMember.getNickName());
	    session.setAttribute("post", updatedMember.getPost());
	    session.setAttribute("addr1", updatedMember.getAddr1());
	    session.setAttribute("addr2", updatedMember.getAddr2());
	    session.setAttribute("phone", updatedMember.getPhone());
	    session.setAttribute("email", updatedMember.getEmail());
	    	    
	    ObjectMapper mapper = new ObjectMapper(); 
	    Map map = new HashMap();
	    map.put("updatedInfo", updatedMember);
	    return mapper.writeValueAsString(map); 
	    
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
	
	
	
	// 작성 게시글 리스트 mypage/myboardlist.do
	
	  @GetMapping(value="mypage/myboardlist_vue.do",produces ="text/plain;charset=UTF-8") 
	  public String mypage_boardList(HttpSession session) throws Exception 
	  { 
		  String nickname=(String)session.getAttribute("nickName");
		  
//		  int rowSize = 10;
//		  int start = (rowSize*page)-(rowSize-1);
//		  int end = rowSize*page;
		  
		  Map map = new HashMap();
//		  map.put("start", start);
//		  map.put("end", end);
		  
		  List<BoardVO> list=mService.myBoardListData(nickname);
		  
//		  int totalpage = mService.myPageBoardTotalPage(map);
		  
//		  final int BLOCK = 10;
//		  int startpage=((page-1)/BLOCK*BLOCK)+1;
//		  int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
//		  int count = mService.myPageBoardTotalPage(map);
//		  count = count-((page*rowSize)-rowSize);
		  //int totalpage=(int)(Math.ceil(count/(double)rowSize));		  
		  //map=new HashMap();		  
		  map.put("list", list);
		  map.put("nickname", nickname);
//		  map.put("count", count);
//		  map.put("curpage", page);
//		  map.put("startpage", startpage);
//		  map.put("endpage", endpage);
//		  map.put("totalpage", totalpage);		  
		  
		  ObjectMapper mapper=new ObjectMapper(); 
		  String json=mapper.writeValueAsString(map);
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

}
