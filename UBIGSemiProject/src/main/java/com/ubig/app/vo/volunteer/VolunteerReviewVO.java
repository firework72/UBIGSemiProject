package com.ubig.app.vo.volunteer;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class VolunteerReviewVO {
	
	private int reviewNo;       // REVIEW_NO (후기번호/PK)
	private int actId;          // ACT_ID (프로그램ID/FK)
	private String rId;         // R_ID (회원아이디/FK)
	
	private String rReview;     // R_REVIEW (봉사활동후기)
	private int rRate;          // R_RATE (봉사평점)
	
	private Date rCreate;       // R_CREATE (작성일시)
	private Date rUpdate;       // R_UPDATE (수정일시)
	
	private int rRemove;        // R_REMOVE (후기삭제)
}
