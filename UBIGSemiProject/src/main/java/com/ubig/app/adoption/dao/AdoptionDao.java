package com.ubig.app.adoption.dao;

import java.util.List;
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

import com.ubig.app.vo.adoption.AdoptionSearchFilterVO;

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

	// 게시글 전체 갯수 가져오기 (필터 적용)
	public int listCount(SqlSessionTemplate sqlSession, AdoptionSearchFilterVO filter) {
		return sqlSession.selectOne("adoptionMapper.listCount", filter);
	}

	// PageInfo를 가지고 메인 페이지 게시글 목록 가져오기 (필터 적용)
	public List<AdoptionMainListVO> selectAdoptionMainList(SqlSessionTemplate sqlSession,
			AdoptionPageInfoVO pi, AdoptionSearchFilterVO filter, RowBounds rowBounds) {
		return sqlSession.selectList("adoptionMapper.selectAdoptionMainList", filter, rowBounds);
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
	public List<AnimalDetailVO> managepost(SqlSessionTemplate sqlSession, RowBounds rowBounds,
			Map<String, Object> map) {
		return sqlSession.selectList("adoptionMapper.allList", map, rowBounds);
	}

	// userId를 가지고 등록한 동물 목록 가져오기 (페이징, 검색)
	public List<AdoptionMainListVO> selectAnimalList1(SqlSessionTemplate sqlSession, String userId,
			RowBounds rowBounds, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("keyword", keyword);
		return sqlSession.selectList("adoptionMapper.selectAnimalList1", map, rowBounds);
	}

	// userId를 가지고 등록한 동물 수 세기 (검색)
	public int myList1Count(SqlSessionTemplate sqlSession, String userId, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("keyword", keyword);
		return sqlSession.selectOne("adoptionMapper.selectAnimalList1Count", map);
	}

	// userId를 가지고 신청한 입양 목록 가져오기 (페이징)
	public List<AdoptionApplicationVO> selectAnimalList2(SqlSessionTemplate sqlSession, String userId,
			RowBounds rowBounds) {
		return sqlSession.selectList("adoptionMapper.selectAnimalList2", userId, rowBounds);
	}

	// userId를 가지고 신청한 입양 수 세기
	public int myList2Count(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("adoptionMapper.selectAnimalList2Count", userId);
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

	// anino를 가지고 해당 동물 정보상태 반려하기
	public int denyBoard(SqlSessionTemplate sqlSession, int anino) {
		return sqlSession.update("adoptionMapper.denyBoard", anino);
	}

	// 신청서 중복 체크 로직
	public int checkApplication(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("adoptionMapper.checkApplication", map);
	}

	// 관리자용 동물/게시글 전체 목록 갯수
	public int managepostCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("adoptionMapper.managepostCount", map);
	}

}
