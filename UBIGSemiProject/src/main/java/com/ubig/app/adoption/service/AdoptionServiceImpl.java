package com.ubig.app.adoption.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.adoption.dao.AdoptionDao;
import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

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

	// 게시글 전체 갯수 가져오기
	@Override
	public int listCount() {
		return dao.listCount(sqlSession);
	}

	// PageInfo를 가지고 메인 페이지 게시글 목록 가져오기
	@Override
	public List<AdoptionMainListVO> selectAdoptionMainList(AdoptionPageInfoVO pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return dao.selectAdoptionMainList(sqlSession, pi, rowBounds);
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

	// anino를 가지고 게시글 존재 여부(갯수) 가져오기
	@Override
	public int checkpost(int anino) {
		return dao.checkpost(sqlSession, anino);
	}

	// 관리자용 동물/게시글 전체 목록 가져오기
	@Override
	public List<AnimalDetailVO> managepost() {
		return dao.managepost(sqlSession);
	}

	// userId를 가지고 등록한 동물 목록 가져오기 (페이징)
	@Override
	public List<AdoptionMainListVO> selectAnimalList1(String userId, AdoptionPageInfoVO pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return dao.selectAnimalList1(sqlSession, userId, rowBounds);
	}

	// userId를 가지고 등록한 동물 수 세기
	@Override
	public int myList1Count(String userId) {
		return dao.myList1Count(sqlSession, userId);
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

}
