package com.ubig.app.member.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.member.service.AdminChatService;
import com.ubig.app.vo.member.MemberVO;

@Controller
@RequestMapping("/admin")

public class AdminChatController {
	
	@Autowired
	private AdminChatService service;
	
	/*
	 * 어드민 페이지에서는 모든 일반 회원과 의사소통할 수 있어야한다.
	 * chatList에서는 모든 일반 회원 리스트가 뜨도록 하며
	 * 버튼을 누르면 해당 회원과의 1:1 채팅창으로 이동한다.
	 * 
	 * 발신인이 어드민이면 수신인은 일반회원이고
	 * 발신인이 일반회원이면 수신인은 어드민이다.
	 * 
	 * 
	 * 
	 */
	
	@RequestMapping("/chatList.ch")
	public String chatList(Model model) {
		// 가장 최근 채팅이 올라온 유저부터 순서대로 표시한다.
		// ...구현이 힘들어질 것 같으니 일단 MEMBERS에서 리스트 뽑아서 채팅 버튼 만들기
		
		ArrayList<MemberVO> list = service.chatList();
		
		model.addAttribute("list", list);
		
		return "admin/chatlist";
	}
}
