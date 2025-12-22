package com.ubig.app.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.admin.service.AdminService;
import com.ubig.app.vo.community.BoardVO;
import com.ubig.app.vo.member.MemberVO;
import com.ubig.app.vo.volunteer.ActivityVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	//관리자 페이지 이동
	@RequestMapping("")
	public String adminPage() {
		
		return "admin/adminPage";
	}
	
	//회원 관리 페이지
	@RequestMapping("/userStatus")
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
		
		return "redirect:userSta	tus";
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
	
	//공지글 관리 페이지 이동
	@RequestMapping("/boardPage")
	public String boardPage(Model model) {
		
		ArrayList<BoardVO> list = service.selectBoard();
		
		model.addAttribute("list",list);
		
		return "admin/boardPage";
	}
	
	@RequestMapping("/selectBoard")
	public String selectBoard(Model model) {
		
		return "";
	}
	
	//공지글 등록 페이지로 이동
	@RequestMapping("/insertBoardPage")
	public String insertBoardPage() {
		
		return "admin/insertBoard";
	}
	
	//공지글 등록
	@RequestMapping("/insertBoard")
	public String insertBoard(HttpSession session,BoardVO b) {
		
		int result = service.insertBoard(b);
		
		if(result>0) {
			session.setAttribute("alertMsg", "공지글 등록 성공");
		}else {
			session.setAttribute("alertMsg", "공지글 등록 성공");
		}
		
		return "redirect:boardPage";
	}
	
	//봉사활동 관리 페이지 이동
	@RequestMapping("/activityPage")
	public String activityPage(Model model) {
		
		ArrayList<ActivityVO> list = service.selectActivity();
		
		model.addAttribute("list",list);
		
		return "admin/activityPage";
	}
	
	//봉사활동 등록
	@RequestMapping("/insertActivity")
	public String insertActivity(HttpSession session,ActivityVO a) {
		
		int result = service.insertActivity(a);
			
		if(result>0) {
			session.setAttribute("alertMsg", "봉사활동 등록 성공");
		}else {
			session.setAttribute("alertMsg", "봉사활동 등록 실패");
		}
		
		return "redirect:activityPage";
	}
	
}
