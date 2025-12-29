package com.ubig.app.adoption.controller;

import java.util.List;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.ubig.app.adoption.common.AdoptionPagination;
import com.ubig.app.adoption.service.AdoptionService;
import com.ubig.app.vo.adoption.AdoptionApplicationVO;
import com.ubig.app.vo.adoption.AdoptionMainListVO;
import com.ubig.app.vo.adoption.AdoptionPageInfoVO;
import com.ubig.app.vo.adoption.AdoptionPostVO;
import com.ubig.app.vo.adoption.AdoptionSearchFilterVO;
import com.ubig.app.vo.adoption.AnimalDetailVO;
import com.ubig.app.vo.member.MemberVO;
import com.ubig.app.member.service.MessageService;

@Controller
public class AdoptionController {

	@Autowired
	AdoptionService service;

	@Autowired
	MessageService messageService;

	// anino를 가지고 입양 상세 페이지로 이동하기
	@RequestMapping("/adoption.detailpage")
	public String goAdoptionDetail(int anino, Model model) {
		AnimalDetailVO ani = service.goAdoptionDetail(anino);
		model.addAttribute("animal", ani);

		service.updateViewCount(anino);

		return "/adoption/adoptiondetailpage";
	}

	// 동물 등록 페이지로 이동하기
	@RequestMapping("/adoption.enrollpageanimal")
	public String goAdoptionInsertPage() {
		return "/adoption/adoptionenrollpageanimal";
	}

	// anino를 가지고 입양 신청 페이지로 이동하기
	@RequestMapping("/adoption.applicationpage")
	public String goAdoptionApplicationPage(int anino) {
		return "/adoption/adoptionapplication";
	}

	// anino를 가지고 입양 게시글 등록 페이지로 이동하기
	@RequestMapping("/adoption.enrollpagepost")
	public String goAdoptionEnrollPostPage(@RequestParam(value = "anino", required = false) Integer anino,
			Model model) {
		if (anino != null) {
			model.addAttribute("anino", anino);
		}
		return "/adoption/adoptionenrollpagepost";
	}

	// AdoptionPostVO를 가지고 게시글 등록하기
	@RequestMapping("/adoption.insert.board")
	public String insertBoard(AdoptionPostVO post, HttpSession session) {
		int result = service.insertBoard(post);
		if (result > 0) {
			session.setAttribute("alertMsgAd", "등록 성공");
		} else {
			session.setAttribute("alertMsgAd", "등록 실패");
		}
		return "redirect:/adoption.postmanage";
	}

