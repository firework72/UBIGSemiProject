package com.ubig.app.funding.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ubig.app.funding.service.DonationService;
import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.member.MemberVO;

@Controller
@RequestMapping("/donation")
public class DonationController {
	
	@Autowired
	private DonationService service;
	
	//후원 페이지 이동
	@RequestMapping("")
	public String donationViewPage(Model model) {
		
		ArrayList<DonationVO> list = service.selectDonation();
		
		model.addAttribute("list",list);
		
		return "funding/donationPage";
	}
	
	//검색 기능
	@RequestMapping("/searchKeyword")
	public String searchKeyword(Model model,String searchKeyword,String searchType) {
			
		ArrayList<DonationVO> list = service.searchKeyword(searchKeyword);
		
		// 후원 타입 검색
	    if ("정기".equals(searchKeyword)) {
	        list = service.searchKeyword("1");
	    } 
	    else if ("일시".equals(searchKeyword)) {
	        list = service.searchKeyword("2");
	    } 
	    // 그 외 검색
	    else {
	        list = service.searchKeyword(searchKeyword);
	    }
		
		model.addAttribute("list",list);
			
		return "funding/donationPage";
			
	}
	
	//후원 상세 페이지 이동
	@RequestMapping("/donationDetailView")
	public String donationPage(HttpSession session,Model model) {
		
		MemberVO m = (MemberVO)session.getAttribute("loginMember");
		
		int result = service.selectDetailView(m.getUserId());
        
		model.addAttribute("result", result);
		
		return "funding/donationDetailView";
	}
	
	//정기 후원
	@RequestMapping("/donation") 
	public String donation(HttpSession session,DonationVO donationVO) {
	  
		int result = service.donation(donationVO);
		  
		if(result>0) { 
			session.setAttribute("alertMsg", "정기 후원 완료"); 
		}else {
			session.setAttribute("alertMsg", "정기 후원 실패"); }
		  
		 return "redirect:/donation"; 
	}
	
	// 정기 후원 해제
    @PostMapping("/cancelDonation")
    @ResponseBody
    public String cancelDonation(HttpSession session) {
        
    	MemberVO m = (MemberVO)session.getAttribute("loginMember");
    	
    	int result = service.cancelDonation(m.getUserId());
    	
    	if(result>0) {
    		return "success";
    	}else {
    		return "fail";
    	}
    	
    }
	
	//일시 후원
	@RequestMapping("/donation2")
	public String donation2(HttpSession session,DonationVO donationVO) {
		
		int result = service.donation2(donationVO);
		
		if(result>0) {
			session.setAttribute("alertMsg", "일시 후원 완료");
		}else {
			session.setAttribute("alertMsg", "일시 후원 실패");
		}
		
		return "redirect:/donation";
	}
	
	
	
}
