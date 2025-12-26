package com.ubig.app.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.ubig.app.vo.community.BoardVO;
import com.ubig.app.vo.funding.DonationVO;
import com.ubig.app.vo.member.MemberVO;
import com.ubig.app.vo.volunteer.ActivityVO;

public interface AdminService {
	
	ArrayList<MemberVO> selectUser();

	int updateStatus(HashMap<String,String> map);

	int deleteUser(String userId);

	int insertBoard(BoardVO b);

	int insertActivity(ActivityVO a);

	int changeStatus(HashMap<String, String> map);

	ArrayList<BoardVO> selectBoard();

	ArrayList<ActivityVO> selectActivity();

	ArrayList<MemberVO> searchKeyword(String searchKeyword);

}
