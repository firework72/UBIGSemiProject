package com.ubig.app.community.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.community.service.CommunityService;
import com.ubig.app.vo.community.BoardVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    /*
     * [Step 5: Controller 수정]
     * 사용자 요청의 가장 앞단입니다.
     * "?category=NOTICE" 처럼 주소창에 달린 값을 받아서
     * Service에게 "NOTICE 글 목록 내놔"라고 시킵니다.
     * 만약 카테고리가 없으면 기본값으로 'NOTICE(공지)'를 봅니다.
     */
    @GetMapping("/list")
    public String list(Model model,
            @org.springframework.web.bind.annotation.RequestParam(value = "category", defaultValue = "NOTICE") String category) {

        // 1. Service를 통해 DB에서 글 목록을 가져옵니다.
        List<BoardVO> list = communityService.getBoardList(category);

        // 2. 화면(JSP)에 "list"라는 이름으로 보따리를 쌉니다.
        model.addAttribute("list", list);

        // 3. 현재 어떤 카테고리인지도 알려줍니다 (탭 활성화를 위해)
        model.addAttribute("category", category);

        return "community/list";
    }

    /*
     * [Step 9: 상세 조회 Controller]
     * 목록에서 제목을 클릭했을 때 이쪽으로 옵니다.
     * "몇 번 글 보여줘" (boardId) 라는 요청을 받아서
     * Service에게 "그 글 가져와" 시키고
     * detail.jsp에 던져줍니다.
     * 
     * [Step 19: 댓글 기능 추가]
     * 상세 내용을 보여줄 때 댓글 목록도 같이 가져와야 합니다.
     */
    @GetMapping("/detail")
    public String detail(int boardId, Model model, javax.servlet.http.HttpSession session) {
        // 1. 조회수 증가 (쿠키 등을 이용해 중복 방지 처리는 생략하고 단순 증가)
        communityService.increaseCount(boardId);

        // 2. 게시글 상세 조회
        com.ubig.app.vo.community.BoardVO board = communityService.getBoardDetail(boardId);

        // 3. 댓글 리스트 조회 (대댓글 포함 계층형)
        java.util.List<com.ubig.app.vo.community.CommentVO> commentList = communityService.getCommentList(boardId);

        // 4. 좋아요 정보 조회
        int likeCount = communityService.getLikeCount(boardId);
        boolean isLiked = false;

        com.ubig.app.vo.member.MemberVO loginUser = (com.ubig.app.vo.member.MemberVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            // 게시글 좋아요 여부 체크
            com.ubig.app.vo.community.BoardLikeVO like = new com.ubig.app.vo.community.BoardLikeVO();
            like.setBoardId(boardId);
            like.setUserId(loginUser.getUserId());
            int check = communityService.checkLike(like);
            if (check > 0)
                isLiked = true;

            // 댓글 좋아요 여부 체크 (N번 쿼리 발생하지만 일단 구현)
            for (com.ubig.app.vo.community.CommentVO c : commentList) {
                com.ubig.app.vo.community.CommentLikeVO clike = new com.ubig.app.vo.community.CommentLikeVO();
                clike.setCommentId(c.getCommentId());
                clike.setUserId(loginUser.getUserId());
                if (communityService.checkCommentLike(clike) > 0) {
                    c.setLiked(true); // VO에 setter 존재 (Lombok Data)
                }
            }
        }

        model.addAttribute("board", board);
        model.addAttribute("commentList", commentList);
        model.addAttribute("likeCount", likeCount);
        model.addAttribute("isLiked", isLiked);

        return "community/detail";
    }

    /*
     * [Step 19: 댓글 작성 Controller]
     */
    @org.springframework.web.bind.annotation.PostMapping("/insertComment")
    public String insertComment(com.ubig.app.vo.community.CommentVO comment, javax.servlet.http.HttpSession session) {

        // 로그인한 사용자 정보 가져오기
        com.ubig.app.vo.member.MemberVO loginUser = (com.ubig.app.vo.member.MemberVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            comment.setUserId(loginUser.getUserId()); // 작성자 ID 설정
        } else {
            // 로그인 안되어있으면 에러처리하거나 로그인페이지로 (여기선 간단히 리스트로)
            return "redirect:list";
        }

        communityService.insertComment(comment);

        // 댓글 작성 후 상세 페이지로 리다이렉트 (댓글 위치로 스크롤 이동)
        return "redirect:detail?boardId=" + comment.getBoardId() + "#comment-list";
    }

    /*
     * [Step 21: 댓글 삭제 Controller]
     */
    @GetMapping("/deleteComment")
    public String deleteComment(int commentId, int boardId) {
        communityService.deleteComment(commentId);
        return "redirect:detail?boardId=" + boardId + "#comment-list";
    }

    /*
     * [Step 22: 댓글 수정 Controller]
     */
    @org.springframework.web.bind.annotation.PostMapping("/updateComment")
    public String updateComment(int commentId, int boardId, String content) {
        com.ubig.app.vo.community.CommentVO comment = new com.ubig.app.vo.community.CommentVO();
        comment.setCommentId(commentId);
        comment.setContent(content);

        communityService.updateComment(comment);

        return "redirect:detail?boardId=" + boardId + "#comment-list";
    }

    /*
     * [Step 13: 글쓰기 화면 요청 Controller]
     * "글쓰기 버튼 눌렀어요, 종이 주세요"라는 요청입니다.
     * 단, 관리자(ADMIN)인지 검사를 해야 합니다.
     */
    @GetMapping("/write")
    public String writeForm(String category, Model model, javax.servlet.http.HttpSession session) {

        // 1. 로그인 유저 정보를 꺼냅니다.
        com.ubig.app.vo.member.MemberVO loginUser = (com.ubig.app.vo.member.MemberVO) session.getAttribute("loginUser");

        // 2. 관리자가 아니면 돌려보냅니다. (보안 강화)
        if (loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
            model.addAttribute("msg", "관리자만 작성할 수 있습니다.");
            model.addAttribute("url", "list?category=" + category);
            // 알림창 띄우고 이동하는 공통 페이지가 없으면 바로 리스트로 보냅니다.
            // return "common/alert";
            return "redirect:list?category=" + category;
        }

        model.addAttribute("category", category);
        return "community/write";
    }

    /*
     * [Step 14: 글 등록 요청 Controller]
     * "다 썼어요, 등록해주세요"라는 요청입니다.
     * 폼에서 날아온 데이터들이 BoardVO라는 상자에 예쁘게 담겨옵니다.
     */
    @org.springframework.web.bind.annotation.PostMapping("/write")
    public String write(BoardVO board) {

        // 1. Service에게 "이거 DB에 넣어줘"라고 시킵니다.
        int result = communityService.insertBoard(board);

        // 2. 성공 여부에 따라 다르게 반응합니다.
        if (result > 0) {
            // 성공하면 목록으로 돌아갑니다. (작성했던 카테고리 그대로)
            return "redirect:list?category=" + board.getCategory();
        } else {
            // 실패하면 에러 페이지로 가거나 다시 목록으로...
            return "redirect:list?category=" + board.getCategory(); // 임시 에러 처리
        }
    }

    /*
     * [Step 23: Summernote 이미지 업로드]
     * 에디터에서 이미지를 선택하면 이쪽으로 파일을 보내줍니다.
     * 서버에 파일을 저장하고, 그 파일에 접근할 수 있는 URL을 돌려줍니다.
     */
    @org.springframework.web.bind.annotation.PostMapping(value = "/uploadImage", produces = "application/json; charset=utf8")
    @org.springframework.web.bind.annotation.ResponseBody
    public String uploadImage(
            @org.springframework.web.bind.annotation.RequestParam("file") org.springframework.web.multipart.MultipartFile file,
            javax.servlet.http.HttpServletRequest request) throws java.io.IOException {

        // 1. 파일 저장 경로 설정 (webapp/resources/upload/community 폴더)
        String root = request.getSession().getServletContext().getRealPath("resources");
        String savePath = root + "//upload//community";

        // 폴더가 없으면 만들어줍니다.
        java.io.File folder = new java.io.File(savePath);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        // 2. 파일명 중복 방지를 위한 리네임 (UUID 사용)
        String originFileName = file.getOriginalFilename();
        String ext = originFileName.substring(originFileName.lastIndexOf("."));
        String changeName = java.util.UUID.randomUUID().toString() + ext;

        // 3. 파일 저장
        String renamePath = savePath + "//" + changeName;
        file.transferTo(new java.io.File(renamePath));

        // 4. 저장된 파일의 접근 URL 반환 (JSON 형식)
        // 예: {"url": "http://localhost:8080/app/resources/upload/community/파일명.jpg"}
        return "{\"url\":\"" + request.getContextPath() + "/resources/upload/community/" + changeName + "\"}";
    }

    /*
     * [Step 25: 댓글 좋아요 토글 Controller]
     */
    @GetMapping(value = "/comment/heart", produces = "application/json; charset=utf8")
    @org.springframework.web.bind.annotation.ResponseBody
    public String commentHeart(int commentId, javax.servlet.http.HttpSession session) {

        try {
            com.ubig.app.vo.member.MemberVO loginUser = (com.ubig.app.vo.member.MemberVO) session
                    .getAttribute("loginUser");
            if (loginUser == null) {
                return "{\"result\": \"login_required\"}";
            }

            com.ubig.app.vo.community.CommentLikeVO like = new com.ubig.app.vo.community.CommentLikeVO();
            like.setCommentId(commentId);
            like.setUserId(loginUser.getUserId());

            int status = communityService.toggleCommentLike(like); // 1: Like, 0: Unlike
            int count = communityService.getCommentLikeCount(commentId);

            return "{\"isLiked\":" + (status == 1) + ", \"count\":" + count + "}";
        } catch (Exception e) {
            e.printStackTrace(); // 서버 콘솔에 로그 출력
            String errorMessage = e.getMessage();
            if (errorMessage != null) {
                // 줄바꿈, 탭 등은 공백으로, 큰따옴표는 작은따옴표로, 백슬래시는 슬래시로 변경
                errorMessage = errorMessage.replaceAll("[\\r\\n\\t]", " ")
                        .replace("\"", "'")
                        .replace("\\", "/");
            } else {
                errorMessage = "Unknown Error";
            }
            return "{\"error\":\"" + errorMessage + "\"}";
        }
    }

    /*
     * [Step 24: 좋아요 토글 Controller]
     */
    @GetMapping(value = "/heart", produces = "application/json; charset=utf8")
    @org.springframework.web.bind.annotation.ResponseBody
    public String heart(int boardId, javax.servlet.http.HttpSession session) {

        try {
            com.ubig.app.vo.member.MemberVO loginUser = (com.ubig.app.vo.member.MemberVO) session
                    .getAttribute("loginUser");
            if (loginUser == null) {
                return "{\"result\": \"login_required\"}";
            }

            // Vo 객체에 담아서 서비스로 전달
            com.ubig.app.vo.community.BoardLikeVO like = new com.ubig.app.vo.community.BoardLikeVO();
            like.setBoardId(boardId);
            like.setUserId(loginUser.getUserId());

            int status = communityService.toggleLike(like); // 1: Like, 0: Unlike
            int count = communityService.getLikeCount(boardId);

            return "{\"isLiked\":" + (status == 1) + ", \"count\":" + count + "}";
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage();
            if (errorMessage != null) {
                // 줄바꿈, 탭 등은 공백으로, 큰따옴표는 작은따옴표로, 백슬래시는 슬래시로 변경
                errorMessage = errorMessage.replaceAll("[\\r\\n\\t]", " ")
                        .replace("\"", "'")
                        .replace("\\", "/");
            } else {
                errorMessage = "Unknown Error";
            }
            return "{\"error\":\"" + errorMessage + "\"}"; // 에러 메시지 반환
        }
    }

}
