package com.sist.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.vo.ChartVO;
import com.sist.vo.ChatVO;

@RestController
public class ChatRestController {
	@GetMapping(value = "chat/vueChatList.do", produces = "text/plain;charset=UTF-8")
	public String chatVueList(HttpSession session) throws Exception {
		List<ChatVO> list = (List<ChatVO>) session.getAttribute("chatList");
		String nickName = (String) session.getAttribute("nickName");
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (nickName.equals(list.get(i).getUserName())) {
					list.remove(i);
				}
			}
		}
		System.out.println(list);
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(list);
	}
}
