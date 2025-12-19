package com.ubig.app.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.member.service.MemberService;
import com.ubig.app.vo.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;

	// 로그인 페이지로 이동
	@GetMapping("/login")
	public String login() {

		return "member/login";
	}

	// 로그인 처리
	@PostMapping("/login")
	public String loginMember(HttpSession session,
			String userId,
			String userPwd,
			Model model) {

		// 사용자가 입력한 아이디와 비밀번호를 가져온다.

		MemberVO inputMember = MemberVO.builder().userId(userId).userPwd(userPwd).build();

		MemberVO m = service.loginMember(inputMember);

		// 아이디와 암호화된 비밀번호가 일치하는 컬럼이 데이터베이스에 존재한다면 로그인 성공 및 세션에 로그인 정보 저장
		if (m != null) {
			session.setAttribute("loginMember", m);
			return "redirect:/";
		}
		// 존재하지 않는다면 로그인 실패 처리 및 login 페이지로 다시 이동 후 실패 알림
		else {
			session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "member/login";
		}
	}

	// 테스트용 로그인 (DB 없이 관리자 세션 생성)
	@GetMapping("/testLogin")
	public String testLogin(HttpSession session) {
		MemberVO testAdmin = MemberVO.builder()
				.userId("admin")
				.userPwd("1234")
				.userName("관리자")
				.userNickname("개발자")
				.userRole("ADMIN")
				.build();

		// 기존 코드와 새 코드 모두 호환되도록 두 가지 이름으로 저장
		session.setAttribute("loginMember", testAdmin);
		session.setAttribute("loginUser", testAdmin);

		return "redirect:/community/list?category=NOTICE";
	}
}
