package com.ubig.app.volunteer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.vo.volunteer.ActivitieVO;
import com.ubig.app.volunteer.dao.VolunteerDao;

@Service
public class VolunteerServiceImpl implements VolunteerService {
	
	
	@Autowired
    private VolunteerDao volunteerDao;
	
	
	@Override
    public List<ActivitieVO> selectActivityList() {
        // ▼▼▼ 여기도 return null; 이면 안됩니다! ▼▼▼
        return volunteerDao.selectActivityList();
    }
  
	

	@Override
	public int insertActivity(ActivitieVO a) {
	    return volunteerDao.insertActivity(a);
	}
	
	
	@Override
	public ActivitieVO selectActivityOne(int actId) {
		return volunteerDao.selectActivityOne(actId);
	}
	
	
}
