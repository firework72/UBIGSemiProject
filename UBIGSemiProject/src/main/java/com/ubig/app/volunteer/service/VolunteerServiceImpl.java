package com.ubig.app.volunteer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;

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
    public List<ActivityVO> selectActivityList(HashMap<String, String> map) {
        // [수정] 검색 조건(map)을 DAO로 전달
        return volunteerDao.selectActivityList(map);
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
    public List<VolunteerCommentVO> selectReplyList(VolunteerCommentVO vo) {
        return volunteerDao.selectReplyList(vo);
    }

    @Override
    public int insertReply(VolunteerCommentVO r) {
        int result = volunteerDao.insertReply(r);
        // [추가] 후기 댓글도 평점이 있으면 ACT_RATE 업데이트
        if (result > 0 && r.getCmtRate() != null) {
        	volunteerDao.updateActivityRate(r.getActId());
        }
        return result;
    }
    @Override
    public int deleteReply(int cmtNo) {
    	// [추가] 삭제 전 미리 정보 조회
    	VolunteerCommentVO c = volunteerDao.selectCommentOne(cmtNo);
    	
        int result = volunteerDao.deleteReply(cmtNo);
        
        // [추가] 삭제 성공 & 평점이 있었던 댓글이라면 재계산
        if (result > 0 && c != null && c.getCmtRate() != null) {
        	volunteerDao.updateActivityRate(c.getActId());
        }
        return result;
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
        int result = volunteerDao.insertReview(r);
        // [추가] 후기 등록 성공 시, 해당 활동의 평균 평점 업데이트
        if (result > 0) {
            volunteerDao.updateActivityRate(r.getActId());
        }
        return result;
    }

    @Override
    public List<VolunteerReviewVO> selectReviewList(int actId) {
        return volunteerDao.selectReviewList(actId);
    }
    
    @Override
    public List<VolunteerReviewVO> selectReviewListAll(HashMap<String, String> map) {
        return volunteerDao.selectReviewListAll(map);
    }
    
    @Override
    public VolunteerReviewVO selectReviewOne(int reviewNo) {
        return volunteerDao.selectReviewOne(reviewNo);
    }
    
    @Override
    public int updateReview(VolunteerReviewVO r) {
        // [추가] 후기 내용/평점 수정 시에도 평균 평점 업데이트가 필요할 수 있음
        int result = volunteerDao.updateReview(r);
        if (result > 0) {
        	// r에는 actId가 없을 수도 있으므로(화면에서 안넘겨줬다면), 
        	// 안전하게 하려면 DB에서 먼저 조회해야 하지만, 
        	// 보통 수정화면에서 hidden으로 actId를 넘겨주거나, 
        	// 여기서 다시 조회해서 업데이트를 하는게 좋습니다.
        	// 일단 사용자 요청은 "insert"와 "delete"에 집중되어 있으나, 
        	// update 시에도 점수가 바뀌면 반영되어야 하므로 추가하는게 맞습니다.
        	// 원활한 처리를 위해 actId를 조회 로직 추가
        	VolunteerReviewVO temp = volunteerDao.selectReviewOne(r.getReviewNo());
        	if(temp != null) {
        		volunteerDao.updateActivityRate(temp.getActId());
        	}
        }
        return result;
    }

    @Override
    public int deleteReview(int reviewNo) {
        // [추가] 삭제 전 actId를 조회해야 함 (삭제 후엔 조회 안될 수도 있거나, FK 문제 등)
        // 하지만 Soft Delete(R_REMOVE=1)이므로 조회는 가능.
        VolunteerReviewVO r = volunteerDao.selectReviewOne(reviewNo);
        
        int result = volunteerDao.deleteReview(reviewNo);
        
        if (result > 0 && r != null) {
            // [추가] 후기 삭제(숨김) 성공 시, 해당 활동의 평균 평점 업데이트
            volunteerDao.updateActivityRate(r.getActId());
        }
        return result;
    }
    
 // ==========================================
    // ▼ [누락된 후기 전용 메서드 추가] ▼ 12월 24일 15:29분 안티그래비티가 백업수정 다안해줌
    // ==========================================

    @Override
    public List<VolunteerCommentVO> selectReviewReplyList(VolunteerCommentVO vo) {
        // 기존에 만들어둔 DAO 메서드 재사용
        return volunteerDao.selectReplyList(vo);
    }

    @Override
    public int insertReviewReply(VolunteerCommentVO r) {
        // 1. 댓글 등록 (DAO 재사용)
        int result = volunteerDao.insertReply(r);
        
        // 2. [중요] 평점 반영 로직 (후기 점수 갱신)
        if (result > 0 && r.getCmtRate() != null) {
            volunteerDao.updateActivityRate(r.getActId());
        }
        return result;
    }

}
    
	
	
	

