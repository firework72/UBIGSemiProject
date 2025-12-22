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

}
