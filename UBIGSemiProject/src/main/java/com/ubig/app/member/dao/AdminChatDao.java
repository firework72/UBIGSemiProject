package com.ubig.app.member.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.AdminChatHistoryVO;
import com.ubig.app.vo.member.MemberVO;

@Repository
public class AdminChatDao {

	public ArrayList<MemberVO> chatList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("chatMapper.chatList");
	}

	public int insertChat(SqlSessionTemplate sqlSession, AdminChatHistoryVO chat) {
		return sqlSession.insert("chatMapper.insertChat", chat);
	}
	
}
