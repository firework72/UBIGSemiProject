package com.ubig.app.volunteer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.vo.volunteer.ActivityVO;
import com.ubig.app.vo.volunteer.SignVO;
import com.ubig.app.vo.volunteer.VolunteerCommentVO;
import com.ubig.app.vo.volunteer.VolunteerReviewVO;
import com.ubig.app.volunteer.dao.VolunteerDao;

@Service
public class VolunteerServiceImpl implements VolunteerService {
	
	
	@Autowired
    private VolunteerDao volunteerDao;
	
	
	@Override
    public List<ActivityVO> selectActivityList() {
        // ▼▼▼ 여기도 return null; 이면 안됩니다! ▼▼▼
        return volunteerDao.selectActivityList();
    }
  
	

	@Override
	public int insertActivity(ActivityVO a) {
	    return volunteerDao.insertActivity(a);
	}
	
	
	@Override
	public ActivityVO selectActivityOne(int actId) {
		return volunteerDao.selectActivityOne(actId);
	}
	
	@Override
	public int deleteActivity(int actId) {
		return volunteerDao.deleteActivity(actId);
	}
	
	
	
	
	@Override
	public int updateActivity(ActivityVO a) {
		return volunteerDao.updateActivity(a);
	}

    @Override
    public List<VolunteerCommentVO> selectReplyList(int actId) {
        return volunteerDao.selectReplyList(actId);
    }
    @Override
    public int insertReply(VolunteerCommentVO r) {
        return volunteerDao.insertReply(r);
    }
    @Override
    public int deleteReply(int cmtNo) {
        return volunteerDao.deleteReply(cmtNo);
    }
    
    @Override
    public int insertSign(SignVO s) {
        // [1단계] 중복 신청 체크 (가장 먼저 해야 함!)
        // 이미 신청했다면 count가 1이 나옴
        int count = volunteerDao.checkDuplicateSign(s);
        
        if (count > 0) {
            System.out.println("❌ 중복 신청 감지! (" + s.getSignsId() + ")");
            return -2; // -2는 "이미 신청함"이라는 우리만의 신호입니다.
        }

        // [2단계] 정원 체크 (아까 만든 로직)
        ActivityVO activity = volunteerDao.selectActivityOne(s.getActId());
        if (activity == null) return 0;

        if (activity.getActCur() >= activity.getActMax()) {
            System.out.println("❌ 정원 초과!");
            return -1; // -1은 "정원 초과"
        }

        // [3단계] 모든 검사 통과 -> 등록 진행
        return volunteerDao.insertSign(s);
    }
    @Override
    public List<SignVO> selectSignList(int actId) {
        return volunteerDao.selectSignList(actId);
    }

    @Override
    public int insertReview(VolunteerReviewVO r) {
        return volunteerDao.insertReview(r);
    }
    @Override
    public List<VolunteerReviewVO> selectReviewList(int actId) {
        return volunteerDao.selectReviewList(actId);
    }
    
	
	
	
}
