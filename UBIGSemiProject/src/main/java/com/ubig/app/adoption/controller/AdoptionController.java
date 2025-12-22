package com.ubig.app.adoption.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ubig.app.adoption.common.AdoptionPagination;
import com.ubig.app.adoption.service.AdoptionService;
import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;

@Controller
public class AdoptionController {

	@Autowired
	AdoptionService service;

	// 입양 디테일페이지 이동
	@RequestMapping("/adoption.detailpage")
	public String goAdoptionDetail(int anino, Model model) {
		// animalNo를 가지고 해당 정보를 가지고 와서 디테일 페이지에서 보여주기
		AnimalDetailVO ani = service.goAdoptionDetail(anino);
		model.addAttribute("animal", ani);
		// 조회수 증가
		service.updateViewCount(anino);
		return "/adoption/adoptiondetailpage";
	}

	// 입양 등록 페이지 이동
	@RequestMapping("/adoption.enrollpage")
	public String goAdoptionInsertPage() {
		return "/adoption/adoptionenrollpage";
	}

	// 입양 신청 페이지 이동
	@RequestMapping("/adoption.applicationpage")
	public String goAdoptionApplicationPage(int anino) {
		return "/adoption/adoptionapplication";
	}

	// 게시글 등록
	@RequestMapping("/adoption.insert.board")
	public String insertBoard(AdoptionPostVO post, HttpSession session) {
		int result = service.insertBoard(post);
		if (result > 0) {
			session.setAttribute("alertMsgAd", "등록 성공");
		} else {
			session.setAttribute("alertMsgAd", "등록 실패");
		}
		return "redirect:/adoption.enrollpage";
	}

	// 입양 신청서 작성submit
	@RequestMapping("/adoption.insertapplication")
	public String insertapplication(AdoptionApplicationVO application, Model model, HttpSession session) {
		int result = service.insertApplication(application);
		model.addAttribute("anino", application.getAnimalNo());
		if (result > 0) {
			session.setAttribute("alertMsgAd", "입양 신청 성공");
		} else {
			session.setAttribute("alertMsgAd", "입양 신청 실패");
		}
		return "redirect:/adoption.detailpage";
	}

	// 동물 등록
	@RequestMapping("/adoption.insert.animal")
	public String insertAnimal(HttpSession session, MultipartFile uploadFile, AnimalDetailVO animal) {
		// 첨부파일 있는지 확인 로직
		if (uploadFile != null && !uploadFile.isEmpty()) {
			// 파일 저장 및 이름 변경
			String changeName = uploadFile(session, uploadFile);
			// DB 저장을위한 파일정보 갱신
			animal.setPhotoUrl(changeName);
			// service 호출(파일,내용 등록)
			int result = service.insertAnimal(animal);

			if (result > 0) {
				session.setAttribute("alertMsgAd", "동물 등록 성공!");
			} else {
				session.setAttribute("alertMsgAd", "동물 등록 실패!");
			}
		}
		return "redirect:/adoption.list";
	}

	// 동물파일 등록 전용 메서드
	public String uploadFile(HttpSession session, MultipartFile uploadFile) {
		// 저장경로 획득
		String savePath = session.getServletContext().getRealPath("resources/download/adoption/");
		// 원본 파일명 및 확장자 추출
		String originName = uploadFile.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf("."));
		// 리네임 규칙
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int) (Math.random() * 90000 + 10000);
		// 변경된 파일명 조합
		String changeName = currentTime + ranNum + ext;
		// 서버에 파일 저장
		try {
			uploadFile.transferTo(new File(savePath + changeName));
			return changeName;
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			return ""; // 수정 필요
		}

	}

	// 페이징 처리, 페이징 - 메인 페이지용 로직
	@RequestMapping("/adoption.mainpage")
	public String AdoptionList(@RequestParam(value = "page", defaultValue = "1") int currentPage, Model model) {
		// 리스트 갯수
		int listCount = service.listCount();
		// 현재 페이지 - 받아서 옴
		// 보드를 한 페이지에 몇개 보여줄지(**하드코딩 직접 설정 필요**)
		int boardLimit = 9;
		// 페이지를 한 페이지에 몇개 보여줄지(**하드코딩 직접 설정 필요**)
		int pageLimit = 2;

		AdoptionPageInfoVO pi = AdoptionPagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);

		// 페이징 처리 정보를 가지고 보여줄 보들을 리스트로 가져오기 (통합 VO 사용)
		ArrayList<AdoptionMainListVO> adoptionList = service.selectAdoptionMainList(pi);

		// 페이징 처리, 페이징용 리스트 model에 담기
		model.addAttribute("pi", pi);
		model.addAttribute("adoptionList", adoptionList);

		return "/adoption/adoptionmainpage";
	}

}
