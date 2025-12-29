package com.ubig.app.funding.service;

import java.util.ArrayList;

import com.ubig.app.common.model.vo.PageInfo;
import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.funding.FundingHistoryVO;
import com.ubig.app.vo.funding.FundingVO;

public interface FundingService {

	ArrayList<FundingVO> selectFunding(PageInfo pi);
	
	int fundingListCount();
	
	int fundingListCount2(String searchKeyword);

	int insertFunding(FundingVO fundingVO);

	int insertMoney(FundingHistoryVO fundingHistoryVO);

	FundingVO fundingDetailView(int fundingNo);

	ArrayList<FundingVO> searchKeyword(String searchKeyword,PageInfo pi);
	

}
