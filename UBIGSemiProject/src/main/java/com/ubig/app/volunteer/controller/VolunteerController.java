package com.ubig.app.volunteer.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ubig.app.vo.volunteer.ActivityVO;
import com.ubig.app.volunteer.service.VolunteerService;

@Controller
public class VolunteerController {

	@Autowired
	private VolunteerService volunteerService;

	@RequestMapping("volunteerList.vo")
	public String volunteerList(Model model) {
		// [진단 1] 서비스 객체 확인
		if (volunteerService == null) {
			System.out.println("🚨 비상! volunteerService가 null입니다.");
			return "redirect:/";
		}

		// 2. 서비스 호출
		List<ActivityVO> list = volunteerService.selectActivityList();

		// [진단 2] 리스트 확인
		if (list == null) {
			System.out.println("🚨 비상! DB에서 가져온 list가 null입니다.");
		} else {
			System.out.println("3. 조회된 활동 개수 : " + list.size());
		}

		model.addAttribute("list", list);
		return "volunteer/volunteer";
	}

	// 3. 글쓰기 화면 이동
	@RequestMapping("volunteerWriteForm.vo")
	public String volunteerWriteForm() {
		return "volunteer/volunteerWriteForm";
	}

	// ==========================================================
	// 4. (진짜 기능) 사용자가 입력한 데이터 DB에 등록하기 (수정됨)
	// ==========================================================
	@RequestMapping("volunteerInsert.vo")
	public String volunteerInsert(ActivityVO a) {

		// 1. 참가비 고정
		a.setActMoney(10000); 

		// 2. [핵심] 주소가 있다면, REST API를 통해 좌표(위도/경도)를 구해옵니다.
		if (a.getActAddress() != null && !a.getActAddress().trim().isEmpty()) {
			
			System.out.println("📍 좌표 변환 요청 시작: " + a.getActAddress());
			
			// 아래에 있는 getKakaoCoordinates 메서드를 호출합니다.
			double[] coords = getKakaoCoordinates(a.getActAddress());
			
			// 좌표를 잘 구해왔다면 (0.0이 아니라면) VO에 넣어줍니다.
			if (coords[0] != 0.0 && coords[1] != 0.0) {
				a.setActLat(coords[0]); // 위도 (y)
				a.setActLon(coords[1]); // 경도 (x)
				System.out.println("✅ 좌표 세팅 완료 -> 위도: " + coords[0] + ", 경도: " + coords[1]);
			} else {
				System.out.println("⚠️ 좌표를 못 구했습니다. 기본값(0.0) 또는 지정된 기본 위치로 저장됩니다.");
				// 필요하다면 여기서 기본 좌표(서울시청 등)를 강제로 넣을 수도 있습니다.
				// a.setActLat(37.5665); a.setActLon(126.9780);
			}
		}

		// 3. 서비스 호출 (DB 저장)
		int result = volunteerService.insertActivity(a);

		if (result > 0) {
			System.out.println("✅ 게시글 등록 성공!");
		} else {
			System.out.println("❌ 게시글 등록 실패...");
		}

		return "redirect:volunteerList.vo";
	}

	// 5. 상세 페이지 조회
	@RequestMapping("volunteerDetail.vo")
	public String volunteerDetail(int actId, Model model) {
		ActivityVO vo = volunteerService.selectActivityOne(actId);
		model.addAttribute("vo", vo);
		return "volunteer/volunteerDetail";
	}
	
	// 6. 게시글 삭제 기능
	@RequestMapping("volunteerDelete.vo")
	public String volunteerDelete(int actId) {
		int result = volunteerService.deleteActivity(actId);
		if(result > 0) {
			System.out.println("✅ " + actId + "번 게시글 삭제 성공!");
		}
		return "redirect:volunteerList.vo";
	}
		
	// 7. 수정 페이지로 이동
	@RequestMapping("volunteerUpdateForm.vo")
	public String volunteerUpdateForm(int actId, Model model) {
		ActivityVO vo = volunteerService.selectActivityOne(actId);
		model.addAttribute("vo", vo);
		return "volunteer/volunteerUpdateForm";
	}
	
	// 8. 진짜 수정 기능
	@RequestMapping("volunteerUpdate.vo")
	public String volunteerUpdate(ActivityVO a) {
		
		// ★ 수정할 때도 주소가 바뀌었다면 좌표를 다시 구해야 할 수도 있습니다.
		// 필요하면 여기서도 getKakaoCoordinates(a.getActAddress())를 호출하면 됩니다.
		
		int result = volunteerService.updateActivity(a);
		if(result > 0) {
			System.out.println("✅ 수정 성공!");
		}
		return "redirect:volunteerDetail.vo?actId=" + a.getActId();
	}
	
	// ==========================================================
	// ▼▼▼ [서버 통신용] 카카오 REST API로 좌표 구하기 ▼▼▼
	// ==========================================================
	public double[] getKakaoCoordinates(String address) {
		
		// [중요] 여기에 아까 발급받은 'REST API 키'를 붙여넣으세요! (JavaScript 키 아님!)
		String apiKey = "9d3315583669ef22735fb1079ed997ff";
		
		String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json";
		double[] coords = new double[2]; // [0]:위도(y), [1]:경도(x)

		try {
			String encodedAddr = URLEncoder.encode(address, "UTF-8");
			URL url = new URL(apiUrl + "?query=" + encodedAddr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "KakaoAK " + apiKey); // 헤더 설정

			int responseCode = conn.getResponseCode();
			if (responseCode == 200) { // 성공
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				StringBuilder sb = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				br.close();

				// JSON 파싱
				JsonObject jsonObject = JsonParser.parseString(sb.toString()).getAsJsonObject();
				JsonArray documents = jsonObject.getAsJsonArray("documents");

				if (documents.size() > 0) {
					JsonObject doc = documents.get(0).getAsJsonObject();
					
					// x(경도), y(위도) 추출
					String x = doc.get("x").getAsString(); 
					String y = doc.get("y").getAsString(); 
					
					coords[0] = Double.parseDouble(y); // 위도
					coords[1] = Double.parseDouble(x); // 경도
					
					System.out.println("REST API 응답 -> 위도(y): " + y + ", 경도(x): " + x);
				} else {
					System.out.println("❌ REST API 응답: 검색된 주소 결과가 없습니다.");
				}
			} else {
				System.out.println("❌ 카카오 API 요청 실패. 응답 코드: " + responseCode);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("❌ 좌표 변환 중 에러 발생");
		}
		return coords;
	}

}