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

	@Override
	public int insertAnimal(AnimalDetailVO animal) {
		return dao.insertAnimal(sqlSession,animal);
	}

}
