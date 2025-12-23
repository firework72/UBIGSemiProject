package com.ubig.app.member.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.member.dao.AdminChatDao;
import com.ubig.app.vo.member.AdminChatHistoryVO;
import com.ubig.app.vo.member.MemberVO;

@Service
public class AdminChatServiceImpl implements AdminChatService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AdminChatDao dao;
	
	// 회원 ID 오름차순으로 가져오기
	@Override
	public ArrayList<MemberVO> chatList() {
		return dao.chatList(sqlSession);
	}
	
	// 채팅 이력 저장하기
	@Override
	public int insertChat(AdminChatHistoryVO chat) {
		return dao.insertChat(sqlSession, chat);
	}
	
}
