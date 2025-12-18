package com.ubig.app.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.member.MemberVO;

@Repository
public class MemberDao {
	
	// 로그인 정보 가져오기
	public MemberVO loginMember(SqlSessionTemplate sqlSession, MemberVO inputMember) {
		return sqlSession.selectOne("memberMapper.loginMember", inputMember);
	}

}
