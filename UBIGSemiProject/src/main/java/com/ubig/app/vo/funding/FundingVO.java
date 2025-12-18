package com.ubig.app.vo.funding;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class FundingVO {
	
	private int fNo;
	private String userId;
	private String fTitle;
	private String fContent;
	private int fMaxMoney;
	private int fCurrentMoney;
}
