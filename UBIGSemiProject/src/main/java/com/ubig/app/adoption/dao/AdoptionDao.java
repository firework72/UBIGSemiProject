package com.ubig.app.adoption.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.adoption.AnimalDetailVO;

@Repository
public class AdoptionDao {

	public int insertAnimal(SqlSessionTemplate sqlSession, AnimalDetailVO animal) {
		return sqlSession.selectOne("adoptionMapper.insertAnimal", animal);
	}

}
