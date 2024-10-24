package com.sist.manager;

import java.util.*;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.*;

import com.sist.vo.ChatVO;

@ServerEndpoint(value = "/chat/chat-ws", configurator = WebSocketSessionConfigurator.class)
public class ChatServer {
	// 접속자 저장
	private static Map<Session, ChatVO> users=Collections.synchronizedMap(new HashMap<Session, ChatVO>());
	@OnOpen
	public void onOpen(Session session, EndpointConfig config) throws Exception{
		ChatVO vo=new ChatVO();
		HttpSession hs=(HttpSession)config.getUserProperties().get(HttpSession.class.getName());
		vo.setUserId((String)hs.getAttribute("admin")+"_"+(String)hs.getAttribute("userId"));
		vo.setUserName((String)hs.getAttribute("nickName"));
		vo.setSession(session);
		List<ChatVO> userList=new ArrayList<ChatVO>();
		users.put(session, vo);
		Iterator<Session> it=users.keySet().iterator();
		while(it.hasNext()) {
			Session ss=it.next();
			ChatVO cvo=users.get(ss.getId());
			System.out.println(cvo);
			if(ss.getId()!=session.getId()) {
				userList.add(cvo);
				ss.getBasicRemote().sendText("msg:[알림 =>]"+vo.getUserName());
			}
		}
		System.out.println(userList);
		System.out.println("클라이언트 접속 : " + vo.getUserId()+", "+vo.getUserName()+", "+vo.getSession());
	}
	
	@OnMessage
	public void onMessage(String message, Session session) throws Exception{
		System.out.println("수신된 메세지 : "+message+ ", 보낸사람 : "+session.getId());
		Iterator<Session> it=users.keySet().iterator();
		while(it.hasNext()) {
			Session ss=it.next();
			ChatVO vo=users.get(session);
			if(ss.getId()!=session.getId()) {
				ss.getBasicRemote().sendText("msg:["+vo.getUserName()+"]"+message);
			}
			else {
				ss.getBasicRemote().sendText("my:["+vo.getUserName()+"]"+message);
			}
		}
	}
	@OnClose
	public void onClose(Session session) throws Exception{
		Iterator<Session> it=users.keySet().iterator();
		while(it.hasNext()) {
			Session ss=it.next();
			ChatVO vo=users.get(session);
			if(ss.getId()!=session.getId()) {
				ss.getBasicRemote().sendText("msg:[퇴장 =>]"+vo.getUserName());
			}
		}
		System.out.println("클라이언트 퇴장 : "+users.get(session).getUserName());
		users.remove(session);
	}
}
