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
	
	
	@RequestMapping("volunteerList.vo") // 주소는 원하시는 대로 (예: list.vo)
	public String volunteerList(Model model) {
		
		// 1. 서비스 호출해서 리스트 가져오기
		List<ActivitieVO> list = volunteerService.selectActivityList();
		
		// 2. 잘 가져왔는지 콘솔에 찍어보기 (테스트용)
		System.out.println("조회된 활동 개수 : " + list.size());
		
		// 3. 화면(JSP)으로 데이터 보내기
		model.addAttribute("list", list);
		
		// 4. JSP 페이지 포워딩 (views/volunteer/volunteer.jsp)
		return "volunteer/volunteer";
	}
	
	

}
