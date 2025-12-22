package com.ubig.app.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.member.service.MessageService;
import com.ubig.app.vo.member.MemberVO;
import com.ubig.app.vo.member.MessageVO;

@Controller
@RequestMapping("/message")

public class MessageController {
	
	@Autowired
	private MessageService service;
	
	// TODO 쪽지함 기능
	@RequestMapping("/inbox.ms")
	public String inbox(HttpSession session, Model model) {
		
		// 내가 받은 쪽지들만을 표기해줘야 한다.
		// 그러기 위해 messageReceiveUserId가 현재 로그인된 아이디인 것만 선택해온다.
		
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		
		ArrayList<MessageVO> list = service.selectInbox(loginMember.getUserId());
		
		model.addAttribute("list", list);
		
		return "member/inbox";
	}
	
	// TODO 쪽지 보내기 페이지로 이동
	@GetMapping("/insert.ms")
	public String sendMessage() {
		return "";
	}
	
	// TODO 쪽지 보내기 기능
	@PostMapping("/insert.ms")
	public String insertMessage() {
		return "";
	}
}
