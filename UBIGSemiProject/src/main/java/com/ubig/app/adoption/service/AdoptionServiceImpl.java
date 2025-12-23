package com.ubig.app.adoption.service;

import java.util.ArrayList;

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

	// 관리자가 동물 등록하기
	@Override
	public int insertAnimal(AnimalDetailVO animal) {
		return dao.insertAnimal(sqlSession, animal);
	}

	// 유저가 동물 수정하기
	@Override
	public int updateAnimal(AnimalDetailVO animal) {
		return dao.updateAnimal(sqlSession, animal);
	}

	// 페이징용 게시글 갯수 알아오기
	@Override
	public int listCount() {
		return dao.listCount(sqlSession);
	}

	// 페이징 처리 후 보드리스트로 가져오기
	@Override
	public ArrayList<AdoptionMainListVO> selectAdoptionMainList(AdoptionPageInfoVO pi) {

		return dao.selectAdoptionMainList(sqlSession, pi);
	}

	// 보드 추가
	@Override
	public int insertBoard(AdoptionPostVO post) {
		return dao.insertBoard(sqlSession, post);
	}

	// 동물 디테일 페이지용 객체 가져오기
	@Override
	public AnimalDetailVO goAdoptionDetail(int anino) {
		return dao.goAdoptionDetail(sqlSession, anino);
	}

	// 입양 신청 등록
	@Override
	public int insertApplication(AdoptionApplicationVO application) {
		int result = dao.insertApplication(sqlSession, application);

		if (result > 0) {
			// 신청 성공 시 해당 동물의 입양 상태를 '신청중'으로 변경
			dao.updateAdoptionStatus(sqlSession, application.getAnimalNo(), "신청중");
		}

		return result;
	}

	// 조회수 증가 로직
	@Override
	public int updateViewCount(int animalNo) {
		return dao.updateViewCount(sqlSession, animalNo);
	}

	// 동물 정보 삭제
	@Override
	public int deleteAnimal(int anino) {
		return dao.deleteAnimal(sqlSession, anino);
	}

	// anino로 post 유무 조회
	@Override
	public int checkpost(int anino) {
		return dao.checkpost(sqlSession, anino);
	}

	// 모든 게시물 정보 받아오기(관리자 관리용)
	@Override
	public ArrayList<AnimalDetailVO> managepost() {
		return dao.managepost(sqlSession);
	}

	// user가 올린 입양 등록 정보 가지고 오기
	@Override
	public ArrayList<AdoptionMainListVO> selectAnimalList1(String userId) {
		return dao.selectAnimalList1(sqlSession, userId);
	}

	// user가 신청한 입양 등록정보 가지고 오기
	@Override
	public ArrayList<AdoptionApplicationVO> selectAnimalList2(String userId) {
		return dao.selectAnimalList2(sqlSession, userId);
	}

}
