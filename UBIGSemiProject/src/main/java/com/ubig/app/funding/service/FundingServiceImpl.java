package com.ubig.app.funding.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.funding.dao.FundingDao;
import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.funding.FundingHistoryVO;
import com.ubig.app.vo.funding.FundingVO;

@Service
public class FundingServiceImpl implements FundingService{
	
	@Autowired
	private FundingDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<FundingVO> selectFunding() {
		
		return dao.selectFunding(sqlSession);
	}
	
	@Override
	public int insertFunding(FundingVO fundingVO) {
	
		return dao.insertFunding(sqlSession,fundingVO);
	}
	
	@Override
	public int insertMoney(FundingHistoryVO fundingHistoryVO) {
		
		return dao.insertMoney(sqlSession,fundingHistoryVO);
	}
	
	@Override
	public FundingVO selectFunding2(int fundingNo) {
		
		return dao.selectFunding2(sqlSession,fundingNo);
	}
	
}
