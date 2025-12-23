package com.ubig.app.volunteer.service;

import java.util.List;

import com.ubig.app.vo.volunteer.ActivityVO;
import com.ubig.app.vo.volunteer.SignVO;
import com.ubig.app.vo.volunteer.VolunteerCommentVO;
import com.ubig.app.vo.volunteer.VolunteerReviewVO;

public interface VolunteerService {

	
	//1.활동 조회 (검색 기능 추가)
	List<ActivityVO> selectActivityList(java.util.HashMap<String, String> map);
	
	
	//2.활동 등록
	int insertActivity(ActivityVO a);
	
	
	// 3. 활동 글 상세 조회
	ActivityVO selectActivityOne(int actId);
	
	// 4. 활동 글 삭제
		int deleteActivity(int actId);
		
		
	// 5. 수정
	int updateActivity(ActivityVO a);
	
	// --- 댓글 관련 ---
    // [추가 사유] Controller의 댓글 목록 조회 요청을 처리하기 위해 DAO로 연결
    List<VolunteerCommentVO> selectReplyList(int actId);
    // [추가 사유] Controller의 댓글 등록 요청을 전달
    int insertReply(VolunteerCommentVO r);
    // [추가 사유] 댓글 삭제 비즈니스 로직 수행
    int deleteReply(int cmtNo);

    // --- 신청 관련 ---
    // [추가 사유] 봉사 신청 정보 데이터 전달
    int insertSign(SignVO s);
    // [추가 사유] 신청자 목록 데이터 전달
    List<SignVO> selectSignList(int actId);

    // --- 후기 관련 ---
    // [추가 사유] 봉사 후기 등록 로직 수행
    int insertReview(VolunteerReviewVO r);
    // [추가 사유] 봉사 후기 목록 조회 로직 수행
    List<VolunteerReviewVO> selectReviewList(int actId);
    
    // [추가 사유] 전체 후기 목록 조회 로직 수행 (검색 기능 추가)
    List<VolunteerReviewVO> selectReviewListAll(java.util.HashMap<String, String> map);
    
    // [추가 사유] 후기 상세 조회 로직 수행
    VolunteerReviewVO selectReviewOne(int reviewNo);

    // [추가 사유] 후기 수정 기능
    int updateReview(VolunteerReviewVO r);

    // [추가 사유] 후기 삭제 기능
    int deleteReview(int reviewNo);

}
