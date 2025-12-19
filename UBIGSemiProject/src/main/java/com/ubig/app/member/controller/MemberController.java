package com.ubig.app.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ubig.app.member.service.MemberService;
import com.ubig.app.vo.member.MemberVO;

@Controller
@RequestMapping("/user")
public class MemberController {
	
	// MemberService
	@Autowired
	private MemberService service;
	
	// BCryptPasswordEncoder 사용하기 위해서 스프링에게 주입 처리 하기
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	// 로그인 페이지로 이동
	@GetMapping("/login.me")
	public String login() {
		
		return "member/login";
	}
	
	// 로그인 처리
	@PostMapping("/login.me")
	public String loginMember(HttpSession session,
							  String userId,
							  String userPwd,
							  Model model) {
		
		System.out.println(userId);
		System.out.println(userPwd);
		// 사용자가 입력한 아이디와 비밀번호를 가져온다.
		
		MemberVO inputMember = MemberVO.builder().userId(userId).userPwd(userPwd).build();
		
		inputMember.setUserPwd(bcrypt.encode(inputMember.getUserPwd()));
		
		MemberVO loginMember = service.loginMember(inputMember);
		
		// 아이디와 암호화된 비밀번호가 일치하는 컬럼이 데이터베이스에 존재한다면 로그인 성공 및 세션에 로그인 정보 저장
		if (loginMember != null && bcrypt.matches(inputMember.getUserPwd(), loginMember.getUserPwd())) {
			
			// TODO : 현재 날짜가 정지 일자를 지나지 않았다면, 정지된 상태임을 알리고 로그인 처리를 거부해야 한다.
			
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		}
		// 존재하지 않는다면 로그인 실패 처리 및 login 페이지로 다시 이동 후 실패 알림
		else {
			session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "member/login";
		}
	}
	
	// TODO 로그아웃 처리
	@PostMapping("/logout.me")
	public String logout(HttpSession session, Model model) {
		// HttpSession에서 loginMember에 대한 정보를 가져온다.
		// 만약 loginMember 정보가 없다면 이미 로그아웃된 상태이고,
		// loginMember에 정보가 있다면 로그아웃 시켜준다.
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember != null) {
			session.removeAttribute("loginMember");
			session.setAttribute("alertMsg", "로그아웃되었습니다.");
		}
		else {
			session.setAttribute("alertMsg", "이미 로그아웃 되어있습니다.");
		}
		return "redirect:/";
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/signup.me")
	public String signup() {
		return "member/signup";
	}
	
	// TODO 회원가입 처리
	@PostMapping("/signup.me")
	public String insertMember(HttpSession session, MemberVO m) {
		
		int result = service.insertMember(m);
		
		// 비밀번호 암호화
		m.setUserPwd(bcrypt.encode(m.getUserPwd()));
		
		if (result > 0) {
			session.setAttribute("alerMsg", "회원가입에 성공하였습니다.");
		}
		else {
			session.setAttribute("alertMsg", "회원가입에 실패하였습니다.");
		}
		
		return "redirect:/user/signup.me";
		// TODO 회원가입에 실패했을 경우 기존에 입력된 내용이 유지되도록?
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping("/checkId.me")
	public String checkId(String userId) {
		// 이미 존재하는 아이디라면 fail, 존재하지 않는 아이디라면 success 추가
		
		int result = service.checkId(userId);
		
		if (result > 0) {
			return "fail";
		}
		else {
			return "success";
		}
	}
	
	// TODO 마이페이지 이동
	
	// TODO 회원수정 페이지 이동
	
	// TODO 회원수정 처리
	
	// TODO 회원탈퇴 처리
}
