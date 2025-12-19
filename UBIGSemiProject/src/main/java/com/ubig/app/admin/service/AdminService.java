package com.ubig.app.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.ubig.app.vo.member.MemberVO;

public interface AdminService {
	
	ArrayList<MemberVO> selectUser();

	int updateStatus(HashMap<String,String> map);

	int deleteUser(String userId);

	int insertBoard();

	int insertActivity();

	int changeStatus(HashMap<String, String> map);

}
