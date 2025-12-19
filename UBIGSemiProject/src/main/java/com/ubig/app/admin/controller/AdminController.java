package com.ubig.app.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.admin.service.AdminService;
import com.ubig.app.vo.member.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	//관리자 페이지 이동
	@RequestMapping("")
	public String adminPage() {
		
		return "admin/adminPage2";
	}
	
	//회원 관리 페이지
	@RequestMapping("userStatus")
	public String selectUser(Model model) {
		
		ArrayList<MemberVO> list = service.selectUser();
		
		model.addAttribute("list",list);
		
		return "admin/userStatusView";
	}
	
	//회원 정지
	@RequestMapping("/stopUser")
	public String updateStatus(HttpSession session,String userId,String days) {
		
		HashMap<String,String> map = new HashMap<>();
		map.put("days", days);
		map.put("userId", userId);
		
		int result = service.updateStatus(map);
		
		if(result>0) {
			session.setAttribute("alertMsg", "회원 정지 성공");
		}else {
			session.setAttribute("alertMsg", "회원 정지 실패");
		}
		
		return "redirect:userStatus";
	}
	
	//회원 정지 해제
	@RequestMapping("/openUser")
	public String changeStatus(HttpSession session,String userId,String days) {
	
		HashMap<String,String> map = new HashMap<>();
		map.put("days", days);
		map.put("userId", userId);
		
		int result = service.changeStatus(map);
		
		if(result>0) {
			session.setAttribute("alertMsg", "회원 정지 해제 성공");
		}else {
			session.setAttribute("alertMsg", "회원 정지 해제 실패");
		}
		
		return "redirect:userStatus";
	}
	
	//회원 추방
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpSession session,String userId) {
		
		int result = service.deleteUser(userId);
		
		if(result>0) {
			session.setAttribute("alertMsg", "회원 추방 성공");
		}else {
			session.setAttribute("alertMsg", "회원 추방 성공");
		}
		
		return "redirect:userStatus";
	}
	
	//공지글 등록
	@RequestMapping("/insert")
	public String insertBoard(HttpSession session) {
		
		int result = service.insertBoard();
		
		if(result>0) {
			session.setAttribute("alertMsg", "공지글 등록 성공");
		}else {
			session.setAttribute("alertMsg", "공지글 등록 성공");
		}
		
		return "";
	}
	
	//봉사활동 등록
	@RequestMapping("insertBoard")
	public String insertActivity(HttpSession session) {
		
		int result = service.insertActivity();
			
		if(result>0) {
			session.setAttribute("alertMsg", "봉사활동 등록 성공");
		}else {
			session.setAttribute("alertMsg", "봉사활동 등록 실패");
		}
		
		return "";
	}
	
	
}
