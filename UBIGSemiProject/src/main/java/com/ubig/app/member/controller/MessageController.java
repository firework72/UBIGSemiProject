package com.ubig.app.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		ArrayList<MessageVO> list = service.selectSent(loginMember.getUserId());
		
		int unreadCount = service.unreadCount(loginMember.getUserId());
		
		for (MessageVO msg : list) {
			System.out.println(msg);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("unreadCount", unreadCount);
		
		return "member/sent";
	}

	
	// TODO 쪽지 보내기 기능
	@PostMapping("/insert.ms")
	public String insertMessage(HttpSession session, MessageVO message, Model model) {
		
		// MESSAGES 테이블에 데이터를 추가한다.
		
		// 만약 수신자가 발신자를 차단한 상태라면 message 상태를 'K'로 보내야 하고, 아니라면 'N'으로 보내야 한다.
		// message 상태가 'K'인 경우 수신자에게 표시되지 않으며, 발신자에게는 '읽지 않음'으로 표시된다
		
		// 현재 수신자가 발신자를 차단한 상태인지 확인
		// 수신자는 messageReceiveUserId이고 발신자는 messageSendUserId이다.
		
		int isKicked = service.isKicked(message);
		
		// 만약 수신자가 발신자를 차단한 상태라면 (즉, 조회된 행의 개수가 0이 아니라면) message의 messageIsCheck를 'K'로 바꾼다.
		
		if (isKicked > 0) {
			message.setMessageIsCheck("K");
		}
		else {
			message.setMessageIsCheck("N");
		}
		
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
	
	// 차단 여부 확인
	@ResponseBody
	@PostMapping("/isKicked.ms")
	public String isKicked(HttpSession session, String messageSendUserId, String messageReceiveUserId) {
		MessageVO message = MessageVO.builder()
								     .messageSendUserId(messageSendUserId)
								     .messageReceiveUserId(messageReceiveUserId)
								     .build();
		
		int result = service.isKicked(message);
		
		// 이미 차단 상태라면 차단 테이블에 등록되어 있으므로 result > 0이다.
		if (result > 0) {
			return "kicked";
		}
		else {
			return "notkicked";
		}
	}
	
	// 메시지 읽음 처리
	@ResponseBody
	@PostMapping("/read.ms")
	public String readMessage(int messageNo) {
		
		int result = service.readMessage(messageNo);
		
		return "success";
	}
}


