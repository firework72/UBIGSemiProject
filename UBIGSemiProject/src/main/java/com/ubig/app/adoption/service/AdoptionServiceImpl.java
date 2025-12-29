package com.ubig.app.adoption.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.adoption.dao.AdoptionDao;
import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;

import org.springframework.transaction.annotation.Transactional;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

import com.ubig.app.vo.adoption.AdoptionSearchFilterVO;

@Service
public class AdoptionServiceImpl implements AdoptionService {

	@Autowired
	AdoptionDao dao;
	@Autowired
	private SqlSessionTemplate sqlSession;

	// AnimalDetailVO를 가지고 동물 정보 등록하기
	@Override
	public int insertAnimal(AnimalDetailVO animal) {
		return dao.insertAnimal(sqlSession, animal);
	}

	// AnimalDetailVO를 가지고 동물 정보 수정하기
	@Override
	public int updateAnimal(AnimalDetailVO animal) {
		return dao.updateAnimal(sqlSession, animal);
	}

	// 게시글 전체 갯수 가져오기 (필터 적용)
	@Override
	public int listCount(AdoptionSearchFilterVO filter) {
		return dao.listCount(sqlSession, filter);
	}

	// PageInfo를 가지고 메인 페이지 게시글 목록 가져오기 (필터 적용)
	@Override
	public List<AdoptionMainListVO> selectAdoptionMainList(AdoptionPageInfoVO pi, AdoptionSearchFilterVO filter) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return dao.selectAdoptionMainList(sqlSession, pi, filter, rowBounds);
	}

	// AdoptionPostVO를 가지고 게시글 등록하기
	@Override
	public int insertBoard(AdoptionPostVO post) {
		return dao.insertBoard(sqlSession, post);
	}

	// anino를 가지고 동물 상세 정보 가져오기
	@Override
	public AnimalDetailVO goAdoptionDetail(int anino) {
		return dao.goAdoptionDetail(sqlSession, anino);
	}

	// AdoptionApplicationVO를 가지고 입양 신청서 등록하기 (성공 시 상태 변경 포함)
	@Override
	public int insertApplication(AdoptionApplicationVO application) {
		int result = dao.insertApplication(sqlSession, application);

		if (result > 0) {
			// 신청 성공 시 해당 동물의 입양 상태를 '신청중'으로 자동 변경
			dao.updateAdoptionStatus(sqlSession, application.getAnimalNo(), "신청중");
		}

		return result;
	}

	// animalNo를 가지고 조회수 증가시키기
	@Override
	public int updateViewCount(int animalNo) {
		return dao.updateViewCount(sqlSession, animalNo);
	}

	// anino를 가지고 동물 정보 삭제하기
	@Override
	public int deleteAnimal(int anino) {
		return dao.deleteAnimal(sqlSession, anino);
	}

	// anino를 가지고 동물 정보 및 관련 데이터(게시글, 신청내역) 일괄 삭제하기 (트랜잭션 적용)
	@Override
	@Transactional
	public int deleteAnimalFull(int anino) {
		// 1. 신청내역 삭제
		dao.deleteApplicationsByAnimalNo(sqlSession, anino);

		// 2. 게시글 삭제
		dao.deletePost(sqlSession, anino);

		// 3. 동물 정보 삭제 (이 결과가 최종 성공 여부)
		return dao.deleteAnimal(sqlSession, anino);
	}

	// anino를 가지고 게시글 존재 여부(갯수) 가져오기
	@Override
	public int checkpost(int anino) {
		return dao.checkpost(sqlSession, anino);
	}

	// 관리자용 동물/게시글 전체 목록 가져오기 (페이징)
	@Override
	public List<AnimalDetailVO> managepost(AdoptionPageInfoVO pi, Map<String, Object> map) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return dao.managepost(sqlSession, rowBounds, map);
	}

	// userId를 가지고 등록한 동물 목록 가져오기 (페이징, 검색)
	@Override
	public List<AdoptionMainListVO> selectAnimalList1(String userId, AdoptionPageInfoVO pi, String keyword) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return dao.selectAnimalList1(sqlSession, userId, rowBounds, keyword);
	}

	// userId를 가지고 등록한 동물 수 세기 (검색)
	@Override
	public int myList1Count(String userId, String keyword) {
		return dao.myList1Count(sqlSession, userId, keyword);
	}

	// userId를 가지고 신청한 입양 목록 가져오기 (페이징)
	@Override
	public List<AdoptionApplicationVO> selectAnimalList2(String userId, AdoptionPageInfoVO pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return dao.selectAnimalList2(sqlSession, userId, rowBounds);
	}

	// userId를 가지고 신청한 입양 수 세기
	@Override
	public int myList2Count(String userId) {
		return dao.myList2Count(sqlSession, userId);
	}

	// anino를 가지고 게시글 삭제하기
	@Override
	public int deletePost(int anino) {
		return dao.deletePost(sqlSession, anino);
	}

	// anino를 가지고 관련 입양 신청 내역 전체 삭제하기
	@Override
	public int deleteApplicationsByAnimalNo(int anino) {
		return dao.deleteApplicationsByAnimalNo(sqlSession, anino);
	}

	// Map(animalNo, status)을 가지고 입양 상태 변경하기
	@Override
	public int updateAdoptionStatus(Map<String, Object> map) {
		return dao.updateAdoptionStatus(sqlSession, map);
	}

	// adoptionAppId를 가지고 신청서 정보 가져오기
	@Override
	public AdoptionApplicationVO selectApplication(int adoptionAppId) {
		return dao.selectApplication(sqlSession, adoptionAppId);
	}

	// adoptionAppId를 가지고 신청서 삭제하기
	@Override
	public int deleteapp(int adoptionAppId) {
		return dao.deleteapp(sqlSession, adoptionAppId);
	}

	// 입양 등록 반려하기
	@Override
	public int denyBoard(int anino) {
		return dao.denyBoard(sqlSession, anino);
	}

	// 입양 신청 중복 체크
	@Override
	public int checkApplication(int animalNo, String userId) {
		Map<String, Object> map = new HashMap<>();
		map.put("animalNo", animalNo);
		map.put("userId", userId);
		return dao.checkApplication(sqlSession, map);
	}

	// 관리자용 동물/게시글 전체 목록 갯수
	@Override
	public int managepostCount(Map<String, Object> map) {
		return dao.managepostCount(sqlSession, map);
	}

	// anino를 가지고 입양 신청을 수락하기(동물 디테일)
	@Override
	public int acceptAdoption(int anino) {
		return dao.acceptAdoption(sqlSession, anino);
	}

	// anino를 가지고 입양 신청을 수락하기(신청자 상태)
	@Override
	public int acceptAdoptionApp(int anino) {
		return dao.acceptAdoptionApp(sqlSession, anino);
	}

	// anino를 가지고 입양 신청을 거절하기
	@Override
	public int denyAdoption(int anino) {
		return dao.denyAdoption(sqlSession, anino);
	}

	// anino를 가지고 입양 신청을 거절하기(신청자 상태)
	@Override
	public int denyAdoptionApp(int anino) {
		return dao.denyAdoptionApp(sqlSession, anino);
	}

	@Override
	public List<AdoptionApplicationVO> getApplicantsList(int anino) {
		return dao.selectApplicantsByAnimalNo(sqlSession, anino);
	}

	@Override
	public int confirmAdoption(int adoptionAppId, int animalNo) {
		// 1. 해당 신청자 '입양완료(2)' 처리
		int result1 = dao.confirmApplication(sqlSession, adoptionAppId);

		// 2. 나머지 신청자 '반려(3)' 처리
		Map<String, Object> map = new HashMap<>();
		map.put("animalNo", animalNo);
		map.put("adoptionAppId", adoptionAppId);
		dao.rejectOtherApplications(sqlSession, map);

		// 3. 동물 상태 '입양완료' 처리
		int result3 = dao.acceptAdoption(sqlSession, animalNo);

		return (result1 > 0 && result3 > 0) ? 1 : 0;
	}
}
