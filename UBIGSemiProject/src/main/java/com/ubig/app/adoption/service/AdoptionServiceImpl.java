package com.ubig.app.adoption.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.adoption.dao.AdoptionDao;
import com.ubig.app.vo.adoption.AnimalDetailVO;

@Service
public class AdoptionServiceImpl implements AdoptionService {
	
	@Autowired
	AdoptionDao dao;
    @Autowired
    private SqlSessionTemplate sqlSession; 
    
    //관리자가 동물 등록하기
	@Override
	public int insertAnimal(AnimalDetailVO animal) {
		return dao.insertAnimal(sqlSession,animal);
	}

	//페이징용 게시글 갯수 알아오기
	@Override
	public int listCount() {
		return dao.listCount(sqlSession);
	}

}
