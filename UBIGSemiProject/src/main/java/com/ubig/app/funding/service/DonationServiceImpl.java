package com.ubig.app.funding.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.funding.dao.DonationDao;
import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.funding.FundingVO;

@Service
public class DonationServiceImpl implements DonationService{
	
	@Autowired
	private DonationDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<DonationVO> selectDonation() {
		
		return dao.selectDonation(sqlSession);
	}
	
	@Override
	public ArrayList<DonationVO> searchKeyword(String searchKeyword) {
		
		return dao.searchKeyword(sqlSession,searchKeyword);
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
