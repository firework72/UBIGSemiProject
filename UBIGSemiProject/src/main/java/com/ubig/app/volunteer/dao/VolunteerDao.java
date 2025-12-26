package com.ubig.app.volunteer.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.volunteer.ActivityVO;
import com.ubig.app.vo.volunteer.SignVO;
import com.ubig.app.vo.volunteer.VolunteerCommentVO;
import com.ubig.app.vo.volunteer.VolunteerReviewVO;

@Repository
public class VolunteerDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

    // [추가 사유] 검색 기능을 위해 매개변수 추가 (HashMap)
	public List<ActivityVO> selectActivityList(HashMap<String, String> map) {
		// 매퍼의 namespace(volunteerMapper)와 id(selectActivityList)를 연결
		return sqlSession.selectList("volunteerMapper.selectActivityList", map);
	}

    // ... (중략) ...

    // [추가 사유] 전체 후기 목록 조회 (검색 기능 추가)
    public List<VolunteerReviewVO> selectReviewListAll(HashMap<String, String> map) {
        return sqlSession.selectList("volunteerMapper.selectReviewListAll", map);
    }

	public int insertActivity(ActivityVO a) {
		return sqlSession.insert("volunteerMapper.insertActivity", a);
	}

	// 3. 상세 조회
	public ActivityVO selectActivityOne(int actId) {
		return sqlSession.selectOne("volunteerMapper.selectActivityOne", actId);
	}
	
	// 4. 삭제
		public int deleteActivity(int actId) {
			return sqlSession.delete("volunteerMapper.deleteActivity", actId);
		}
		
		
	// 5. 수정
	public int updateActivity(ActivityVO a) {
			return sqlSession.update("volunteerMapper.updateActivity", a);
	}
	
	// --- 댓글 관련 ---
    // [추가 사유] Controller의 댓글 목록 조회 요청을 처리하기 위해 Mapper의 selectReplyList 쿼리 호출
    // [수정] 파라미터 VO로 변경 (ActId + ReviewNo 분기 처리)
    // 봉사 프로그램 댓글 조회
    // --- 댓글 관련 (후기 전용) ---
    // 봉사 후기 댓글 조회
    public List<VolunteerCommentVO> selectReplyList(VolunteerCommentVO vo) {
        return sqlSession.selectList("volunteerMapper.selectReplyList", vo);
    }
    // 봉사 후기 댓글 등록
    public int insertReply(VolunteerCommentVO r) {
        return sqlSession.insert("volunteerMapper.insertReply", r);
    }
    // [추가 사유] 댓글 삭제 요청을 Mapper로 전달 (UPDATE 수행)
    public int deleteReply(int cmtNo) {
        return sqlSession.delete("volunteerMapper.deleteReply", cmtNo);
    }
    
    // [추가] 댓글 단건 조회 (삭제 시 ActId 확인용)
    public VolunteerCommentVO selectCommentOne(int cmtNo) {
        return sqlSession.selectOne("volunteerMapper.selectCommentOne", cmtNo);
    }

    // --- 신청 관련 ---
    // [추가 사유] 봉사 신청 정보 저장을 위해 Mapper 호출
    public int insertSign(SignVO s) {
        return sqlSession.insert("volunteerMapper.insertSign", s);
    }
    // [추가 사유] 신청자 목록 조회를 위해 Mapper 호출
    public List<SignVO> selectSignList(int actId) {
        return sqlSession.selectList("volunteerMapper.selectSignList", actId);
    }

    // --- 후기 관련 ---
    // [추가 사유] 봉사 후기 등록을 위해 Mapper 호출
    public int insertReview(VolunteerReviewVO r) {
        return sqlSession.insert("volunteerMapper.insertReview", r);
    }
    // [추가 사유] 봉사 후기 목록 조회를 위해 Mapper 호출
    public List<VolunteerReviewVO> selectReviewList(int actId) {
        return sqlSession.selectList("volunteerMapper.selectReviewList", actId);
    }
    
    // [추가 사유] 전체 후기 목록 조회
    public List<VolunteerReviewVO> selectReviewListAll() {
        return sqlSession.selectList("volunteerMapper.selectReviewListAll");
    }
    
    // [추가 사유] 후기 상세 조회
    public VolunteerReviewVO selectReviewOne(int reviewNo) {
        return sqlSession.selectOne("volunteerMapper.selectReviewOne", reviewNo);
    }
    
    // [추가 사유] 후기 수정
    public int updateReview(VolunteerReviewVO r) {
        return sqlSession.update("volunteerMapper.updateReview", r);
    }

    // [추가 사유] 후기 삭제 (Soft Delete)
    public int deleteReview(int reviewNo) {
        return sqlSession.update("volunteerMapper.deleteReview", reviewNo);
    }

    //봉사 신청 중복 체크 메소드
    public int checkDuplicateSign(SignVO s) {
        return sqlSession.selectOne("volunteerMapper.checkDuplicateSign", s);
    }
    
    // [추가] 활동 평균 별점 업데이트
	public int updateActivityRate(int actId) {
		return sqlSession.update("volunteerMapper.updateActivityRate", actId);
	}
	
	// VolunteerDao.java 에 추가
	public int checkDuplicateReview(int actId) {
	    // 해당 봉사활동 ID로 작성된(삭제되지 않은) 후기가 있는지 개수 확인
	    return sqlSession.selectOne("volunteerMapper.checkDuplicateReview", actId);
	}
	
	// [추가] 후기 작성용: 아직 후기가 없는 봉사활동 목록 조회
	public List<ActivityVO> selectActivityNoReview() {
	    return sqlSession.selectList("volunteerMapper.selectActivityNoReview");
	}
	
	
	// -----------------------------------------------------------
    // [추가] 관리자 승인/반려 및 사용자 취소 관련 메소드
    // -----------------------------------------------------------

    // 1. 신청 상태 변경 (대기0 -> 승인1 / 반려2 / 취소3)
    public int updateSignStatus(SignVO s) {
        return sqlSession.update("volunteerMapper.updateSignStatus", s);
    }

    // 2. 승인 시 -> 활동 현재 인원 1명 증가
    public int increaseActivityCur(int actId) {
        return sqlSession.update("volunteerMapper.increaseActivityCur", actId);
    }

    // 3. 취소 시 -> 활동 현재 인원 1명 감소 (기존 Mapper 활용)
    public int decreaseActivityCur(int actId) {
        return sqlSession.update("volunteerMapper.decreaseActivityCur", actId);
    }

    // 4. 신청 정보 단건 조회 (상태 변경 전, 현재 상태나 활동ID 확인용)
    public SignVO selectSignOne(int signsNo) {
        return sqlSession.selectOne("volunteerMapper.selectSignOne", signsNo);
    }
	
	
	
	
	
	
	
	
}
