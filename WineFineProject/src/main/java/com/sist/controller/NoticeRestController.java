package com.sist.controller;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.json.JsonMapper;
import com.sist.service.CartService;
import com.sist.service.NoticeService;
import com.sist.vo.NoticeVO;
import com.sist.vo.WineReturnVO;

@RestController
public class NoticeRestController {
	@Autowired
	private NoticeService nService;
	@Autowired
	private CartService cService;
	@PostMapping(value = "notice/vueAdminNoticeSend.do", produces = "text/plain;charset=UTF-8")
	public void noticeVueAdminNoticeSend(NoticeVO vo) {
		vo.setSendid("admin");
		System.out.println(vo);
		String deSub=URLDecoder.decode(vo.getSubject(), StandardCharsets.UTF_8);
		String deCont=URLDecoder.decode(vo.getContent(), StandardCharsets.UTF_8);
		vo.setSubject(deSub);
		vo.setContent(deCont);
		nService.noticeInsert(vo);
	}
	
	@PostMapping(value = "notice/vueSellerNoticeSend.do", produces = "text/plain;charset=UTF-8")
	public void noticeVueSellerNoticeSend(NoticeVO vo,HttpSession session) {
		vo.setSendid((String)session.getAttribute("userId"));
		String deSub=URLDecoder.decode(vo.getSubject(), StandardCharsets.UTF_8);
		String deCont=URLDecoder.decode(vo.getContent(), StandardCharsets.UTF_8);
		vo.setSubject(deSub);
		vo.setContent(deCont);
		nService.noticeInsert(vo);
	}
	
	@GetMapping(value = "notice/vueNotice.do", produces = "text/plain;charset=UTF-8")
	public String noticeVueNoticeNewCount(HttpSession session) throws Exception{
		Map map=new HashMap();
		String id=(String)session.getAttribute("userId");
		if(id==null)
			id="";
		int count=nService.noticeNewCount(id);
		List<NoticeVO> newNotice=nService.noticeNewListData(id);
		List<NoticeVO> oldNotice=nService.noticeOldListData(id);
		int cartCount=cService.myCartCount(id);
		map.put("count", count);
		map.put("newNotice", newNotice);
		map.put("oldNotice", oldNotice);
		map.put("cartCount", cartCount);
		JsonMapper mapper=new JsonMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@GetMapping(value = "notice/vueNoticeStateUpdate.do", produces = "text/plain;charset=UTF-8")
	public void noticeVueStateUpdate(int nno) {
		nService.noticeStateUpdate(nno);
	}
	@PostMapping(value = "notice/vueRequestSend.do", produces = "text/plain;charset=UTF-8")
	public void noticeVueRequest(WineReturnVO vo, HttpSession session) {
		String id=(String)session.getAttribute("userId");
		String deSub=URLDecoder.decode(vo.getSubject(), StandardCharsets.UTF_8);
		String deCont=URLDecoder.decode(vo.getContent(), StandardCharsets.UTF_8);
		vo.setSubject(deSub);
		vo.setContent(deCont);
		vo.setSendid(id);
		nService.returnRequestInsert(vo);
	}
}
