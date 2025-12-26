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
	public String searchKeyword(Model model,String searchKeyword) {
			
		ArrayList<DonationVO> list = service.searchKeyword(searchKeyword);
		
		model.addAttribute("list",list);
			
		return "funding/donationPage";
			
	}
	
	//저기 후원 해제 기능
	
	
	//후원 상세 페이지 이동
	@RequestMapping("/donationDetailView")
	public String donationPage(HttpSession session,Model model) {
		
		MemberVO m = (MemberVO)session.getAttribute("loginMember");
		
		int result = service.selectDetailView(m.getUserId());
        
		System.out.println(result);
		
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
	
	//정기 후원 해제
	@PostMapping("/donation/cancelDonation")
	@ResponseBody
	public String cancelRegularDonation(@RequestParam int donationNo) {
	    
		int result = service.cancelDonation(donationNo);
	   
	    return "redirect:/donation"; 
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
