package com.ubig.app.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.MemberVO;

@Repository
public class AdminDao {

	public ArrayList<MemberVO> selectUser(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectUser");
	}

	public int updateStatus(SqlSessionTemplate sqlSession, HashMap<String,String> map) {
		
		return sqlSession.update("adminMapper.updateStatus",map);
	}
	
	public int changeStatus(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.update("adminMapper.changeStatus",map);
	}

	public int deleteUser(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("adminMapper.deleteUser",userId);
	}

	public int insertBoard(SqlSessionTemplate sqlSession) {
		
		return sqlSession.insert("adminMapper.insertBoard");
	}

	public int insertActivity(SqlSessionTemplate sqlSession) {
		
		return sqlSession.insert("adminMapper.insertActivity");
	}

	

}
