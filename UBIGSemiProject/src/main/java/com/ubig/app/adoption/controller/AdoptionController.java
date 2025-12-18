package com.ubig.app.adoption.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.adoption.service.AdoptionService;
import com.ubig.app.vo.adoption.AnimalDetailVO;

@Controller
public class AdoptionController {

	@Autowired
	AdoptionService service;
	
	//입양 메인페이지 호출
	@RequestMapping("/adoption.mainpage")
	public String goAdoptionMainPage() {
		return "/adoption/adoptionmainpage";
	}
	
	//입양 디테일페이지 이동
	@RequestMapping("/adoption.detailpage")
	public String goAdoptionList() {
		return "/adoption/adoptiondetailpage";
	}
	
	//입양 등록 페이지 이동
	@RequestMapping("/adoption.enrollpage")
	public String goAdoptionInsertPage() {
		return "/adoption/adoptionenrollpage";
	}
	
	//입양 신청 페이지 이동
	@RequestMapping("/adoption.applicationpage")
	public String goAdoptionApplicationPage() {
		return "/adoption/adoptionapplication";
	}
	
	//게시글 등록
	@RequestMapping("/adoption.insert.board")
	public String insertBoard() {
		//게시물 등록하면 해당 정보를 가지고 해당 디테일 페이지로 이동하기
		return "/adoption/adoptiondetailpage";
	}
	
	//동물 등록
	@RequestMapping("/adoption.insert.animal")
	public String insertAnimal(AnimalDetailVO animal) {
		//동물 등록하면 리스트 페이지로 이동하기
		int result = service.insertAnimal(animal);
		return"/adoption/adoptionmainpage";
	}
	
	
}
