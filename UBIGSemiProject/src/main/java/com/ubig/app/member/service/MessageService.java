package com.ubig.app.member.service;

import java.util.ArrayList;

import com.ubig.app.vo.member.MessageVO;

public interface MessageService {

	ArrayList<MessageVO> selectInbox(String userId);

	int unreadCount(String userId);

}
