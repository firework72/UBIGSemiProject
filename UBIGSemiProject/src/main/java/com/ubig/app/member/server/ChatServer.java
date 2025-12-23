package com.ubig.app.member.server;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ubig.app.member.service.ChatService;
import com.ubig.app.vo.member.AdminChatHistoryVO;
import com.ubig.app.vo.member.MemberVO;

public class ChatServer extends TextWebSocketHandler{
	
	/*
	 * 어드민이 접속하면 누구와 채팅중인지를 알아야한다.
	 * 일반 회원이 채팅을 보내면 접속중인 모든 어드민에게 실시간으로 메시지를 보내야 하고,
	 * 어드민이 채팅을 보내면 현재 자신이 채팅 중인 일반 회원에게만 실시간으로 메시지를 보내야 한다.
	 * 
	 * 또한 채팅 이벤트가 발생할 때마다 이 채팅 내용을 데이터베이스에 넣어야 한다.
	 * 
	 */
	
	private ChatService service;
	
	// 각각의 어드민이 누구와 채팅중인지를 저장해두는 Map
	// 각 어드민은 한 명의 일번 회원과만 채팅할 수 있다.
	// Key값은 admin_id이고, Value값은 user_id이다.
	// 현재 로그인된 정보가 admin인 경우에만 여기에 데이터를 넣는다.
	private Map<String, String> adminTargetUser = Collections.synchronizedMap(new HashMap<>());
	
	// 현재 접속중인 어드민의 세션 및 ID정보
	private Map<String, WebSocketSession> admins = Collections.synchronizedMap(new HashMap<>());
	// 현재 접속중인 일반 회원의 세션 및 ID정보
	private Map<String, WebSocketSession> users = Collections.synchronizedMap(new HashMap<>());
	
	// 웹소켓에 접속이 되었을 경우
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// session에 담겨 있는 loginMember가 어드민이라면 adminTargetUser와 admins에 데이터를 삽입한다.
		// session에 담겨 있는 loginMember가 일반 회원이라면 users에 데이터를 삽입한다.
		
		MemberVO loginMember = (MemberVO) session.getAttributes().get("loginMember");
		
		System.out.println(loginMember);
		
		if ("MEMBER".equals(loginMember.getUserRole())) {
			users.put(loginMember.getUserId(), session);
		}
		else {
			admins.put(loginMember.getUserId(), session);
			adminTargetUser.put(loginMember.getUserId(), (String) session.getAttributes().get("adminTargetUser"));
		}
	}
	
	// 웹소켓에서 메시지 전송이 요청된 경우
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// message에 들어간 정보를 JSON으로 파싱한다.
		JSONObject msgJson = (JSONObject) new JSONParser().parse(message.getPayload());
		
		// AdminChatHistoryVO에 채팅 객체를 만든다.
		AdminChatHistoryVO chat = AdminChatHistoryVO.builder()
													.chatContent((String)msgJson.get("message"))
													.build();
		// 만들어진 객체를 데이터베이스에 저장한다.
		
		int result = service.insertChat(chat);
		
		// 만약 데이터베이스 저장에 성공했다면 해당 내용을 웹소켓을 통해 전송한다.
		// 어드민과 유저 모두에게 전송되어야 하며, 발신자와 수신자의 유형에 따라 말풍선이 뜨는 위치를 다르게 해야한다.
		
	}
	
	// 웹소켓에 접속을 해제한 경우
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// session에 담겨 있는 loginMember가 어드민이라면 adminTargetUser와 admins에 데이터를 제거한다.
		// session에 담겨 있는 loginMember가 일반 회원이라면 users에 데이터를 제거한다.
		
		MemberVO loginMember = (MemberVO) session.getAttributes().get("loginMember");
		
		System.out.println(loginMember);
		
		if ("MEMBER".equals(loginMember.getUserRole())) {
			users.remove(loginMember.getUserId(), session);
		}
		else {
			admins.remove(loginMember.getUserId(), session);
			adminTargetUser.remove(loginMember.getUserId(), (String) session.getAttributes().get("adminTargetUser"));
		}
	}
}
