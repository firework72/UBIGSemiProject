package com.ubig.app.volunteer.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ubig.app.common.model.vo.PageInfo;
import com.ubig.app.common.util.Pagination;
import com.ubig.app.vo.member.MemberVO;
import com.ubig.app.vo.volunteer.ActivityVO;
import com.ubig.app.vo.volunteer.SignVO;
import com.ubig.app.vo.volunteer.VolunteerCommentVO;
import com.ubig.app.vo.volunteer.VolunteerReviewVO;
import com.ubig.app.volunteer.service.VolunteerService;

@Controller
public class VolunteerController {

	@Autowired
	private VolunteerService volunteerService;
	
	// ... 기존 volunteerList 메소드를 아래와 같이 통째로 교체 ...

		@RequestMapping("volunteerList.vo")
		public String volunteerList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
		                            @RequestParam(value="condition", required=false) String condition, 
		                            @RequestParam(value="keyword", required=false) String keyword, 
		                            Model model) {

			// 1. 검색 조건 설정
			java.util.HashMap<String, String> map = new java.util.HashMap<>();
			map.put("condition", condition);
			map.put("keyword", keyword);

			// 2. [페이징 처리]
			// 2-1. 전체 게시글 수 구하기
			int listCount = volunteerService.selectActivityCount(map);
			
			// 2-2. PageInfo 객체 생성 (Pagination 클래스 활용)
			// boardLimit: 10 (한 페이지에 10개씩), pageLimit: 5 (하단바에 5개씩)
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
			
			// 3. 목록 조회 (pi 객체 전달)
			List<ActivityVO> list = volunteerService.selectActivityList(map, pi);

			// 4. 화면 전송
			model.addAttribute("list", list);
			model.addAttribute("pi", pi); // [중요] 페이징 정보 보냄
	        model.addAttribute("condition", condition);
	        model.addAttribute("keyword", keyword);
	        
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

	// 5. 상세 페이지 조회 (수정됨: 후기 목록도 같이 가져오기)
		@RequestMapping("volunteerDetail.vo")
		public String volunteerDetail(int actId, Model model) {
			
	        // 1. 게시글 정보 가져오기
			ActivityVO vo = volunteerService.selectActivityOne(actId);
			

	        
	        // 3. 화면(JSP)으로 데이터 보내기
			model.addAttribute("vo", vo);

	        
			return "volunteer/volunteerDetail";
		}

	// 6. 게시글 삭제 기능
	@RequestMapping("volunteerDelete.vo")
	public String volunteerDelete(int actId) {
		int result = volunteerService.deleteActivity(actId);
		if (result > 0) {
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
		if (result > 0) {
			System.out.println("✅ 수정 성공!");
		}
		return "redirect:volunteerDetail.vo?actId=" + a.getActId();
	}

	// ==========================================================
	// ▼▼▼ [서버 통신용] 카카오 REST API로 좌표 구하기 ▼▼▼
	// ==========================================================
	public double[] getKakaoCoordinates(String address) {

		// [중요] 여기에 아까 발급받은 'REST API 키'를 붙여넣으세요! (JavaScript 키 아님!)
		String apiKey ="09064cf0dfb4fcc2d5ed48a0599f1de9";

		System.out.println(">>> 현재 적용된 API 키 확인: [" + apiKey + "]");
	    
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
		return coords;	}
	
	
	// ==========================================================
    // ▼▼▼ [후기(Review) 전용] 댓글 조회 & 등록 기능 ▼▼▼
    // ==========================================================

    // 1. 후기 댓글 목록 조회 (reviewReplyList.vo)
    @ResponseBody
    @RequestMapping(value = "reviewReplyList.vo", produces = "application/json; charset=UTF-8")
    public String reviewReplyList(int actId, int reviewNo) {
        // VO에 actId와 reviewNo를 담아서 서비스로 전달
        VolunteerCommentVO vo = new VolunteerCommentVO();
        vo.setActId(actId);
        vo.setReviewNo(reviewNo); // ★ 중요: 후기 번호 필수

        // 서비스 이름은 Cursor가 만든 것과 맞춰야 합니다. 
        // 만약 빨간줄이 뜨면 volunteerService 인터페이스도 확인해야 합니다.
        List<VolunteerCommentVO> list = volunteerService.selectReviewReplyList(vo);
        
        return new Gson().toJson(list);
    }

    // 2. 후기 댓글 등록 (reviewInsertReply.vo)
    @ResponseBody
    @RequestMapping("reviewInsertReply.vo")
    public String reviewInsertReply(VolunteerCommentVO r) {
        // 서비스 호출
        int result = volunteerService.insertReviewReply(r);
        return result > 0 ? "success" : "fail";
    }
	// 댓글 삭제 (공통)
	@ResponseBody
	@RequestMapping("deleteReply.vo")
	public String deleteReply(int cmtNo) {
		int result = volunteerService.deleteReply(cmtNo);
		return result > 0 ? "success" : "fail";
	}

	// ==========================================================
	// ▼▼▼ 신청 (Sign) 관련 기능 ▼▼▼
	// ==========================================================
	// 봉사 신청하기
    @RequestMapping("volunteerSign.vo")
    public String insertSign(SignVO s, HttpSession session) {
        
        // result 값: 1(성공), -1(정원초과), -2(중복신청), 0(에러)
        int result = volunteerService.insertSign(s);

        if (result > 0) {
            session.setAttribute("alertMsg", "✅ 봉사 신청이 완료되었습니다."); 
        } else if (result == -1) {
            session.setAttribute("alertMsg", "⚠️ 정원이 마감되어 신청할 수 없습니다.");
        } else if (result == -2) {
            // [핵심] 이 부분이 추가되어야 '중복 경고'가 뜹니다!
            session.setAttribute("alertMsg", "📢 이미 신청한 봉사활동입니다. (마이페이지를 확인하세요)");
        } else {
            session.setAttribute("alertMsg", "❌ 신청 실패...");
        }
        
        return "redirect:volunteerDetail.vo?actId=" + s.getActId();
    }
	// (관리자용) 신청자 목록 조회
	// [추가 사유] 관리자가 해당 봉사활동에 누가 신청했는지 현황을 파악하기 위해 목록을 조회함
	@RequestMapping("signList.vo")
	public String selectSignList(int actId, Model model) {
		List<SignVO> list = volunteerService.selectSignList(actId);
		model.addAttribute("signList", list);
		return "volunteer/signList"; // 별도 JSP 필요
	}

	// ==========================================================
		// ▼▼▼ 후기 (Review) 관련 기능 (권한 체크 및 경로 수정 완료) ▼▼▼
		// ==========================================================

		// 1. 전체 후기 목록 조회 (누구나 가능)
	// 1. 전체 후기 목록 조회 (페이징 적용)
		@RequestMapping("reviewList.vo")
		public String reviewList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
		                         @RequestParam(value="condition", required=false) String condition, 
		                         @RequestParam(value="keyword", required=false) String keyword, 
		                         Model model) {
			
			// 1. 검색 조건 설정
			java.util.HashMap<String, String> map = new java.util.HashMap<>();
			map.put("condition", condition);
			map.put("keyword", keyword);
			
			// 2. [페이징 처리]
			// 2-1. 전체 후기 갯수 구하기
			int listCount = volunteerService.selectReviewCount(map);
			
			// 2-2. PageInfo 객체 생성 (10개씩 보기, 하단바 5개)
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
			
			// 3. 목록 조회 (pi 전달)
			List<VolunteerReviewVO> list = volunteerService.selectReviewListAll(map, pi);
			
			// 4. 데이터 전달
			model.addAttribute("list", list);
			model.addAttribute("pi", pi); // 페이징 정보
			model.addAttribute("condition", condition); 
			model.addAttribute("keyword", keyword); 
			
			return "volunteer/reviewList";
		}

		// VolunteerController.java

		// 2. 후기 작성 페이지 이동 (관리자 전용)
		@RequestMapping("reviewWriteForm.vo")
		public String reviewWriteForm(HttpSession session, Model model) {
		    MemberVO loginUser = (MemberVO)session.getAttribute("loginMember");
		    
		    // 로그인 안했거나, ROLE이 ADMIN이 아니면 차단
		    if(loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
		        session.setAttribute("alertMsg", "관리자만 이용 가능한 메뉴입니다. ⛔");
		        return "redirect:reviewList.vo";
		    }

		    // [수정] 기존 selectActivityList 대신 -> selectActivityNoReview 호출!
		    // 이렇게 하면 이미 후기를 쓴 활동은 목록에서 아예 안 나옵니다.
		    List<ActivityVO> actList = volunteerService.selectActivityNoReview();
		    
		    model.addAttribute("actList", actList);
		    return "volunteer/reviewWriteForm";
		}

	
		
		// 4. 후기 상세 페이지 이동 (누구나 가능)
		@RequestMapping("reviewDetail.vo")
		public String reviewDetail(int reviewNo, Model model) {
			VolunteerReviewVO r = volunteerService.selectReviewOne(reviewNo);
			model.addAttribute("r", r);
			return "volunteer/reviewDetail";
		}

		// 5. 후기 수정 페이지 이동 (관리자 전용)
		@RequestMapping("reviewUpdateForm.vo")
		public String reviewUpdateForm(int reviewNo, HttpSession session, Model model) {
			MemberVO loginUser = (MemberVO)session.getAttribute("loginMember");
			if(loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
				session.setAttribute("alertMsg", "관리자만 수정 가능합니다.");
				return "redirect:reviewList.vo";
			}

			VolunteerReviewVO r = volunteerService.selectReviewOne(reviewNo);
			model.addAttribute("r", r);
			return "volunteer/reviewUpdateForm";
		}

		// 6. 후기 실제 수정 처리 (관리자 전용)
		@RequestMapping("updateReview.vo")
		public String updateReview(VolunteerReviewVO r, HttpSession session) {
			MemberVO loginUser = (MemberVO)session.getAttribute("loginMember");
			if(loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
				return "redirect:reviewList.vo";
			}

			int result = volunteerService.updateReview(r);
			if(result > 0) {
				session.setAttribute("alertMsg", "✅ 후기가 성공적으로 수정되었습니다.");
			} else {
				session.setAttribute("alertMsg", "❌ 수정 실패");
			}
			return "redirect:reviewDetail.vo?reviewNo=" + r.getReviewNo();
		}

		// 7. 후기 삭제 처리 (관리자 전용)
		@RequestMapping("deleteReview.vo")
		public String deleteReview(int reviewNo, HttpSession session) {
		    // 세션에서 로그인 정보 가져오기
		    MemberVO loginUser = (MemberVO)session.getAttribute("loginMember");

		    // [보안] 로그인이 안 되어 있거나, 권한이 ADMIN이 아니면 차단
		    if(loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
		        session.setAttribute("alertMsg", "삭제 권한이 없습니다. ⛔");
		        return "redirect:reviewList.vo";
		    }

		    // 관리자라면 무조건 삭제 진행
		    int result = volunteerService.deleteReview(reviewNo);
		    if(result > 0) {
		        session.setAttribute("alertMsg", "🗑️ 관리자 권한으로 후기가 삭제되었습니다.");
		    } else {
		        session.setAttribute("alertMsg", "❌ 삭제 실패");
		    }
		    return "redirect:reviewList.vo";
		}
		
		
		@RequestMapping("insertReview.vo")
		public String insertReview(VolunteerReviewVO r, HttpSession session) {
		    MemberVO loginUser = (MemberVO)session.getAttribute("loginMember");
		    
		    // 1. 관리자 권한 체크
		    if(loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
		        session.setAttribute("alertMsg", "권한이 없습니다.");
		        return "redirect:reviewList.vo";
		    }

		    // 2. 서비스 호출 (위에서 수정한 Service 메서드가 실행됨)
		    int result = volunteerService.insertReview(r);

		    // 3. 결과에 따른 메시지 처리
		    if (result == -2) {
		        // ★ [핵심] 중복일 때 뜨는 알림
		        session.setAttribute("alertMsg", "⚠️ 이미 후기가 등록된 봉사활동입니다.");
		        // 실패했으므로 작성 폼이나 목록으로 돌려보냄
		        return "redirect:reviewWriteForm.vo"; 
		    } else if (result > 0) {
		        session.setAttribute("alertMsg", "✅ 소중한 후기 등록이 완료되었습니다!");
		        return "redirect:reviewList.vo";
		    } else {
		        session.setAttribute("alertMsg", "❌ 후기 등록에 실패했습니다.");
		        return "redirect:reviewList.vo";
		    }
		}
		
	    // ==========================================================
	    // ▼ 관리자 승인/반려 & 사용자 취소 (AJAX) ▼
	    // ==========================================================

	    // 1. [관리자] 승인/반려 처리
	    @ResponseBody
	    @RequestMapping("updateSignStatusAdmin.vo")
	    public String updateSignStatusAdmin(int signsNo, String status) {
	        // 서비스 호출 (결과값: 1 성공, -1 정원초과, 0 실패)
	        int result = volunteerService.updateSignStatusAdmin(signsNo, status);
	        
	        if (result == 1) return "success";
	        else if (result == -1) return "full"; // 정원초과 메시지용
	        else return "fail";
	    }

	    // 2. [사용자] 봉사 취소 처리
	    @ResponseBody
	    @RequestMapping("updateSignStatusUser.vo")
	    public String updateSignStatusUser(int signsNo) {
	        int result = volunteerService.updateSignStatusUser(signsNo);
	        return result > 0 ? "success" : "fail";
	    }
		
		
		
		
		
}
