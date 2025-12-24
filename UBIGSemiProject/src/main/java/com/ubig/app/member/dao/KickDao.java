package com.ubig.app.member.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.KickVO;

@Repository
public class KickDao {

	public int isKicked(SqlSessionTemplate sqlSession, KickVO kick) {
		return sqlSession.selectOne("kickMapper.isKicked", kick);
	}

	public int insertKick(SqlSessionTemplate sqlSession, KickVO kick) {
		return sqlSession.insert("kickMapper.insertKick", kick);
	}

	public ArrayList<KickVO> selectKick(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("kickMapper.selectKick", userId);
	}

	public int deleteKick(SqlSessionTemplate sqlSession, int kickNo) {
		return sqlSession.delete("kickMapper.deleteKick", kickNo);
	}

}
