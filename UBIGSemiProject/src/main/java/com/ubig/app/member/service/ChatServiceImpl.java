package com.ubig.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.vo.member.AdminChatHistoryVO;

@Service
public class ChatServiceImpl implements ChatService{

	@Override
	public int insertChat(AdminChatHistoryVO chat) {
		return 0;
	}

}
