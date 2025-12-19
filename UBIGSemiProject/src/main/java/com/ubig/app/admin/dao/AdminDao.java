package com.ubig.app.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.community.BoardVO;
import com.ubig.app.vo.member.MemberVO;
import com.ubig.app.vo.volunteer.ActivityVO;

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
	
	public ArrayList<BoardVO> selectBoard(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectBoard");
	}

	public int insertBoard(SqlSessionTemplate sqlSession,BoardVO b) {
		
		return sqlSession.insert("adminMapper.insertBoard",b);
	}

	public int insertActivity(SqlSessionTemplate sqlSession,ActivityVO a) {
		
		return sqlSession.insert("adminMapper.insertActivity",a);
	}

	public ArrayList<ActivityVO> selectActivity(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectActivity");
	}

	

	

}
