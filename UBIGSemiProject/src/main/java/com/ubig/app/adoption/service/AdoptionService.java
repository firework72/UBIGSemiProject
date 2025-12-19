package com.ubig.app.adoption.service;

import com.ubig.app.vo.adoption.AnimalDetailVO;

public interface AdoptionService {
	//관리자가 동물 등록하기//관리자가 동물 등록하기
	int insertAnimal(AnimalDetailVO animal);

	//페이징용 게시글 갯수 알아오기
	int listCount();

}
