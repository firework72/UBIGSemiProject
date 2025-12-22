package com.ubig.app.funding.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.funding.DonationVO;

@Repository
public class FundingDao {
	
	public ArrayList<DonationVO> selectDonation(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("fundingMapper.selectDonation");
	}
	
	public int updateType(SqlSessionTemplate sqlSession, DonationVO donationVO) {
		
		return sqlSession.update("fundingMapper.updateType",donationVO);
	}
	
	public int donation(SqlSessionTemplate sqlSession, DonationVO donationVO) {
		
		return sqlSession.insert("fundingMapper.donation",donationVO);
	}

	public int donation2(SqlSessionTemplate sqlSession, DonationVO donationVO) {
		
		return sqlSession.insert("fundingMapper.donation2",donationVO);
	}

	

	
	
	
	
}
