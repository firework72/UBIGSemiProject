package com.ubig.app.adoption.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

@Repository
public class AdoptionDao {

	public int insertAnimal(SqlSessionTemplate sqlSession, AnimalDetailVO animal) {
		return sqlSession.insert("adoptionMapper.insertAnimal", animal);
	}

	public int listCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adoptionMapper.listCount");
	}

	public ArrayList<AdoptionPostVO> boardList(SqlSessionTemplate sqlSession, AdoptionPageInfoVO pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("adoptionMapper.boardList",null,rowBounds);
	}

	public ArrayList<AnimalDetailVO> getPhoto(SqlSessionTemplate sqlSession, ArrayList<Integer> photo) {
		return (ArrayList)sqlSession.selectList("adoptionMapper.getPhoto",photo);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, AdoptionPostVO post) {
		return sqlSession.insert("adoptionMapper.insertBoard",post);
	}

	public AnimalDetailVO goAdoptionDetail(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.selectOne("adoptionMapper.goAdoptionDetail",anino);
	}


}