	// anino를 가지고 게시글 즉시 등록하기 (제목 없음, 기본값 설정)
	@RequestMapping("/adoption.insert.board.direct")
	public String insertBoardDirect(int anino, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("loginMember");

		try {
			// 1. 동물 정보를 조회하여 실제 소유자(등록자)의 ID를 가져옴
			AnimalDetailVO animal = service.goAdoptionDetail(anino);
			System.out.println("[AdoptionController] insertBoardDirect 요청 - 동물: " + anino);

			if (animal == null) {
				session.setAttribute("alertMsgAd", "존재하지 않는 동물입니다.");
				return "redirect:/adoption.postmanage";
			}

			// 2. 이미 게시글이 등록되어 있는지 중복 체크
			int check = service.checkpost(anino);
			if (check > 0) {
				session.setAttribute("alertMsgAd", "이미 게시글이 등록된 동물입니다.");
				return "redirect:/adoption.postmanage";
			}

			// 3. 게시글 등록 진행
			AdoptionPostVO post = new AdoptionPostVO();
			post.setAnimalNo(anino);
			post.setUserId(animal.getUserId()); // 관리자가 아닌 동물 등록자의 ID로 설정
			post.setPostTitle("입양을 기다려요"); // 기본 제목 설정
			post.setViews(0);

			int result = service.insertBoard(post);

			if (result > 0) {
				session.setAttribute("alertMsgAd", "게시글이 등록되었습니다.");
			} else {
				session.setAttribute("alertMsgAd", "게시글 등록 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("alertMsgAd", "서버 오류로 인해 실패했습니다.");
		}

		return "redirect:/adoption.postmanage";
	}

	// AdoptionApplicationVO를 가지고 입양 신청서 제출 및 상태 변경하기
	@RequestMapping("/adoption.insertapplication")
	public String insertapplication(AdoptionApplicationVO application, Model model, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("loginMember");
		application.setUserId(user.getUserId());
		application.setAdoptStatus(1); // 1: 신청완료 상태로 초기화

		// 0.같은 동물에 대한 신청이 있는지 확인
		int check = service.checkApplication(application.getAnimalNo(), application.getUserId());

		// 0.내가 등록한 동물을 입양 신청하고 있지 않는지 확인
		AnimalDetailVO animal = service.goAdoptionDetail(application.getAnimalNo());
		if (animal != null && animal.getUserId().equals(user.getUserId())) {
			session.setAttribute("alertMsgAd", "본인이 등록한 동물에는 입양 신청을 할 수 없습니다.");
			return "redirect:/adoption.detailpage?anino=" + application.getAnimalNo();
		}

		if (check > 0) {
			session.setAttribute("alertMsgAd", "이미 입양 신청을 하셨습니다.");
			return "redirect:/adoption.detailpage?anino=" + application.getAnimalNo();
		}

		// 1. 신청서 저장
		int result = service.insertApplication(application);

		// 2. 신청 성공 시, 해당 동물의 상태를 '신청중'으로 업데이트
		if (result > 0) {
			Map<String, Object> map = new HashMap<>();
			map.put("animalNo", application.getAnimalNo());
			map.put("status", "신청중");
			service.updateAdoptionStatus(map);
		}

		model.addAttribute("anino", application.getAnimalNo());
		if (result > 0) {
			session.setAttribute("alertMsgAd", "입양 신청 성공");
		} else {
			session.setAttribute("alertMsgAd", "입양 신청 실패");
		}
		// 처리 후 상세 페이지로 다시 이동
		return "redirect:/adoption.detailpage?anino=" + application.getAnimalNo();
	}

	// AnimalDetailVO와 uploadFile을 가지고 동물 정보 등록하기
	@RequestMapping("/adoption.insert.animal")
	public String insertAnimal(HttpSession session, MultipartFile uploadFile, AnimalDetailVO animal) {

		MemberVO user = (MemberVO) session.getAttribute("loginMember");
		animal.setUserId(user.getUserId());

		// A. 기존 파일 정보가 있다면 삭제 (신규 등록에서는 발생 가능성 낮음)
		if (animal.getPhotoUrl() != null) {
			String savePath = session.getServletContext().getRealPath("resources/download/adoption/");
			File file = new File(savePath + animal.getPhotoUrl());
			if (file.exists()) {
				file.delete();
			}
		}

		// B. 신규 파일 업로드 처리
		if (uploadFile != null && !uploadFile.isEmpty()) {
			// 파일명 변경 및 저장
			String changeName = uploadFile(session, uploadFile);
			// VO에 변경된 파일명 설정
			animal.setPhotoUrl(changeName);

			// C. DB에 동물 정보 저장
			int result = service.insertAnimal(animal);

			if (result > 0) {
				session.setAttribute("alertMsgAd", "동물 등록 성공!");
			} else {
				session.setAttribute("alertMsgAd", "동물 등록 실패!");
			}
		}
		return "redirect:/adoption.mainpage";
	}

	// uploadFile을 가지고 파일 업로드 및 변경된 파일명 가져오기
	public String uploadFile(HttpSession session, MultipartFile uploadFile) {
		String savePath = session.getServletContext().getRealPath("resources/download/adoption/");
		String originName = uploadFile.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf("."));
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int) (Math.random() * 90000 + 10000);
		String changeName = currentTime + ranNum + ext;

		try {
			uploadFile.transferTo(new File(savePath + changeName));
			return changeName;
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			return "";
		}
	}

	// page를 가지고 메인 페이지 목록 조회하기 (필터 적용)
	@RequestMapping("/adoption.mainpage")
	public String AdoptionList(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			AdoptionSearchFilterVO filter, Model model) {

		System.out.println("Search Filter: " + filter);

		// 전체 게시글 수 조회 (필터 적용)
		int listCount = service.listCount(filter);

		int boardLimit = 9; // 한 페이지당 게시글 수
		int pageLimit = 5; // 페이지 번호 표시 수

		// 페이징 정보 생성
		AdoptionPageInfoVO pi = AdoptionPagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);

		// 페이징된 목록 조회 (필터 적용)
		List<AdoptionMainListVO> adoptionList = service.selectAdoptionMainList(pi, filter);

		model.addAttribute("pi", pi);
		model.addAttribute("adoptionList", adoptionList);
		model.addAttribute("filter", filter); // 필터 상태 유지

