package com.ubig.app.funding.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.funding.service.FundingService;
import com.ubig.app.vo.funding.FundingHistoryVO;
import com.ubig.app.vo.funding.FundingVO;

@Controller
@RequestMapping("/funding")
public class FundingController {
	
	@Autowired
	private FundingService service;
	
	//펀딩 페이지 이동
	@RequestMapping("")
	public String fundingPage(Model model) {
		
		ArrayList<FundingVO> list = service.selectFunding();
		
		model.addAttribute("list",list);
		
		return "funding/fundingPage";
	}
	
	//펀딩 상세 페이지 이동
	@RequestMapping("/fundingDetailView")
	public String fundingDetailView(Model model,int fundingNo) {
		
		FundingVO list = service.selectFunding2(fundingNo);
		
		model.addAttribute("list",list);
		
		return "funding/fundingDetailView";
	}
	
	//펀딩 등록
	@RequestMapping("/insertFunding")
	public String insertFunding(HttpSession session,FundingVO fundingVO) {
		
		int result = service.insertFunding(fundingVO);
		
		if(result>0) {
			session.setAttribute("alertMsg", "펀딩 참여 성공");
		}else {
			session.setAttribute("alertMsg", "펀딩 참여 실패");
		}
		
		return "redirect:/funding";

	}
	
	//후원 기능
	@RequestMapping("/insertMoney")
	public String insertMoney(HttpSession session,FundingHistoryVO fundingHistoryVO) {
		
		System.out.println(fundingHistoryVO);
		
		int result = service.insertMoney(fundingHistoryVO);
		
		if(result>0) {
			session.setAttribute("alertMsg", "펀딩 참여 성공");
		}else {
			session.setAttribute("alertMsg", "펀딩 참여 실패");
		}
		
		return "redirect:/funding/fundingDetailView?fundingNo=" + fundingHistoryVO.getFundingNo();

		
	}
	
	
	
	
}
