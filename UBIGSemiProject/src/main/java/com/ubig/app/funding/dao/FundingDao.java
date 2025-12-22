package com.ubig.app.funding.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FundingDao {

	public int donation(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("fundingMapper.donation");
	}
	
	
	
}
