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
	
	// 회원가입 처리하기
	public int insertMember(SqlSessionTemplate sqlSession, MemberVO m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	// 아이디 중복 체크하기
	public int checkId(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.checkId", userId);
	}

}
