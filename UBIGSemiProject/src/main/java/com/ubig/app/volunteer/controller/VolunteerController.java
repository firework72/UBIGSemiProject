package com.ubig.app.volunteer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.vo.volunteer.ActivitieVO;
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
		List<ActivitieVO> list = volunteerService.selectActivityList();

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
	public String volunteerInsert(ActivitieVO a) {

		// 폼에서 넘어오지 않은 나머지 데이터들은 여기서 기본값으로 채워줍니다.
		// (나중에는 달력 API나 지도 API로 받겠지만, 지금은 에러 방지용 임시값입니다)
		a.setActDate(new java.util.Date()); // 시작일: 오늘
		a.setActEnd(new java.util.Date()); // 종료일: 오늘
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
		ActivitieVO vo = volunteerService.selectActivityOne(actId);

		// 화면에 "vo"라는 이름으로 데이터 보내기
		model.addAttribute("vo", vo);

		return "volunteer/volunteerDetail";
	}

}
