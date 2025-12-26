package com.ubig.app.adoption.service;

import java.util.List;
import java.util.Map;

import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

public interface AdoptionService {

	// AnimalDetailVO를 가지고 동물 정보 등록하기
	int insertAnimal(AnimalDetailVO animal);

	// AnimalDetailVO를 가지고 동물 정보 수정하기
	int updateAnimal(AnimalDetailVO animal);

	// 게시글 전체 갯수 가져오기
	int listCount();

	// PageInfo를 가지고 메인 페이지 게시글 목록 가져오기
	List<AdoptionMainListVO> selectAdoptionMainList(AdoptionPageInfoVO pi);

	// AdoptionPostVO를 가지고 게시글 등록하기
	int insertBoard(AdoptionPostVO post);

	// anino를 가지고 동물 상세 정보 가져오기
	AnimalDetailVO goAdoptionDetail(int anino);

	// AdoptionApplicationVO를 가지고 입양 신청서 등록하기
	int insertApplication(AdoptionApplicationVO application);

	// animalNo를 가지고 조회수 증가시키기
	int updateViewCount(int animalNo);

	// anino를 가지고 동물 정보 삭제하기
	int deleteAnimal(int anino);

	// anino를 가지고 게시글 존재 여부(갯수) 가져오기
	int checkpost(int anino);

	// 관리자용 동물/게시글 전체 목록 가져오기
	List<AnimalDetailVO> managepost();

	// userId를 가지고 등록한 동물 목록 가져오기 (페이징)
	List<AdoptionMainListVO> selectAnimalList1(String userId, AdoptionPageInfoVO pi);

	// userId를 가지고 등록한 동물 수 세기
	int myList1Count(String userId);

	// userId를 가지고 신청한 입양 목록 가져오기
	List<AdoptionApplicationVO> selectAnimalList2(String userId, AdoptionPageInfoVO pi);

	// userId를 가지고 신청한 입양 수 세기
	int myList2Count(String userId);

	// anino를 가지고 게시글 삭제하기
	int deletePost(int anino);

	// anino를 가지고 관련 입양 신청 내역 전체 삭제하기
	int deleteApplicationsByAnimalNo(int anino);

	// Map(animalNo, status)을 가지고 입양 상태 변경하기
	int updateAdoptionStatus(Map<String, Object> map);

	// adoptionAppId를 가지고 신청서 정보 가져오기
	AdoptionApplicationVO selectApplication(int adoptionAppId);

	// adoptionAppId를 가지고 신청서 삭제하기
	int deleteapp(int adoptionAppId);

	// 입양 등록 반려하기
	int denyBoard(int anino);

	// 입양 중복 체크
	int checkApplication(int animalNo, String userId);

}
