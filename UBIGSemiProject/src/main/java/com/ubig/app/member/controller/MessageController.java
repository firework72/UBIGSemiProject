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
		
		int unreadCount = service.unreadCount(loginMember.getUserId());
		
		for (MessageVO msg : list) {
			System.out.println(msg);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("unreadCount", unreadCount);
		
		return "member/inbox";
	}
	
	// TODO 보낸메시지 확인 기능
	@RequestMapping("/sent.ms")
	public String sent(HttpSession session, Model model) {
		// 내가 보낸 쪽지들만을 표기해줘야 한다.
		// 그러기 위해 messageSendUserId가 현재 로그인된 아이디인 것만 선택해온다.
		
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		
		ArrayList<MessageVO> list = service.selectInbox(loginMember.getUserId());
		
		int unreadCount = service.unreadCount(loginMember.getUserId());
		
		for (MessageVO msg : list) {
			System.out.println(msg);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("unreadCount", unreadCount);
		
		return "member/inbox";
	}

	
	// TODO 쪽지 보내기 기능
	@PostMapping("/insert.ms")
	public String insertMessage(HttpSession session, MessageVO message, Model model) {
		
		// MESSAGES 테이블에 데이터를 추가한다.
		
		int result = service.insertMessage(message);
		
		if (result > 0) {
			session.setAttribute("alertMsg", "쪽지를 보냈습니다.");
			return "redirect:/message/sent.ms";
		}
		else {
			session.setAttribute("alertMsg", "쪽지를 보내는 데 실패했습니다.");
			return "redirect:/message/inbox.ms";
		}
	}
}
