package com.ubig.app.funding.service;

import java.util.ArrayList;

import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.funding.FundingVO;

public interface DonationService {

	ArrayList<DonationVO> selectDonation();
	
	int donation(DonationVO donationVO);

	int donation2(DonationVO donationVO);

	ArrayList<DonationVO> searchKeyword(String searchKeyword);

	int selectDetailView(String userId);

	int cancelDonation(int donationNo);
	
	
}
