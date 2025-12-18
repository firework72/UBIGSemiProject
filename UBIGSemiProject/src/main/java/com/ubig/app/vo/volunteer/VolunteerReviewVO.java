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
	private int reviewNo;       // REVIEW_NO (리뷰 번호/PK)
	private int actId;          // ACT_ID (활동 ID/FK - Activity 참조)
	private String rId;         // R_ID (작성자 ID - Member 참조)
	
	private String rReview;     // R_REVIEW (리뷰 내용 - 최대 4000바이트)
	private int rRate;          // R_RATE (별점/평점)
	
	private Date rCreate;       // R_CREATE (작성일)
	private Date rUpdate;       // R_UPDATE (수정일)
	
	private int rRemove;        // R_REMOVE (삭제 여부 / 0:정상, 1:삭제 등)

}
