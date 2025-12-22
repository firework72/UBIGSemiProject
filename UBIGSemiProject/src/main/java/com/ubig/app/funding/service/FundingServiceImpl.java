package com.ubig.app.funding.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.funding.dao.FundingDao;

@Service
public class FundingServiceImpl implements FundingService{
	
	@Autowired
	private FundingDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int donation(String userId) {
		
		return dao.donation(sqlSession,userId);
	}
	
	
}
