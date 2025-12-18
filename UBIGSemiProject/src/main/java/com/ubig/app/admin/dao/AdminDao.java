package com.ubig.app.admin.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.MemberVO;

@Repository
public class AdminDao {

	public ArrayList<MemberVO> selectUser(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectUser");
	}

	public int updateStatus(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("adminMapper.updateStatus",userId);
	}

	public int deleteUser(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("adminMapper.deleteUser",userId);
	}

	public int insertBoard(SqlSessionTemplate sqlSession) {
		
		return sqlSession.insert("adminMapper.insertBoard");
	}

}
