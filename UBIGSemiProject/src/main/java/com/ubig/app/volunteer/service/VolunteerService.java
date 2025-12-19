package com.ubig.app.volunteer.service;

import java.util.List;

import com.ubig.app.vo.volunteer.ActivitieVO;

public interface VolunteerService {

	
	//1.활동 조회
	List<ActivitieVO> selectActivityList();
	
	
	//2.활동 등록
	int insertActivity(ActivitieVO a);
	
	
	// 3. 상세 조회
	ActivitieVO selectActivityOne(int actId);
	

}
