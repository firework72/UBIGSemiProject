package com.ubig.app.member.service;

import com.ubig.app.vo.member.KickVO;
import com.ubig.app.vo.member.MessageVO;

public interface KickService {
	int isKicked(KickVO kick);
}
