package com.ubig.app.funding.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ubig.app.common.model.vo.PageInfo;
import com.ubig.app.common.util.Pagination;
import com.ubig.app.funding.common.FundingException;
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
	
	//검색 기능
	@RequestMapping("/searchKeyword")
	public String searchKeyword(Model model,String searchKeyword) {
		
		ArrayList<FundingVO> list = service.searchKeyword(searchKeyword);
		
		model.addAttribute("list",list);
		
		return "funding/fundingPage";
		
	}
	
	//펀딩 상세 페이지 이동
	@RequestMapping("/fundingDetailView")
	public String fundingDetailView(Model model,int fundingNo) {
		
		FundingVO list = service.fundingDetailView(fundingNo);
		
		model.addAttribute("list",list);
		
		return "funding/fundingDetailView";
	}
	
	//펀딩 등록 페이지 이동
	@RequestMapping("/insertPage")
	public String insertPage() {
		
		return "funding/insertPage";
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
	
	//펀딩 입금 기능
	@RequestMapping("/insertMoney")
    public String insertMoney(HttpSession session, FundingHistoryVO FundingHistoryVO) {
        
		try {
            service.insertMoney(FundingHistoryVO);
            session.setAttribute("alertMsg", "펀딩 참여 성공");
        } catch (FundingException e) {
            session.setAttribute("alertMsg", e.getMessage());
        }

        return "redirect:/funding/fundingDetailView?fundingNo=" + FundingHistoryVO.getFundingNo();
    }
	
	
	
	
}
