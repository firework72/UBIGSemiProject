package com.ubig.app.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

//로그인 해야지만 접근 가능한 페이지 인터셉터(로그인 정보가 없으면 로그인 페이지로 이동)
public class LoginInterceptor implements HandlerInterceptor {

	// 요청 처리 전 간섭
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		Object loginMember = request.getSession().getAttribute("loginMember");

		// 로그인 정보가 없으면 로그인 페이지로 이동
		if (loginMember == null) {
			request.getSession().setAttribute("alertMsg", "로그인 후 접근 가능합니다.");
			response.sendRedirect(request.getContextPath() + "/user/login.me");
			return false;
		}

		return true;
	}
}
