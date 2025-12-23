package com.ubig.app.adoption.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

@Repository
public class AdoptionDao {

	public int insertAnimal(SqlSessionTemplate sqlSession, AnimalDetailVO animal) {
		return sqlSession.insert("adoptionMapper.insertAnimal", animal);
	}

	public int updateAnimal(SqlSessionTemplate sqlSession, AnimalDetailVO animal) {
		return sqlSession.update("adoptionMapper.updateAnimal", animal);
	}

	public int listCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adoptionMapper.listCount");
	}

	public ArrayList<AdoptionMainListVO> selectAdoptionMainList(SqlSessionTemplate sqlSession,
			AdoptionPageInfoVO pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("adoptionMapper.selectAdoptionMainList", null, rowBounds);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, AdoptionPostVO post) {
		return sqlSession.insert("adoptionMapper.insertBoard", post);
	}

	public AnimalDetailVO goAdoptionDetail(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.selectOne("adoptionMapper.goAdoptionDetail", anino);
	}

	public int insertApplication(SqlSessionTemplate sqlSession, AdoptionApplicationVO application) {
		return sqlSession.insert("adoptionMapper.insertApplication", application);
	}

	public int updateAdoptionStatus(SqlSessionTemplate sqlSession, int animalNo, String status) {
		Map<String, Object> map = new HashMap<>();
		map.put("animalNo", animalNo);
		map.put("status", status);
		return sqlSession.update("adoptionMapper.updateAdoptionStatus", map);
	}

	public int updateViewCount(SqlSessionTemplate sqlSession, int animalNo) {
		return sqlSession.update("adoptionMapper.updateViewCount", animalNo);
	}

	public int deleteAnimal(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.delete("adoptionMapper.deleteanimal", anino);
	}

	public int checkpost(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.selectOne("adoptionMapper.checkpost", anino);
	}

	public ArrayList<AnimalDetailVO> managepost(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("adoptionMapper.allList");
	}

	public ArrayList<AdoptionMainListVO> selectAnimalList1(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("adoptionMapper.selectAnimalList1", userId);
	}

	public ArrayList<AdoptionApplicationVO> selectAnimalList2(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("adoptionMapper.selectAnimalList2", userId);
	}

}
