package com.ubig.app.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ubig.app.member.service.KickService;
import com.ubig.app.vo.member.KickVO;
import com.ubig.app.vo.member.MessageVO;

@Controller
@RequestMapping("/kick")
public class KickController {
	
	@Autowired
	private KickService service;
	
	// 차단 여부 확인
	@ResponseBody
	@PostMapping("/isKicked.ki")
	public String isKicked(HttpSession session, String messageSendUserId, String messageReceiveUserId) {
		KickVO kick = KickVO.builder()
						    .kicker(messageReceiveUserId)
						    .kickedUser(messageSendUserId)
						    .build();
		
		int result = service.isKicked(kick);
		
		// 이미 차단 상태라면 차단 테이블에 등록되어 있으므로 result > 0이다.
		if (result > 0) {
			return "kicked";
		}
		else {
			return "notkicked";
		}
	}
	
	// 차단 처리
	@ResponseBody
	@PostMapping("/insertKick.ki")
	public String insertKick(HttpSession session, KickVO kick) {
		int result = 0;
		// int result = service.insertKick(kick);
		
		// 차단에 성공했다면 success, 아니라면 fail을 리턴한다.
		if (result > 0) {
			return "success";
		}
		else {
			return "fail";
		}
	}	
}
