<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <c:if test="${empty sessionScope.loginMember}">
                <script>
                    alert("로그인이 필요한 서비스입니다.");
                    location.href = "${pageContext.request.contextPath}/user/login.me";
                </script>
            </c:if>

            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <title>유봉일공 - 마이페이지</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">

                <style>
                    body {
                        background-color: #f8f9fa;
                    }

                    .mypage-header {
                        background-color: #FFC107;
                        color: white;
                        padding: 40px 0;
                        margin-bottom: 30px;
                    }

                    .sidebar-menu .list-group-item {
                        border: none;
                        padding: 15px 20px;
                        font-weight: 500;
                        color: #495057;
                    }

                    .sidebar-menu .list-group-item.active {
                        background-color: #FFC107;
                        border-color: #FFC107;
                        color: white;
                        font-weight: bold;
                    }

                    .sidebar-menu .list-group-item:hover:not(.active) {
                        background-color: #ffeeba;
                        color: #212529;
                    }

                    .stat-card {
                        border-left: 5px solid #FFC107;
                        transition: transform 0.2s;
                    }

                    .stat-card:hover {
                        transform: translateY(-5px);
                    }

                    .readonly-input {
                        background-color: #e9ecef;
                        cursor: not-allowed;
                    }

                    .error-msg {
                        color: red;
                        font-size: 0.8rem;
                        display: none;
                    }

                    /* 입양 테이블 스타일 개선 */
                    #myadoption2 .table td,
                    #myadoption2 .table th {
                        vertical-align: middle;
                    }

                    /* 더 작은 버튼 스타일 정의 */
                    .btn-xs {
                        padding: 0.1rem 0.3rem;
                        font-size: 0.75rem;
                    }
                </style>
            </head>

            <body>

                <!-- adoption 알람 메시지 처리-->
                <c:if test="${not empty sessionScope.alertMsgAd}">
                    <script>
                        alert("${sessionScope.alertMsgAd}");
                    </script>
                    <c:remove var="alertMsgAd" scope="session" />
                </c:if>
                <%@ include file="/WEB-INF/views/common/menubar.jsp" %>
                    <div class="mypage-header text-center">
                        <div class="container">
                            <h2 class="fw-bold">MY PAGE</h2>
                            <p class="lead mb-0">안녕하세요, <strong>${loginMember.userNickname}</strong>님!</p>
                            <div class="mt-3">
                                <span class="badge bg-light text-dark fs-6 p-2">
                                    🐶 봉사활동 참여 횟수: <span
                                        class="text-danger fw-bold">${loginMember.userAttendedCount}</span>회
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="container pb-5">
                        <div class="row">

                            <div class="col-lg-3 mb-4">
                                <div class="card shadow-sm">
                                    <div class="card-header bg-white fw-bold py-3">
                                        마이 메뉴
                                    </div>
                                    <div class="list-group list-group-flush sidebar-menu" id="myMenu">
                                        <button id="myupdate" class="list-group-item list-group-item-action active">내
                                            정보 수정</button>
                                        <button id="myvolunteer" class="list-group-item list-group-item-action">봉사
                                            신청 내역</button>
                                        <button id="myadoption" class="list-group-item list-group-item-action">입양 신청
                                            내역</button>
                                        <!-- sun: 내가 쓴 글 버튼 클릭 시 AJAX로 데이터 요청 -->
                                        <button id="myboard" class="list-group-item list-group-item-action">내가 쓴
                                            글</button>
                                        <!-- Dong : 회원 탈퇴 처리 -->
                                        <form action="${pageContext.request.contextPath}/user/delete.me" method="post">
                                            <button id="delete"
                                                class="list-group-item list-group-item-action text-danger"
                                                onclick="return deleteMember();">회원 탈퇴</button>
                                        </form>

                                    </div>
                                </div>
                            </div>

                            <script>
                                //버튼 누른거만 보이게 하기 관련 메서드
                                document.addEventListener("DOMContentLoaded", function () {

                                    const update = document.querySelector("#myupdate");
                                    const myupdate2 = document.querySelector("#myupdate2");
                                    const myvolunteer2 = document.querySelector("#myvolunteer2");
                                    const myadoption2 = document.querySelector("#myadoption2");
                                    const myboard2 = document.querySelector("#myboard2"); // sun: myboard2 복원

                                    const list = [myupdate2, myvolunteer2, myadoption2, myboard2];

                                    const mymenu = document.querySelector("#myMenu");

                                    mymenu.addEventListener("click", function (e) {

                                        // sun: 내가 쓴 글 버튼 클릭 처리
                                        if (e.target.id === 'myboard') {
                                            // 탭 UI 활성화 (기존 로직과 동일)
                                            // 모두 숨기기
                                            list.forEach(el => el.style.display = "none");

                                            // myboard2 보이기
                                            myboard2.style.display = "block";

                                            // AJAX로 글 목록 가져오기
                                            getMyPosts();
                                        }
                                        else {
                                            // 기존 로직 (그대로 복원)
                                            // 모두 숨기기
                                            list.forEach(el => el.style.display = "none");

                                            // 선택된 콘텐츠 보이기
                                            const targetId = e.target.id + "2";
                                            const targetContent = document.querySelector("#" + targetId);
                                            if (targetContent) {
                                                targetContent.style.display = "block";
                                                getAdoptionData(currPage1, currPage2);
                                            }
                                        }

                                        // 버튼 활성화 스타일 처리
                                        const allButtons = mymenu.querySelectorAll('.list-group-item');
                                        allButtons.forEach(btn => btn.classList.remove('active'));

                                        // 클릭된 버튼에 active 추가
                                        e.target.classList.add('active');
                                    });

                                });
                                // 전역 변수로 현재 페이지 상태 관리
                                let currPage1 = 1;
                                let currPage2 = 1;

                                //입양 관련 내용 비동기통신
                                async function getAdoptionData(page1 = currPage1, page2 = currPage2) {

                                    // 상태 업데이트 (중요)
                                    currPage1 = page1;
                                    currPage2 = page2;

                                    // 검색어 가져오기
                                    const keyword = document.querySelector("#searchKeyword") ? document.querySelector("#searchKeyword").value : "";

                                    const url = '${pageContext.request.contextPath}/adoption.mypage';

                                    try {
                                        const response = await fetch(url, {
                                            method: 'POST', // 컨트롤러 설정에 따름
                                            headers: {
                                                "Content-Type": "application/json"
                                            },
                                            body: JSON.stringify({ page1, page2, keyword })
                                        });
                                        //객체로 파싱까지
                                        const ResultMap = await response.json();

                                        // 로그인 만료 체크
                                        if (ResultMap.error === "not_login") {
                                            alert(ResultMap.message);
                                            location.href = '${pageContext.request.contextPath}/user/login.me';
                                            return;
                                        }

                                        // 1. 내가 등록한 입양 내역 (myAdoptions) 처리
                                        const tbody1 = document.querySelector("#myadoption2 table:nth-of-type(1) tbody");
                                        tbody1.innerHTML = ""; // 기존 내용 초기화

                                        const myAdoptions = ResultMap.myAdoptions;
                                        if (myAdoptions && myAdoptions.length > 0) {
                                            let html = "";
                                            myAdoptions.forEach(item => {
                                                html += "<tr onclick='location.href=\"${pageContext.request.contextPath}/adoption.detailpage?anino=" + item.animalNo + "\"'>";
                                                html += "<td>" + item.animalNo + "</td>";
                                                html += "<td><img src='${pageContext.request.contextPath}/resources/download/adoption/" + item.photoUrl + "' style='width:50px; height:50px; object-fit:cover;'></td>";
                                                html += "<td>" + (item.animalName ? item.animalName : "-") + "</td>";
                                                // const formattedDate = item.postUpdateDate ? new Date(item.postUpdateDate).toLocaleDateString() : "-";
                                                // 등록일 (String으로 받아옴)
                                                const regDate = item.postRegDate ? item.postRegDate : "-";
                                                html += "<td>" + regDate + "</td>";
                                                // 게시글(post) 정보가 없으면 미승인, 있으면 승인/상태
                                                // postRegDate가 유효하면 게시글이 있는 것
                                                if (!item.postRegDate) {
                                                    html += "<td>미승인</td>";
                                                } else {
                                                    html += "<td>승인/" + item.adoptionStatus + "</td>";
                                                }
                                                html += "<td><button type='button' class='btn btn-secondary btn-xs' onclick='event.stopPropagation(); updateAdoption(" + item.animalNo + ")'>정보수정</button> ";
                                                html += "<button type='button' class='btn btn-secondary btn-xs' onclick='event.stopPropagation(); cancelAdoption(" + item.animalNo + ")'>등록취소</button></td>";
                                                if (item.adoptionStatus === "신청중") {
                                                    html += "<td><button type='button' class='btn btn-success btn-xs' onclick='event.stopPropagation();openApplicantModal(" + item.animalNo + ")'>수락</button> ";
                                                    html += "<button type='button' class='btn btn-danger btn-xs' onclick='event.stopPropagation();denyAdoption(" + item.animalNo + ")'>거절</button></td>";
                                                }
                                                html += "</tr>";
                                            });

                                            tbody1.innerHTML = html;

                                            // 페이징 1 (등록 동물)
                                            const pi1 = ResultMap.pi1;
                                            let p1Html = "";
                                            if (pi1) {
                                                if (pi1.currentPage > 1) {
                                                    p1Html += '<button type="button" class="btn btn-sm btn-outline-secondary mx-1" onclick="getAdoptionData(' + (pi1.currentPage - 1) + ', currPage2)">&lt;</button>';
                                                }
                                                for (let i = pi1.startPage; i <= pi1.endPage; i++) {
                                                    let active = (pi1.currentPage == i) ? "btn-secondary" : "btn-outline-secondary";
                                                    p1Html += '<button type="button" class="btn btn-sm ' + active + ' mx-1" onclick="getAdoptionData(' + i + ', currPage2)">' + i + '</button>';
                                                }
                                                if (pi1.currentPage < pi1.maxPage) {
                                                    p1Html += '<button type="button" class="btn btn-sm btn-outline-secondary mx-1" onclick="getAdoptionData(' + (pi1.currentPage + 1) + ', currPage2)">&gt;</button>';
                                                }
                                            }
                                            const area1 = document.querySelector("#pagingArea1");
                                            if (area1) area1.innerHTML = p1Html;
                                        } else {
                                            tbody1.innerHTML = "<tr><td colspan='4'>등록한 내역이 없습니다.</td></tr>";
                                        }

                                        // 2. 내가 신청한 입양 내역 (myApplications) 처리
                                        const tbody2 = document.querySelector("#myadoption2 table:nth-of-type(2) tbody");
                                        tbody2.innerHTML = ""; // 기존 내용 초기화

                                        const myApplications = ResultMap.myApplications;
                                        if (myApplications && myApplications.length > 0) {
                                            let html = "";
                                            myApplications.forEach(item => {
                                                html += "<tr onclick= 'location.href=\"${pageContext.request.contextPath}/adoption.detailpage?anino=" + item.animalNo + "\"' >";
                                                html += "<td>" + item.adoptionAppId + "</td>";
                                                html += "<td><img src='${pageContext.request.contextPath}/resources/download/adoption/" + item.photoUrl + "' style='width:50px; height:50px; object-fit:cover;'></td>";
                                                html += "<td>" + (item.animalName ? item.animalName : "-") + "</td>";
                                                html += "<td>" + (item.applyDateStr || "-") + "</td>";
                                                // 상태 코드(int)를 문자열로 변환
                                                let statusStr = "";
                                                switch (item.adoptStatus) {
                                                    case 1: statusStr = "신청완료"; break;
                                                    case 2: statusStr = "입양완료"; break;
                                                    case 3: statusStr = "반려"; break;
                                                    default: statusStr = "접수중";
                                                }
                                                html += "<td>" + statusStr + "</td>";
                                                html += "<td><button type='button' class='btn btn-danger btn-xs' onclick='cancelAdoptionApp(" + item.adoptionAppId + ")'>신청취소</button></td>";
                                                html += "</tr>";
                                            });
                                            tbody2.innerHTML = html;

                                            // 페이징 2 (입양 신청)
                                            const pi2 = ResultMap.pi2;
                                            let p2Html = "";
                                            if (pi2) {
                                                if (pi2.currentPage > 1) {
                                                    p2Html += '<button type="button" class="btn btn-sm btn-outline-secondary mx-1" onclick="getAdoptionData(currPage1, ' + (pi2.currentPage - 1) + ')">&lt;</button>';
                                                }
                                                for (let i = pi2.startPage; i <= pi2.endPage; i++) {
                                                    let active = (pi2.currentPage == i) ? "btn-secondary" : "btn-outline-secondary";
                                                    p2Html += '<button type="button" class="btn btn-sm ' + active + ' mx-1" onclick="getAdoptionData(currPage1, ' + i + ')">' + i + '</button>';
                                                }
                                                if (pi2.currentPage < pi2.maxPage) {
                                                    p2Html += '<button type="button" class="btn btn-sm btn-outline-secondary mx-1" onclick="getAdoptionData(currPage1, ' + (pi2.currentPage + 1) + ')">&gt;</button>';
                                                }
                                            }
                                            const area2 = document.querySelector("#pagingArea2");
                                            if (area2) area2.innerHTML = p2Html;
                                        } else {
                                            tbody2.innerHTML = "<tr><td colspan='4'>신청한 내역이 없습니다.</td></tr>";
                                            const area2 = document.querySelector("#pagingArea2");
                                            if (area2) area2.innerHTML = "";
                                        }

                                        return ResultMap;

                                    } catch (error) {
                                        console.error("Error:", error);
                                        alert("데이터를 불러오는 중 오류가 발생했습니다.\n" + error);
                                    }
                                }

                                //입양 관련 수정+삭제+수락 링크 함수들
                                function updateAdoption(animalNo) {
                                    location.href = '${pageContext.request.contextPath}/adoption.updateanimal?anino=' + animalNo;
                                }
                                function cancelAdoption(animalNo) {
                                    location.href = '${pageContext.request.contextPath}/adoption.deleteanimal?anino=' + animalNo;
                                }
                                function cancelAdoptionApp(adoptionAppId) {
                                    location.href = '${pageContext.request.contextPath}/adoption.deleteadoptionapp?adoptionAppId=' + adoptionAppId;
                                }
                                function acceptAdoption(animalNo) {
                                    location.href = '${pageContext.request.contextPath}/adoption.acceptadoptionapp?anino=' + animalNo;
                                }

                                async function openApplicantModal(animalNo) {
                                    try {
                                        // 1. Fetch를 사용하여 신청자 목록 가져오기
                                        const response = await fetch("${pageContext.request.contextPath}/adoption.applicants?anino=" + animalNo);

                                        if (!response.ok) {
                                            const text = await response.text();
                                            throw new Error(text);
                                        }

                                        const list = await response.json();

                                        // 에러 메시지 처리 (JSON 응답이지만 에러 문자열인 경우)
                                        if (typeof list === 'string') {
                                            if (list === "not_login") {
                                                alert("로그인이 필요합니다.");
                                                location.href = "${pageContext.request.contextPath}/user/login.me";
                                            } else if (list === "animal_not_found") {
                                                alert("동물 정보를 찾을 수 없습니다.");
                                            } else if (list === "permission_denied") {
                                                alert("권한이 없습니다.");
                                            } else if (list.startsWith("error_msg:")) {
                                                alert("서버 오류: " + list.substring(10));
                                            } else {
                                                alert("오류 발생: " + list);
                                            }
                                            return;
                                        }

                                        let html = "";
                                        if (list.length === 0) {
                                            html = "<tr><td colspan='4'>신청자가 없습니다.</td></tr>";
                                        } else {
                                            list.forEach(function (app) {
                                                html += "<tr>";
                                                html += "<td>" + app.adoptionAppId + "</td>";
                                                html += "<td>" + app.userId + " (" + (app.userName ? app.userName : "이름없음") + ")</td>";
                                                html += "<td>" + app.applyDateStr + "</td>";
                                                html += "<td><button type='button' class='btn btn-primary btn-sm' onclick='confirmAdoption(" + app.adoptionAppId + ", " + app.animalNo + ")'>선택</button></td>";
                                                html += "</tr>";
                                            });
                                        }
                                        document.querySelector("#applicantTableBody").innerHTML = html;

                                        // 모달 띄우기
                                        const modal = new bootstrap.Modal(document.getElementById('applicantModal'));
                                        modal.show();

                                    } catch (error) {
                                        console.error("Error details:", error);
                                        alert("신청자 목록을 불러오는 중 오류가 발생했습니다.\n" + error);
                                    }
                                }

                                async function confirmAdoption(appId, animalNo) {
                                    if (!confirm("이 신청자를 선택하시겠습니까?\n선택하면 다른 신청자는 모두 반려 처리됩니다.")) return;

                                    try {
                                        const response = await fetch("${pageContext.request.contextPath}/adoption.confirm?adoptionAppId=" + appId + "&anino=" + animalNo);

                                        if (!response.ok) {
                                            const text = await response.text();
                                            throw new Error(text);
                                        }

                                        const result = await response.json();

                                        if (result === "success") {
                                            alert("입양이 확정되었습니다.");
                                            location.reload();
                                        } else {
                                            alert("처리 실패: " + result);
                                        }

                                    } catch (error) {
                                        console.error("Error details:", error);
                                        alert("처리 실패: " + error);
                                    }
                                }

                                function denyAdoption(animalNo) {
                                    if (!confirm("정말 거절하시겠습니까?")) return;
                                    location.href = '${pageContext.request.contextPath}/adoption.denyadoptionapp?anino=' + animalNo;
                                }

                                // sun: 내 글 목록 가져오기 함수 (AJAX)
                                async function getMyPosts() {
                                    const url = '${pageContext.request.contextPath}/community/myPosts';
                                    const container = document.querySelector("#myboard2");

                                    try {
                                        const response = await fetch(url);
                                        const list = await response.json();

                                        if (!list || list.length === 0) {
                                            container.innerHTML = '<h4 class="mb-4 fw-bold border-bottom pb-2">내가 쓴 글</h4><div class="p-4 text-center">작성한 글이 없습니다.</div>';
                                            return;
                                        }

                                        let html = '<h4 class="mb-4 fw-bold border-bottom pb-2">내가 쓴 글</h4>';
                                        html += '<table class="table table-hover text-center">';
                                        html += '<thead class="table-light"><tr><th>번호</th><th>카테고리</th><th>제목</th><th>작성일</th><th>조회수</th></tr></thead>';
                                        html += '<tbody>';

                                        const catMap = {
                                            'NOTICE': '공지사항',
                                            'FREE': '자유게시판',
                                            'REVIEW': '봉사후기',
                                            'QNA': '문의사항'
                                        };

                                        list.forEach(board => {
                                            const catName = catMap[board.category] || board.category;
                                            html += '<tr onclick="location.href=\'${pageContext.request.contextPath}/community/detail?boardId=' + board.boardId + '\'" style="cursor:pointer;">';
                                            html += '<td>' + board.boardId + '</td>';
                                            html += '<td><span class="badge bg-secondary">' + catName + '</span></td>';
                                            html += '<td class="text-start text-truncate" style="max-width: 300px;">' + board.title + '</td>';
                                            html += '<td>' + board.createDate + '</td>';
                                            html += '<td>' + board.viewCount + '</td>';
                                            html += '</tr>';
                                        });

                                        html += '</tbody></table>';
                                        container.innerHTML = html;

                                    } catch (error) {
                                        console.error('Error fetching my posts:', error);
                                        container.innerHTML = '<h4 class="mb-4 fw-bold border-bottom pb-2">내가 쓴 글</h4><div class="alert alert-danger">데이터를 불러오는 중 오류가 발생했습니다.</div>';
                                    }
                                }


                            </script>


                            <div class="col-lg-9">
                                <div class="card shadow-sm">


                                    <div class="card-body p-4" id="myupdate2">
                                        <h4 class="mb-4 fw-bold border-bottom pb-2">내 정보 수정</h4>
                                        <form action="${pageContext.request.contextPath}/user/update.me" method="post"
                                            id="updateForm">
                                            <input type="hidden" name="userId" value="${loginMember.userId}">

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">아이디</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control readonly-input"
                                                        value="${loginMember.userId}" readonly>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">이름</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="userName"
                                                        id="userName" maxlength="10" value="${loginMember.userName}">
                                                    <div class="error-msg" id="userNameError">1~10자의 한글로 작성해주세요.</div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">닉네임</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="userNickname"
                                                        id="userNickname" maxlength="10"
                                                        value="${loginMember.userNickname}" required>
                                                    <div class="error-msg" id="userNicknameError">1~10자의 영문, 한글, 숫자로
                                                        작성해주세요.</div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">연락처</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="userContact"
                                                        id="userContact" maxlength="11"
                                                        value="${loginMember.userContact}" required>
                                                    <div class="error-msg" id="userContactError">숫자로만 11자리 작성해주세요.</div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">주소</label>
                                                <div class="col-sm-9">
                                                    <div class="input-group mb-2">
                                                        <input type="text" class="form-control" id="postcode"
                                                            placeholder="우편번호" readonly>
                                                        <button class="btn btn-outline-secondary" type="button"
                                                            onclick="execDaumPostcode()">주소 검색</button>
                                                    </div>
                                                    <input type="text" class="form-control mb-2" id="roadAddress"
                                                        placeholder="기본 주소" readonly>
                                                    <input type="text" class="form-control" id="detailAddress"
                                                        maxlength="20" placeholder="상세 주소를 입력해주세요">
                                                    <div class="error-msg" id="detailAddressError">1~20자의 한글, 숫자, 공백으로
                                                        작성해주세요.</div>

                                                    <input type="hidden" id="userAddress" name="userAddress"
                                                        value="${loginMember.userAddress}">

                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">성별</label>
                                                <div class="col-sm-9">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="userGender"
                                                            id="genderM" value="M" checked>
                                                        <label class="form-check-label" for="genderM">남성</label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="userGender"
                                                            id="genderF" value="F">
                                                        <label class="form-check-label" for="genderF">여성</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">가입일</label>
                                                <div class="col-sm-9">
                                                    <span class="form-control-plaintext">
                                                        <fmt:formatDate value="${loginMember.userEnrollDate}"
                                                            pattern="yyyy년 MM월 dd일" />
                                                    </span>
                                                </div>
                                            </div>

                                            <hr class="my-4">

                                            <div class="d-flex justify-content-between">
                                                <button type="button" class="btn btn-outline-dark"
                                                    data-bs-toggle="modal" data-bs-target="#pwdChangeModal">비밀번호
                                                    변경</button>
                                                <button type="submit" class="btn btn-warning fw-bold text-white px-4">정보
                                                    수정 저장</button>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="card-body p-4" style="display: none;" id="myvolunteer2">
                                        봉사 신청 내역
                                    </div>

                                    <div class="card-body p-4" style="display: none;" id="myadoption2">
                                        <h4> 입양 등록 내역 </h4>

                                        <!-- 검색 패널 추가 -->
                                        <div class="input-group mb-3" style="max-width: 300px;">
                                            <input type="text" id="searchKeyword" class="form-control"
                                                placeholder="동물 이름 검색">
                                            <button class="btn btn-outline-secondary" type="button"
                                                onclick="getAdoptionData(1, currPage2)">검색</button>
                                        </div>

                                        <table class="table table-bordered text-center">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>등록번호</th>
                                                    <th>사진</th>
                                                    <th>동물 이름</th>
                                                    <th>등록일</th>
                                                    <th>상태</th>
                                                    <th>정보 관리</th>
                                                    <th>입양 관리</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- 정보 들어오는 곳 -->
                                            </tbody>
                                        </table>
                                        <div id="pagingArea1" class="d-flex justify-content-center mt-3 gap-1"></div>

                                        <h4 class="mt-4"> 입양 신청 내역 </h4>
                                        <table class="table table-bordered text-center">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>신청번호</th>
                                                    <th>사진</th>
                                                    <th>동물 이름</th>
                                                    <th>신청일</th>
                                                    <th>신청 상태</th>
                                                    <th>설정</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- 정보 들어오는 곳 -->
                                            </tbody>
                                        </table>
                                        <div id="pagingArea2" class="d-flex justify-content-center mt-3 gap-1"></div>


                                    </div>

                                    <div class="card-body p-4" style="display: none;" id="myboard2">
                                        게시글 내역
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="modal fade" id="applicantModal" tabindex="-1">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title fw-bold">입양 신청자 목록</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <p class="text-muted small">입양을 확정할 신청자를 선택해주세요. 선택 시 다른 신청자는 자동 반려됩니다.</p>
                                    <table class="table table-hover text-center">
                                        <thead class="table-light">
                                            <tr>
                                                <th>신청번호</th>
                                                <th>신청자</th>
                                                <th>신청일</th>
                                                <th>선택</th>
                                            </tr>
                                        </thead>
                                        <tbody id="applicantTableBody">
                                            <!-- AJAX Load -->
                                        </tbody>
                                    </table>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="pwdChangeModal" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title fw-bold">비밀번호 변경</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="/member/updatePwd" method="post">
                                    <div class="modal-body">
                                        <input type="hidden" name="userId" value="${loginMember.userId}">
                                        <div class="mb-3">
                                            <label class="form-label">현재 비밀번호</label>
                                            <input type="password" class="form-control" name="currentPwd" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">새 비밀번호</label>
                                            <input type="password" class="form-control" name="newPwd" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">새 비밀번호 확인</label>
                                            <input type="password" class="form-control" name="newPwdConfirm" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">취소</button>
                                        <button type="submit" class="btn btn-warning text-white">변경하기</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                    <script>
                        // 정규표현식
                        let nameRegExr = /^[가-힣]{1,10}$/;
                        let nicknameRegExr = /^[a-zA-Z0-9가-힣]{1,10}$/;
                        let contactRegExr = /^[0-9]{11}$/;
                        let addressRegExr = /^[가-힣0-9\s]+$/;

                        // 0. 초기 로딩 시 남성/여성 체크
                        $(document).ready(function () {
                            let gender = '${loginMember.userGender}';
                            if (gender == 'M') {
                                $("#genderM").prop("check", true);
                            }
                            else {
                                $("#genderF").prop("check", true);
                            }
                        });

                        // 1. 초기 로딩 시 주소 분리
                        $(document).ready(function () {
                            var fullAddr = "${loginMember.userAddress}";
                            if (fullAddr) {
                                var addrParts = fullAddr.split(", ");
                                // 콤마로 단순 분리 (실제 데이터에 콤마가 더 있으면 로직 보강 필요)
                                if (addrParts.length >= 1) $("#roadAddress").val(addrParts[0]);
                                if (addrParts.length >= 2) $("#detailAddress").val(addrParts[1]);
                            }
                        });

                        // 2. 주소 API (회원가입과 동일)
                        function execDaumPostcode() {
                            new daum.Postcode({
                                oncomplete: function (data) {
                                    var roadAddr = data.roadAddress;
                                    document.getElementById('postcode').value = data.zonecode;
                                    document.getElementById("roadAddress").value = roadAddr;
                                    document.getElementById("detailAddress").focus();
                                }
                            }).open();
                        }

                        // 정규식 표현에 안 맞으면 차단

                        // 이름

                        $("#userName").on("keyup", function () {
                            var userName = $("#userName").val();

                            if (!nameRegExr.test(userName)) {
                                $("#userNameError").show();
                            } else {
                                $("#userNameError").hide();
                            }
                        });

                        // 닉네임

                        $("#userNickname").on("keyup", function () {
                            var userNickname = $("#userNickname").val();

                            if (!nicknameRegExr.test(userNickname)) {
                                $("#userNicknameError").show();
                            } else {
                                $("#userNicknameError").hide();
                            }
                        });

                        // 연락처

                        $("#userContact").on("keyup", function () {
                            var userContact = $("#userContact").val();

                            if (!contactRegExr.test(userContact)) {
                                $("#userContactError").show();
                            } else {
                                $("#userContactError").hide();
                            }
                        });

                        // 상세주소

                        $("#detailAddress").on("keyup", function () {
                            var detailAddress = $("#detailAddress").val();

                            if (!addressRegExr.test(detailAddress)) {
                                $("#detailAddressError").show();
                            } else {
                                $("#detailAddressError").hide();
                            }
                        });

                        // 3. 폼 제출 전 조건 확인
                        $("#updateForm").on("submit", function () {

                            let userName = $("#userName").val();
                            let userNickname = $("#userNickname").val();
                            let userContact = $("#userContact").val();
                            let detailAddress = $("#detailAddress").val();


                            if (!nameRegExr.test(userName)) {
                                alert("이름은 1~10글자 사이의 한글만 가능합니다.");
                                return false;
                            }

                            if (!nicknameRegExr.test(userNickname)) {
                                alert("닉네임은 1~10글자 사이의 영문, 한글, 숫자만 가능합니다.");
                                return false;
                            }

                            if (!contactRegExr.test(userContact)) {
                                alert("연락처는 11자리의 숫자만 가능합니다.");
                                return false;
                            }

                            if (!addressRegExr.test(detailAddress)) {
                                alert("상세주소는 한글, 숫자, 공백만 포함 가능합니다.");
                                return false;
                            }


                            var road = $("#roadAddress").val();
                            var detail = $("#detailAddress").val();

                            // 상세주소가 없어도 콤마 없이 기본주소만이라도 저장
                            var fullAddr = road;
                            if (detail) fullAddr += ", " + detail;

                            $("#userAddress").val(fullAddr);
                            return true;
                        });

                        // 4. 회원 탈퇴 함수
                        function deleteMember() {
                            return confirm("정말로 탈퇴하시겠습니까? 탈퇴 시 복구할 수 없습니다.");
                        }
                    </script>
            </body>

            </html>