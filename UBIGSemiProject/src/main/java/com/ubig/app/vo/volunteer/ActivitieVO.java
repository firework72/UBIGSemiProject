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
public class ActivitieVO {
	
	private int actId;          // ACT_ID (PK예상)
	private String adminId;     // ADMIN_ID (작성자 ID)
	private Date actDate;       // ACT_DATE (활동 시작일?)
	private Date actEnd;        // ACT_END (활동 종료일?)
	private String actAddress;  // ACT_ADDRESS (주소)
	
	// 위도(LAT), 경도(LON)는 소수점이 있으므로 double 사용
	private double actLat;      // ACT_LAT
	private double actLon;      // ACT_LON
	
	private Date actLoad;       // ACT_LOAD (등록일/업로드일?)
	private String actTitle;    // ACT_TITLE (제목)
	
	private int actMax;         // ACT_MAX (최대 인원)
	private int actCur;         // ACT_CUR (현재 인원)
	private int actMoney;       // ACT_MONEY (금액/회비)
	
	

}
