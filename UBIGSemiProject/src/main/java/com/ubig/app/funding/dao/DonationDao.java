package com.ubig.app.funding.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.funding.FundingVO;

@Repository
public class DonationDao {
	
	public ArrayList<DonationVO> selectDonation(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("donationMapper.selectDonation");
	}
	
	public ArrayList<DonationVO> searchKeyword(SqlSessionTemplate sqlSession, String searchKeyword) {
		
		return (ArrayList)sqlSession.selectList("donationMapper.searchKeyword",searchKeyword);
	}
	
	public int donation(SqlSessionTemplate sqlSession, DonationVO donationVO) {
		
		return sqlSession.insert("donationMapper.donation",donationVO);
	}

	public int donation2(SqlSessionTemplate sqlSession, DonationVO donationVO) {
		
		return sqlSession.insert("donationMapper.donation2",donationVO);
	}

	public ArrayList<DonationVO> selectDetailView(SqlSessionTemplate sqlSession,String userId) {
	
		return (ArrayList)sqlSession.selectOne("donationMapper.selectDetailView",userId);
	}
	
	
}