		return "/adoption/adoptionmainpage";
	}

	// anino를 가지고 동물 정보 수정 페이지로 이동하기
	@RequestMapping("/adoption.updateanimal")
	public String updateAnimal(int anino, Model model) {
		AnimalDetailVO animal = service.goAdoptionDetail(anino);
		model.addAttribute("animal", animal);
		return "/adoption/adoptionenrollpageanimal";
	}

	// AnimalDetailVO를 가지고 동물 정보 수정 및 게시글 삭제하기
	@RequestMapping("/adoption.update.animal.action")
	public String updateAnimalAction(HttpSession session, MultipartFile uploadFile, AnimalDetailVO animal,
			String originalPhotoUrl) {

		// 1. 파일 업로드 로직 (새 파일이 있으면 교체)
		String changeName = null;
		if (uploadFile != null && !uploadFile.isEmpty()) {
			changeName = uploadFile(session, uploadFile);
			animal.setPhotoUrl(changeName);

			if (originalPhotoUrl != null && !originalPhotoUrl.isEmpty()) {
				String savePath = session.getServletContext().getRealPath("resources/download/adoption/");
				File file = new File(savePath + originalPhotoUrl);
				if (file.exists()) {
					file.delete();
				}
			}
		} else {
			animal.setPhotoUrl(originalPhotoUrl);
		}

		// 2. 상태 초기화 ('대기중')
		animal.setAdoptionStatus("대기중");

		// 3. DB 업데이트
		int result = service.updateAnimal(animal);

		// 4. [중요] 관리자가 아닌 사용자가 수정했을 경우, 기존의 승인된 게시글 삭제 (재승인 필요)
		MemberVO user = (MemberVO) session.getAttribute("loginMember");
		if (user != null && !"ADMIN".equals(user.getUserRole())) {
			service.deletePost(animal.getAnimalNo());
		}

		if (result > 0) {
			session.setAttribute("alertMsgAd", "동물 정보가 성공적으로 수정되었습니다.");
		} else {
			session.setAttribute("alertMsgAd", "정보 수정 실패");
		}

		return "redirect:/user/mypage.me";
	}

	// anino를 가지고 동물 정보 및 관련 데이터 삭제하기
	@RequestMapping("/adoption.deleteanimal")
	public String deleteAnimal(int anino, HttpSession session, javax.servlet.http.HttpServletRequest request) {
		MemberVO user = (MemberVO) session.getAttribute("loginMember");
		String userRole = user.getUserRole();
		String userId = user.getUserId();

		// 관리자: 강제 삭제 (트랜잭션 적용)
		if ("ADMIN".equals(userRole)) {
			int result = service.deleteAnimalFull(anino);

			if (result > 0) {
				session.setAttribute("alertMsgAd", "관리자 권한으로 동물(및 관련 데이터) 삭제 성공");
			} else {
				session.setAttribute("alertMsgAd", "동물 삭제 실패");
			}
		}
		// 일반 유저: 본인 확인 (트랜잭션 적용)
		else if ("MEMBER".equals(userRole)) {
			AnimalDetailVO animal = service.goAdoptionDetail(anino);

			if (animal != null && userId.equals(animal.getUserId())) {
				int result = service.deleteAnimalFull(anino);

				if (result > 0) {
					session.setAttribute("alertMsgAd", "동물 삭제 성공");
				} else {
					session.setAttribute("alertMsgAd", "동물 삭제 실패");
				}
			} else {
				session.setAttribute("alertMsgAd", "본인이 등록한 동물만 삭제할 수 있습니다.");
			}
		} else {
			session.setAttribute("alertMsgAd", "적절한 권한이 없습니다.");
		}

		String referer = request.getHeader("Referer");
		return "redirect:" + (referer != null ? referer : "/adoption.mainpage");

	}

	// adoptionAppId를 가지고 신청 취소(삭제) 및 동물 상태 복구하기
	@RequestMapping("adoption.deleteadoptionapp")
	public String deleteadoptionapp(HttpSession session, int adoptionAppId) {

		// 1. 동물 번호 조회를 위해 신청 정보 확인
		AdoptionApplicationVO application = service.selectApplication(adoptionAppId);

		int result = 0;
		if (application != null) {
			int animalNo = application.getAnimalNo();

			// 2. 신청 내역 삭제
			result = service.deleteapp(adoptionAppId);

			if (result > 0) {
				// 3. 동물의 상태를 다시 '대기중'으로 변경 (입양 가능 상태로 복구)
				Map<String, Object> map = new HashMap<>();
				map.put("animalNo", animalNo);
				map.put("status", "대기중");
				service.updateAdoptionStatus(map);

				session.setAttribute("alertMsgAd", "삭제 성공 (대기중 상태로 변경됨)");
			} else {
				session.setAttribute("alertMsgAd", "삭제 실패");
			}
		} else {
			session.setAttribute("alertMsgAd", "존재하지 않는 신청 내역입니다.");
		}

		return "redirect:/user/mypage.me";
	}

	// 게시글 관리 페이지로 이동하기
	@RequestMapping("/adoption.postmanage")
	public String postManage(Model model,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam(value = "animalNo", required = false) String animalNo,
			@RequestParam(value = "onlyPending", required = false) String onlyPending) {

		Map<String, Object> map = new HashMap<>();
		if (animalNo != null && !animalNo.isEmpty()) {
			map.put("animalNo", animalNo);
		}
		if ("true".equals(onlyPending)) {
			map.put("onlyPending", "true");
		}

		// 1. 전체 관리 항목 수 조회
		int listCount = service.managepostCount(map);

		// 2. 페이징 처리 (pageLimit=5, boardLimit=10)
		int pageLimit = 5;
		int boardLimit = 10;
		AdoptionPageInfoVO pi = AdoptionPagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);

		// 3. 관리용 동물 전체 리스트 조회 (페이징 적용)
		List<AnimalDetailVO> list = service.managepost(pi, map);

		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("animalNo", animalNo);
		model.addAttribute("onlyPending", onlyPending);

		return "/adoption/adoptionpostmanage";
	}

	// userId를 가지고 마이페이지용 입양 데이터(JSON) 가져오기
	@ResponseBody
	@RequestMapping(value = "/adoption.mypage", produces = "application/json; charset=UTF-8")
	public String mypage(HttpSession session,
			@RequestBody(required = false) Map<String, String> body) { // required는 오류 완충장치

		int page1 = 1;
		int page2 = 1;

		String keyword = "";
		if (body != null) {
			if (body.get("page1") != null)
				page1 = Integer.parseInt(body.get("page1"));
			if (body.get("page2") != null)
				page2 = Integer.parseInt(body.get("page2"));
			if (body.get("keyword") != null) // keyword 추가
				keyword = body.get("keyword");
		}

		MemberVO user = (MemberVO) session.getAttribute("loginMember");

		// 세션 만료 시 처리
		if (user == null) {
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("error", "not_login");
			errorMap.put("message", "로그인이 필요한 서비스입니다.");
			return new Gson().toJson(errorMap);
		}

		int boardLimit = 5; // 한 페이지당 게시글 수
		int pageLimit = 5; // 페이지 번호 표시 수

		// 1. 유저가 등록한 동물 내역 (페이징 1) + 검색어 전달
		int listCount1 = service.myList1Count(user.getUserId(), keyword);
		AdoptionPageInfoVO pi1 = AdoptionPagination.getPageInfo(listCount1, page1, boardLimit, pageLimit);
		List<AdoptionMainListVO> list1 = service.selectAnimalList1(user.getUserId(), pi1, keyword);

		// 2. 유저가 신청한 입양 내역 (페이징 2)
		int listCount2 = service.myList2Count(user.getUserId());
		AdoptionPageInfoVO pi2 = AdoptionPagination.getPageInfo(listCount2, page2, boardLimit, pageLimit);
		List<AdoptionApplicationVO> list2 = service.selectAnimalList2(user.getUserId(), pi2);

		Map<String, Object> listAll = new HashMap<>();
		listAll.put("myAdoptions", list1);
		listAll.put("pi1", pi1);
		listAll.put("myApplications", list2);
		listAll.put("pi2", pi2);

		return new Gson().toJson(listAll);
	}

	// 게시글(입양 등록) 반려하기 animalNo를 가지고 동물 상태 "반려"로 만들기
	@RequestMapping("/adoption.deny.board.direct")
	public String denyBoard(int anino, HttpSession session) {
		int result = service.denyBoard(anino);
		return "redirect:/adoption.postmanage";
	}

	// 쪽지를 보내는 메서드
	// "**되었습니다." 하는 메시지와 USERID를 파라미터로 받아서 유저에게 쪽지 보내주기

}
