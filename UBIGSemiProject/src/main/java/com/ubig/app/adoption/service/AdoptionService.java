package com.ubig.app.adoption.service;

import java.util.ArrayList;

import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

public interface AdoptionService {
	// 유저가 동물 등록하기
	int insertAnimal(AnimalDetailVO animal);

	// 유저가 동물 수정하기
	int updateAnimal(AnimalDetailVO animal);

	// 페이징용 게시글 갯수 알아오기
	int listCount();

	// 페이징 처리하고 보드리스트 가져오기 (통합 VO)
	ArrayList<AdoptionMainListVO> selectAdoptionMainList(AdoptionPageInfoVO pi);

	// (관리자 권한)페이지 등록
	int insertBoard(AdoptionPostVO post);

	// 동물 디테일 페이지
	AnimalDetailVO goAdoptionDetail(int anino);

	// 입양 신청 등록
	int insertApplication(AdoptionApplicationVO application);

	// 조회수 증가
	int updateViewCount(int animalNo);

	// 동물 정보 삭제
	int deleteAnimal(int anino);

	// 해당 동물no를 포함하는 post 조회하기
	int checkpost(int anino);

	// 모든 게시글들의 정보를 받아오는 메서드
	ArrayList<AnimalDetailVO> managepost();

	// user가 올린 입양 등록 정보 가지고 오기
	ArrayList<AdoptionMainListVO> selectAnimalList1(String userId);

	// user가 신청한 입양 등록정보 가지고 오기
	ArrayList<AdoptionApplicationVO> selectAnimalList2(String userId);

}
