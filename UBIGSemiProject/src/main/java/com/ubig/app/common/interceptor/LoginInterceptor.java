package com.ubig.app.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ubig.app.member.service.MemberService;
import com.ubig.app.vo.member.MemberVO;

//로그인 해야지만 접근 가능한 페이지 인터셉터(로그인 정보가 없으면 로그인 페이지로 이동)
public class LoginInterceptor implements HandlerInterceptor {
	
	@Autowired
	private MemberService service;

	// 요청 처리 전 간섭
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		MemberVO loginMember = (MemberVO) request.getSession().getAttribute("loginMember");

		// 로그인 정보가 없으면 로그인 페이지로 이동
		if (loginMember == null) {
			request.getSession().setAttribute("alertMsg", "로그인 후 접근 가능합니다.");
			response.sendRedirect(request.getContextPath() + "/user/login.me");
			return false;
		}
		else {
			loginMember = service.loginMember(loginMember);
			System.out.println("인터셉터에서 세션 로그인 정보를 갱신하였습니다.");
			request.getSession().setAttribute("loginMember", loginMember);
		}

		return true;
	}
}
