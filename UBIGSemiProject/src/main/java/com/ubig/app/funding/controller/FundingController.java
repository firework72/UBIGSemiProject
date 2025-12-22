package com.ubig.app.funding.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.funding.service.FundingService;

@Controller
@RequestMapping("/funding")
public class FundingController {
	
	@Autowired
	private FundingService service;
	
	//후원,펀딩 페이지 이동
	@RequestMapping("")
	public String fundingPage() {
			
		return "funding/fundingPage";
	}
		
	//일시 후원
	@RequestMapping("/test")
	public String donation(HttpSession session,String userId) {
		
		int result = service.donation(userId);
		
		if(result>0) {
			session.setAttribute("alertMsg", "일시 후원 완료");
		}else {
			session.setAttribute("alertMsg", "일시 후원 실패");
		}
		
		return "redirect:fundingPage";
	}
	
}
