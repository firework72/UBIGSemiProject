package com.ubig.app.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.member.dao.MemberDao;
import com.ubig.app.vo.member.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao dao;
	
	// 로그인 정보 가져오기
	@Override
	public MemberVO loginMember(MemberVO inputMember) {
		return dao.loginMember(sqlSession, inputMember);
	}
	
	// 회원가입 처리하기
	@Override
	public int insertMember(MemberVO m) {
		return dao.insertMember(sqlSession, m);
	}
	
	// 아이디 중복 체크
	@Override
	public int checkId(String userId) {
		return dao.checkId(sqlSession, userId);
	}
	
	
}
