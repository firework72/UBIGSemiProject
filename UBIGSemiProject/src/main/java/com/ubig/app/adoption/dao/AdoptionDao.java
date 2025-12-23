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

	// AnimalDetailVO를 가지고 동물 정보 등록하기
	public int insertAnimal(SqlSessionTemplate sqlSession, AnimalDetailVO animal) {
		return sqlSession.insert("adoptionMapper.insertAnimal", animal);
	}

	// AnimalDetailVO를 가지고 동물 정보 수정하기
	public int updateAnimal(SqlSessionTemplate sqlSession, AnimalDetailVO animal) {
		return sqlSession.update("adoptionMapper.updateAnimal", animal);
	}

	// 게시글 전체 갯수 가져오기
	public int listCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adoptionMapper.listCount");
	}

	// PageInfo를 가지고 메인 페이지 게시글 목록 가져오기
	public ArrayList<AdoptionMainListVO> selectAdoptionMainList(SqlSessionTemplate sqlSession,
			AdoptionPageInfoVO pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("adoptionMapper.selectAdoptionMainList", null,
				rowBounds);
	}

	// AdoptionPostVO를 가지고 게시글 등록하기
	public int insertBoard(SqlSessionTemplate sqlSession, AdoptionPostVO post) {
		return sqlSession.insert("adoptionMapper.insertBoard", post);
	}

	// anino를 가지고 동물 상세 정보 가져오기
	public AnimalDetailVO goAdoptionDetail(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.selectOne("adoptionMapper.goAdoptionDetail", anino);
	}

	// AdoptionApplicationVO를 가지고 입양 신청서 등록하기
	public int insertApplication(SqlSessionTemplate sqlSession, AdoptionApplicationVO application) {
		return sqlSession.insert("adoptionMapper.insertApplication", application);
	}

	// animalNo와 status를 가지고 입양 상태 변경하기
	public int updateAdoptionStatus(SqlSessionTemplate sqlSession, int animalNo, String status) {
		Map<String, Object> map = new HashMap<>();
		map.put("animalNo", animalNo);
		map.put("status", status);
		return sqlSession.update("adoptionMapper.updateAdoptionStatus", map);
	}

	// animalNo를 가지고 조회수 증가시키기
	public int updateViewCount(SqlSessionTemplate sqlSession, int animalNo) {
		return sqlSession.update("adoptionMapper.updateViewCount", animalNo);
	}

	// anino를 가지고 동물 정보 삭제하기
	public int deleteAnimal(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.delete("adoptionMapper.deleteanimal", anino);
	}

	// anino를 가지고 게시글 존재 여부(갯수) 가져오기
	public int checkpost(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.selectOne("adoptionMapper.checkpost", anino);
	}

	// 관리자용 동물/게시글 전체 목록 가져오기
	public ArrayList<AnimalDetailVO> managepost(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("adoptionMapper.allList");
	}

	// userId를 가지고 등록한 동물 목록 가져오기
	public ArrayList<AdoptionMainListVO> selectAnimalList1(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("adoptionMapper.selectAnimalList1", userId);
	}

	// userId를 가지고 신청한 입양 목록 가져오기
	public ArrayList<AdoptionApplicationVO> selectAnimalList2(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList) sqlSession.selectList("adoptionMapper.selectAnimalList2", userId);
	}

	// anino를 가지고 게시글 삭제하기
	public int deletePost(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.delete("adoptionMapper.deletePost", anino);
	}

	// anino를 가지고 관련 입양 신청 내역 전체 삭제하기
	public int deleteApplicationsByAnimalNo(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.delete("adoptionMapper.deleteApplicationsByAnimalNo", anino);
	}

	// Map(animalNo, status)을 가지고 입양 상태 변경하기
	public int updateAdoptionStatus(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("adoptionMapper.updateAdoptionStatus", map);
	}

	// adoptionAppId를 가지고 신청서 정보 가져오기
	public AdoptionApplicationVO selectApplication(SqlSessionTemplate sqlSession, int adoptionAppId) {
		return sqlSession.selectOne("adoptionMapper.selectApplication", adoptionAppId);
	}

	// adoptionAppId를 가지고 신청서 삭제하기
	public int deleteapp(SqlSessionTemplate sqlSession, int adoptionAppId) {
		return sqlSession.delete("adoptionMapper.deleteapp", adoptionAppId);
	}

}
