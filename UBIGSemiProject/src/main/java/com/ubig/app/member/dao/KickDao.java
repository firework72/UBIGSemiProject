package com.ubig.app.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.KickVO;

@Repository
public class KickDao {

	public int isKicked(SqlSessionTemplate sqlSession, KickVO kick) {
		return sqlSession.selectOne("kickMapper.isKicked", kick);
	}

}
