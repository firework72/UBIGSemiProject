package com.ubig.app.funding.service;

import java.util.ArrayList;

import com.ubig.app.vo.funding.DonationVO;

public interface DonationService {

	ArrayList<DonationVO> selectDonation();
	
	int donation(DonationVO donationVO);

	int donation2(DonationVO donationVO);

	int updateType(DonationVO donationVO);
	
	
}
