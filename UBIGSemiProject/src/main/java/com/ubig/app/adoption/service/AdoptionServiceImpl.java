package com.ubig.app.adoption.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubig.app.adoption.dao.AdoptionDao;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

@Service
public class AdoptionServiceImpl implements AdoptionService {
	
	@Autowired
	AdoptionDao dao;
    @Autowired
    private SqlSessionTemplate sqlSession; 
    
    //관리자가 동물 등록하기
	@Override
	public int insertAnimal(AnimalDetailVO animal) {
		return dao.insertAnimal(sqlSession,animal);
	}

	//페이징용 게시글 갯수 알아오기
	@Override
	public int listCount() {
		return dao.listCount(sqlSession);
	}

	//페이징 처리 후 보드리스트로 가져오기
	@Override
	public ArrayList<AdoptionPostVO> boardList(AdoptionPageInfoVO pi) {

		return dao.boardList(sqlSession,pi);
	}

	//페이징 처리때 강아지들 사진 가져오기
	@Override
	public ArrayList<AnimalDetailVO> getPhoto(ArrayList<Integer> photo) {
		return dao.getPhoto(sqlSession,photo);
	}

	//보드 추가
	@Override
	public int insertBoard(AdoptionPostVO post) {
		return dao.insertBoard(sqlSession,post);
	}
	
	//동물 디테일 페이지용 객체 가져오기
	@Override
	public AnimalDetailVO goAdoptionDetail(int anino) {
		return dao.goAdoptionDetail(sqlSession, anino);
	}

}
