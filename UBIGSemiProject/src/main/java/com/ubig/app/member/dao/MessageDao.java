package com.ubig.app.member.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.MessageVO;

@Repository
public class MessageDao {
	
	// 메시지 수신함 가져오기
	public ArrayList<MessageVO> selectInbox(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("messageMapper.selectInbox", userId);
	}
	
	// 읽지 않은 메시지 개수 가져오기
	public int unreadCount(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("messageMapper.unreadCount", userId);
	}
	
	// 메시지 전송하기
	public int insertMessage(SqlSessionTemplate sqlSession, MessageVO message) {
		return sqlSession.insert("messageMapper.insertMessage", message);
	}
	
	// 메시지 발신함 가져오기
	public ArrayList<MessageVO> selectSent(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("messageMapper.selectSent", userId);
	}

	public int isKicked(SqlSessionTemplate sqlSession, MessageVO message) {
		return sqlSession.selectOne("messageMapper.isKicked", message);
	}
	
	

}
