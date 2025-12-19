package com.ubig.app.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

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
	public int updateStatus(HashMap<String,String> map) {
		
		return dao.updateStatus(sqlSession,map);
	}
	
	@Override
	public int changeStatus(HashMap<String, String> map) {
		
		return dao.changeStatus(sqlSession,map);
	}
	
	@Override
	public int deleteUser(String userId) {
		
		return dao.deleteUser(sqlSession,userId);
	}
	
	@Override
	public int insertBoard() {
		
		return dao.insertBoard(sqlSession);
	}
	
	@Override
	public int insertActivity() {
		
		return dao.insertActivity(sqlSession);
	}
	
	
	
}
