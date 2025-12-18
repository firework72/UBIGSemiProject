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
public class VolunteerCommentVO {
	private int cmtNo;          // CMT_NO (댓글 번호/PK)
	private int actId;          // ACT_ID (활동 ID/FK - Activity 참조)
	private String userId;      // USER_ID (작성자 ID/FK - Member 참조)
	
	private String cmtAnswer;   // CMT_ANSWER (댓글 내용)
	
	private Date cmtDate;       // CMT_DATE (작성일)
	private Date cmtUpdate;     // CMT_UPDATE (수정일)
	
	private int cmtRemove;      // CMT_REMOVE (삭제 여부 / 0:유지, 1:삭제 등으로 사용)

}
