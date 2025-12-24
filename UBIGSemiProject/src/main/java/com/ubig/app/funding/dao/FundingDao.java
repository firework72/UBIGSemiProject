package com.ubig.app.funding.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.funding.FundingHistoryVO;
import com.ubig.app.vo.funding.FundingVO;

@Repository
public class FundingDao {

	public ArrayList<FundingVO> selectFunding(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("fundingMapper.selectFunding");
	}
	
	public int insertFunding(SqlSessionTemplate sqlSession, FundingVO fundingVO) {
		
		return sqlSession.insert("fundingMapper.insertFunding",fundingVO);
	}

	public int insertMoney(SqlSessionTemplate sqlSession, FundingHistoryVO fundingHistoryVO) {
		
		return sqlSession.insert("fundingMapper.insertMoney",fundingHistoryVO);
	}

	public FundingVO selectFunding2(SqlSessionTemplate sqlSession,int fundingNo) {
		
		return sqlSession.selectOne("fundingMapper.selectFunding2",fundingNo);
	}

	public ArrayList<FundingVO> searchKeyword(SqlSessionTemplate sqlSession, String searchKeyword) {
		
		return (ArrayList)sqlSession.selectList("fundingMapper.searchKeyword",searchKeyword);
	}

	
}
