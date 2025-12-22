package com.ubig.app.funding.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.funding.dao.FundingDao;
import com.ubig.app.vo.funding.DonationVO;

@Service
public class FundingServiceImpl implements FundingService{
	
	@Autowired
	private FundingDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<DonationVO> selectDonation() {
		
		return dao.selectDonation(sqlSession);
	}
	
	@Override
	public int updateType(DonationVO donationVO) {
		
		return dao.updateType(sqlSession,donationVO);
	}
	
	@Override
	public int donation(DonationVO donationVO) {
		
		return dao.donation(sqlSession,donationVO);
	}
	
	@Override
	public int donation2(DonationVO donationVO) {
		
		return dao.donation2(sqlSession,donationVO);
	}
	
	
	
}
