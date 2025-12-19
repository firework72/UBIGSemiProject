package com.ubig.app.volunteer.service;

import java.util.List;

import com.ubig.app.vo.volunteer.ActivityVO;

public interface VolunteerService {

	
	//1.활동 조회
	List<ActivityVO> selectActivityList();
	
	
	//2.활동 등록
	int insertActivity(ActivityVO a);
	
	
	// 3. 활동 글 상세 조회
	ActivityVO selectActivityOne(int actId);
	
	// 4. 활동 글 삭제
		int deleteActivity(int actId);
		
		
	// 5. 수정
	int updateActivity(ActivityVO a);
	

}
