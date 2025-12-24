package com.ubig.app.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.member.dao.KickDao;
import com.ubig.app.vo.member.KickVO;

@Service
public class KickServiceImpl implements KickService {
	
	@Autowired
	private KickDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 수신자가 발신자를 차단했는지 유무 체크
	@Override
	public int isKicked(KickVO kick) {
		return dao.isKicked(sqlSession, kick);
	}
	
}
