package com.ubig.app.admin.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.admin.dao.AdminDao;
import com.ubig.app.vo.member.MemberVO;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<MemberVO> selectUser() {
		
		return dao.selectUser(sqlSession);
	}
	
	@Override
	public int updateStatus(String userId) {
		
		return dao.updateStatus(sqlSession,userId);
	}
	
	@Override
	public int deleteUser(String userId) {
		
		return dao.deleteUser(sqlSession,userId);
	}
	
	@Override
	public int insertBoard() {
		
		return dao.insertBoard(sqlSession);
	}
	
}
