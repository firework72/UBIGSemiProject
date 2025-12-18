package com.ubig.app.admin.controller;

import java.util.ArrayList;

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
		
		return "admin/admin";
	}
	
	//정지된 회원들 목록
	@RequestMapping("/userStatus")
	public String selectUser(Model model) {
		
		ArrayList<MemberVO> list = service.selectUser();
		
		model.addAttribute(list);
		
		return "admin/userStatus";
	}
	
	//회원 정지
	@RequestMapping("/stop")
	public String updateStatus(HttpSession session,String userId) {
		
		int result = service.updateStatus(userId);
			
		if(result>0) {
			session.setAttribute("alertMsg", "회원 정지 성공");
		}else {
			session.setAttribute("alertMsg", "회원 정지 실패");
		}
		
		return "";
	}
	
	//회원 추방
	@RequestMapping("/delete")
	public String deleteUser(HttpSession session,String userId) {
		
		int result = service.deleteUser(userId);
		
		if(result>0) {
			session.setAttribute("alertMsg", "회원 추방 성공");
		}else {
			session.setAttribute("alertMsg", "회원 추방 성공");
		}
		
		return "";
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
	
	
}
