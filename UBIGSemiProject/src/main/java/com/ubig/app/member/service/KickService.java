package com.ubig.app.member.service;

import java.util.ArrayList;

import com.ubig.app.vo.member.KickVO;
import com.ubig.app.vo.member.MessageVO;

public interface KickService {
	int isKicked(KickVO kick);

	int insertKick(KickVO kick);

	ArrayList<KickVO> selectKick(String userId);

	int deleteKick(int kickNo);
}
