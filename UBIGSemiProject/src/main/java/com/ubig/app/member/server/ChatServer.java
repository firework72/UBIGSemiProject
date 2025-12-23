package com.ubig.app.member.server;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatServer extends TextWebSocketHandler{
	
	/*
	 * 어드민이 접속하면 누구와 채팅중인지를 알아야한다.
	 * 일반 회원이 채팅을 보내면 접속중인 모든 어드민에게 실시간으로 메시지를 보내야 하고,
	 * 어드민이 채팅을 보내면 현재 자신이 채팅 중인 일반 회원에게만 실시간으로 메시지를 보내야 한다.
	 * 
	 * 또한 채팅 이벤트가 발생할 때마다 이 채팅 내용을 데이터베이스에 넣어야 한다.
	 * 
	 */
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}
}
