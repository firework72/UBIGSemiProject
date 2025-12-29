package com.ubig.app.funding.service;

import java.util.ArrayList;

import com.ubig.app.common.model.vo.PageInfo;
import com.ubig.app.vo.funding.DonationVO;

public interface DonationService {

	ArrayList<DonationVO> selectDonation(PageInfo pi);
	
	int donationListCount();
	
	int donationListCount2(String searchKeyword);
	
	ArrayList<DonationVO> searchKeyword(String searchKeyword, PageInfo pi);
	
	int donation(DonationVO donationVO);

	int donation2(DonationVO donationVO);

	int selectDetailView(String userId);

	int cancelDonation(String userId);
	
	
}
