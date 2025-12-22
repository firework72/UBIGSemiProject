package com.ubig.app.adoption.service;

import java.util.ArrayList;

import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

public interface AdoptionService {
	// 관리자가 동물 등록하기//관리자가 동물 등록하기
	int insertAnimal(AnimalDetailVO animal);

	// 페이징용 게시글 갯수 알아오기
	int listCount();

	// 페이징 처리하고 보드리스트 가져오기 (통합 VO)
	ArrayList<AdoptionMainListVO> selectAdoptionMainList(AdoptionPageInfoVO pi);

	// 페이지 등록
	int insertBoard(AdoptionPostVO post);

	// 동물 디테일 페이지
	AnimalDetailVO goAdoptionDetail(int anino);
}
