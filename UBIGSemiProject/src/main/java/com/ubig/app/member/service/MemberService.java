package com.ubig.app.member.service;

import com.ubig.app.vo.member.MemberVO;

public interface MemberService {

	MemberVO loginMember(MemberVO inputMember);

	int insertMember(MemberVO m);

	int checkId(String userId);

}
