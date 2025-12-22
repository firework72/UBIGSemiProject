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

}
