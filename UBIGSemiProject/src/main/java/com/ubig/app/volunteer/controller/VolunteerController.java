package com.ubig.app.volunteer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.vo.volunteer.ActivityVO;
import com.ubig.app.volunteer.service.VolunteerService;

@Controller
public class VolunteerController {

	@Autowired
	private VolunteerService volunteerService;

	@RequestMapping("volunteerList.vo")
	public String volunteerList(Model model) {

		// [진단 1] 서비스 객체가 잘 주입되었는지 확인
		System.out.println("=== 진단 시작 ===");
		System.out.println("1. volunteerService 객체 : " + volunteerService);

		if (volunteerService == null) {
			System.out.println("🚨 비상! volunteerService가 null입니다. @Autowired 실패!");
			return "redirect:/";
		}

		// 2. 서비스 호출
		List<ActivityVO> list = volunteerService.selectActivityList();

		// [진단 2] 리스트가 잘 왔는지 확인
		System.out.println("2. 조회된 list 객체 : " + list);

		if (list == null) {
			System.out.println("🚨 비상! DB에서 가져온 list가 null입니다. DAO/Mapper 확인 필요!");
		} else {
			System.out.println("3. 조회된 활동 개수 : " + list.size());
		}

		System.out.println("=== 진단 종료 ===");

		model.addAttribute("list", list);
		return "volunteer/volunteer";
	}

	// 2.테스트 종료

	// 3. 글쓰기 화면으로 단순히 이동만 하는 기능
	@RequestMapping("volunteerWriteForm.vo")
	public String volunteerWriteForm() {
		return "volunteer/volunteerWriteForm";
	}

	// 4. (진짜 기능) 사용자가 입력한 데이터 DB에 등록하기
	@RequestMapping("volunteerInsert.vo")
	public String volunteerInsert(ActivityVO a) {

		
		
		
		a.setActLat(37.5); // 위도: 서울 어딘가
		a.setActLon(127.0); // 경도: 서울 어딘가
		a.setActMoney(10000); // 참가비 : 고정 1만원

		// 서비스에게 "이 데이터 등록해줘!" 하고 시킵니다.
		int result = volunteerService.insertActivity(a);

		if (result > 0) {
			System.out.println("✅ 게시글 등록 성공!");
		} else {
			System.out.println("❌ 게시글 등록 실패...");
		}

		// 등록이 끝나면 다시 목록 페이지로 돌아갑니다.
		return "redirect:volunteerList.vo";
	}

	// 5. 상세 페이지 조회
	@RequestMapping("volunteerDetail.vo")
	public String volunteerDetail(int actId, Model model) {

		// DB에서 글 하나 꺼내오기
		ActivityVO vo = volunteerService.selectActivityOne(actId);

		// 화면에 "vo"라는 이름으로 데이터 보내기
		model.addAttribute("vo", vo);

		return "volunteer/volunteerDetail";
	}
	
	
	// 6. 게시글 삭제 기능, volunteerDetail.jsp에 삭제 진짜 하겠냐(체크기능)고 한 번더 물어보는 구문도 추가했음
		@RequestMapping("volunteerDelete.vo")
		public String volunteerDelete(int actId) {
			
			int result = volunteerService.deleteActivity(actId);
			
			if(result > 0) {
				System.out.println("✅ " + actId + "번 게시글 삭제 성공!");
			} else {
				System.out.println("❌ 삭제 실패...");
			}
			
			// 삭제 후에는 상세페이지가 없으니 목록으로 보냅니다.
			return "redirect:volunteerList.vo";
		}
		
		
		// 7. 수정 페이지로 이동 (기존 데이터를 가지고 감)
		@RequestMapping("volunteerUpdateForm.vo")
		public String volunteerUpdateForm(int actId, Model model) {
			
			// 기존 상세 조회 메서드(selectActivityOne)를 재활용해서 데이터를 가져오기
			ActivityVO vo = volunteerService.selectActivityOne(actId);
			
			model.addAttribute("vo", vo);
			
			return "volunteer/volunteerUpdateForm";
		}
		
		// 8. 진짜 수정 기능 (DB 업데이트)
		@RequestMapping("volunteerUpdate.vo")
		public String volunteerUpdate(ActivityVO a) {
			
			int result = volunteerService.updateActivity(a);
			
			if(result > 0) {
				System.out.println("✅ 수정 성공!");
			} else {
				System.out.println("❌ 수정 실패...");
			}
			
			// 수정이 끝나면 다시 '상세 페이지'로 돌아가서 바뀐 걸 확인시켜 줍니다.
			// 이때 actId를 꼭 같이 가져가야 에러가 안 납니다.
			return "redirect:volunteerDetail.vo?actId=" + a.getActId();
		}
		
		
		
		
		
		
	

}
