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
                                        <button id="myboard" class="list-group-item list-group-item-action">내가 쓴
                                            글</button>
                                        <button id="delete" class="list-group-item list-group-item-action text-danger"
                                            onclick="deleteMember()">회원 탈퇴</button>
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
                                    const myboard2 = document.querySelector("#myboard2");

                                    const list = [myupdate2, myvolunteer2, myadoption2, myboard2];

                                    const mymenu = document.querySelector("#myMenu");

                                    mymenu.addEventListener("click", function (e) {

                                        // 모두 숨기기
                                        list.forEach(el => el.style.display = "none");

                                        // 선택된 콘텐츠 보이기
                                        const targetId = e.target.id + "2";
                                        const targetContent = document.querySelector("#" + targetId);
                                        if (targetContent) {
                                            targetContent.style.display = "block";
                                            getAdoptionData();
                                        }

                                        // 버튼 활성화 스타일 처리
                                        // 모든 버튼에서 active 제거
                                        const allButtons = mymenu.querySelectorAll('.list-group-item');
                                        allButtons.forEach(btn => btn.classList.remove('active'));

                                        // 클릭된 버튼에 active 추가
                                        e.target.classList.add('active');
                                    });




                                });
                                //입양 관련 내용 비동기 통신
                                async function getAdoptionData(url = '${pageContext.request.contextPath}/adoption.mypage', data = {}, method = 'POST') {

                                    const response = await fetch(url, {
                                        method: 'POST',
                                        headers: {
                                            "Content-type": "application/json"
                                        },
                                        body: JSON.stringify(data)
                                    });
                                    //객체로 파싱까지
                                    const ResultMap = await response.json();

                                    // 1. 내가 등록한 입양 내역 (myAdoptions) 처리
                                    const tbody1 = document.querySelector("#myadoption2 table:nth-of-type(1) tbody");
                                    tbody1.innerHTML = ""; // 기존 내용 초기화

                                    const myAdoptions = ResultMap.myAdoptions;
                                    if (myAdoptions && myAdoptions.length > 0) {
                                        let html = "";
                                        myAdoptions.forEach(item => {
                                            html += "<tr>";
                                            html += "<td>" + item.animalNo + "</td>";
                                            html += "<td><img src='${pageContext.request.contextPath}/resources/download/adoption/" + item.photoUrl + "' style='width:50px; height:50px; object-fit:cover;'></td>";
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
                                            html += "<td><button type='button' class='btn btn-danger btn-sm' onclick='updateAdoption(" + item.animalNo + ")'>정보수정</button>  ";
                                            html += "<button type='button' class='btn btn-danger btn-sm' onclick='cancelAdoption(" + item.animalNo + ")'>등록취소</button></td>";
                                            html += "</tr>";
                                        });
                                        tbody1.innerHTML = html;
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
                                            html += "<tr>";
                                            html += "<td>" + item.adoptionAppId + "</td>";
                                            html += "<td><img src='${pageContext.request.contextPath}/resources/download/adoption/" + item.photoUrl + "' style='width:50px; height:50px; object-fit:cover;'></td>";
                                            html += "<td>" + (item.applyDateStr || "-") + "</td>";
                                            // 상태 코드(int)를 문자열로 변환
                                            let statusStr = "";
                                            switch (item.adoptStatus) {
                                                case 1: statusStr = "신청완료"; break;
                                                case 2: statusStr = "심사중"; break;
                                                case 3: statusStr = "승인"; break;
                                                case 4: statusStr = "거절"; break;
                                                default: statusStr = "접수중";
                                            }
                                            html += "<td>" + statusStr + "</td>";
                                            html += "<td><button type='button' class='btn btn-danger btn-sm' onclick='cancelAdoptionApp(" + item.adoptionAppId + ")'>신청취소</button></td>";
                                            html += "</tr>";
                                        });
                                        tbody2.innerHTML = html;
                                    } else {
                                        tbody2.innerHTML = "<tr><td colspan='4'>신청한 내역이 없습니다.</td></tr>";
                                    }

                                    return ResultMap;
                                }

                                //입양 관련 수정+삭제 링크 함수들
                                function updateAdoption(animalNo) {
                                    location.href = '${pageContext.request.contextPath}/adoption.updateanimal?anino=' + animalNo;
                                }
                                function cancelAdoption(animalNo) {
                                    location.href = '${pageContext.request.contextPath}/adoption.deleteanimal?anino=' + animalNo;
                                }
                                function cancelAdoptionApp(adoptionAppId) {
                                    location.href = '${pageContext.request.contextPath}/adoption.deleteadoptionapp?adoptionAppId=' + adoptionAppId;
                                }


                            </script>


                            <div class="col-lg-9">
                                <div class="card shadow-sm">


                                    <div class="card-body p-4" id="myupdate2">
                                        <h4 class="mb-4 fw-bold border-bottom pb-2">내 정보 수정</h4>
                                        <form action="/member/update" method="post" id="updateForm">
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
                                                    <input type="text" class="form-control readonly-input"
                                                        value="${loginMember.userName}" readonly>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">닉네임</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="userNickname"
                                                        value="${loginMember.userNickname}" required>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-3 col-form-label fw-bold">연락처</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="userContact"
                                                        value="${loginMember.userContact}" required>
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
                                                        placeholder="상세 주소를 입력해주세요">

                                                    <input type="hidden" id="userAddress" name="userAddress"
                                                        value="${loginMember.userAddress}">
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
                                        <table class="table table-bordered text-center">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>등록번호</th>
                                                    <th>사진</th>
                                                    <th>등록일</th>
                                                    <th>상태</th>
                                                    <th>설정</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- 정보 들어오는 곳 -->
                                            </tbody>
                                        </table>

                                        <h4 class="mt-4"> 입양 신청 내역 </h4>
                                        <table class="table table-bordered text-center">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>신청번호</th>
                                                    <th>사진</th>
                                                    <th>신청일</th>
                                                    <th>신청 상태</th>
                                                    <th>설정</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- 정보 들어오는 곳 -->
                                            </tbody>
                                        </table>


                                    </div>

                                    <div class="card-body p-4" style="display: none;" id="myboard2">
                                        게시글 내역
                                    </div>


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
                        // 1. 초기 로딩 시 주소 분리 (단순 예시)
                        // DB에 "도로명주소, 상세주소"로 저장되어 있다고 가정
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

                        // 3. 폼 제출 전 주소 합치기
                        $("#updateForm").on("submit", function () {
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
                            if (confirm("정말로 탈퇴하시겠습니까? 탈퇴 시 복구할 수 없습니다.")) {
                                location.href = "/member/delete"; // Controller에 매핑 필요
                            }
                        }
                    </script>
            </body>

            </html>