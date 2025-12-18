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
public class SignVO {
	private int signsNo;        // SIGNS_NO (신청 번호/PK)
	private int actId;          // ACT_ID (활동 게시글 번호/FK)
	private String signsId;     // SIGNS_ID (신청자 ID/FK)
	
	private int signsWait;      // SIGNS_WAIT (대기 순번? 또는 대기 상태값)
	private int signsStatus;    // SIGNS_STATUS (신청 상태: 승인,취소 등)
	
	private Date signsDate;     // SIGNS_DATE (신청 날짜)
	
	
	

}
