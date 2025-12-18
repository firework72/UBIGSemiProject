package com.ubig.app.admin.service;

import java.util.ArrayList;

import com.ubig.app.vo.member.MemberVO;

public interface AdminService {
	
	ArrayList<MemberVO> selectUser();

	int updateStatus(String userId);

	int deleteUser(String userId);

	int insertBoard();

}
