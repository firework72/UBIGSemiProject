package com.ubig.app.member.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.member.dao.MessageDao;
import com.ubig.app.vo.member.MessageVO;


@Service
public class MessageServiceImpl implements MessageService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MessageDao dao;
	
	// 메시지 수신함 가져오기
	@Override
	public ArrayList<MessageVO> selectInbox(String userId) {
		return dao.selectInbox(sqlSession, userId);
	}
	
	// 읽지 않은 메시지 개수 가져오기
	@Override
	public int unreadCount(String userId) {
		return dao.unreadCount(sqlSession, userId);
	}
	
	// 메시지 전송 기능
	@Override
	public int insertMessage(MessageVO message) {
		return dao.insertMessage(sqlSession, message);
	}
	
	// 메시지 발신함 가져오기
	@Override
	public ArrayList<MessageVO> selectSent(String userId) {
		return dao.selectSent(sqlSession, userId);
	}
	
	// 수신자가 발신자를 차단했는지 유무 체크
	@Override
	public int isKicked(MessageVO message) {
		return dao.isKicked(sqlSession, message);
	}
	
	// 메시지 읽음 처리
	@Override
	public int readMessage(int messageNo) {
		return dao.readMessage(sqlSession, messageNo);
	}

}
