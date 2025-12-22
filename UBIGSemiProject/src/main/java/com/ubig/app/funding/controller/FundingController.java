package com.ubig.app.funding.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.funding.common.Scheduler;
import com.ubig.app.funding.service.FundingService;
import com.ubig.app.vo.funding.DonationVO;

@Controller
@RequestMapping("/funding")
public class FundingController {
	
	@Autowired
	private FundingService service;
	
	//후원,펀딩 페이지 이동
	@RequestMapping("")
	public String fundingPage(Model model) {
		
		ArrayList<DonationVO> list = service.selectDonation();
		
		model.addAttribute(list);
		
		return "funding/fundingPage2";
	}
	
	//정기 후원 신청 
	@RequestMapping("updateType")
	public String updateType(HttpSession session,DonationVO donationVO) {
		
		int result = service.updateType(donationVO);
		
		if(result>0) {
			session.setAttribute("alertMsg", "타입 변경 완료");
		}else {
			session.setAttribute("alertMsg", "타입 변경 실패");
		}
				
		return "funding/fundingPage2";
		
	}
	
	
	  //정기 후원
	  
	  @RequestMapping("/donation") public String donation(HttpSession
	  session,DonationVO donationVO) {
	  
	  int result = service.donation(donationVO);
	  
	  if(result>0) { session.setAttribute("alertMsg", "정기 후원 완료"); }else {
	  session.setAttribute("alertMsg", "정기 후원 실패"); }
	  
	  return "funding/fundingPage2"; }
	 
	
	//일시 후원
	@RequestMapping("/donation2")
	public String donation2(HttpSession session,DonationVO donationVO) {
		
		int result = service.donation2(donationVO);
		
		if(result>0) {
			session.setAttribute("alertMsg", "일시 후원 완료");
		}else {
			session.setAttribute("alertMsg", "일시 후원 실패");
		}
		
		return "funding/fundingPage2";
	}
	
	
	
}
