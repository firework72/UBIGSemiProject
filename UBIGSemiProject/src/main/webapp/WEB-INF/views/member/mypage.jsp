<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <style>
        body { background-color: #f8f9fa; }
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
        .stat-card:hover { transform: translateY(-5px); }
        .readonly-input { background-color: #e9ecef; cursor: not-allowed; }
    </style>
</head>
<body>

    <div class="mypage-header text-center">
        <div class="container">
            <h2 class="fw-bold">MY PAGE</h2>
            <p class="lead mb-0">안녕하세요, <strong>${loginMember.userNickname}</strong>님!</p>
            <div class="mt-3">
                <span class="badge bg-light text-dark fs-6 p-2">
                    🐶 봉사활동 참여 횟수: <span class="text-danger fw-bold">${loginMember.userAttendedCount}</span>회
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
                    <div class="list-group list-group-flush sidebar-menu">
                        <a href="/member/mypage" class="list-group-item list-group-item-action active">내 정보 수정</a>
                        <a href="/volunteer/myHistory" class="list-group-item list-group-item-action">봉사 신청 내역</a>
                        <a href="/adoption/myList" class="list-group-item list-group-item-action">입양 신청 내역</a>
                        <a href="/community/myPosts" class="list-group-item list-group-item-action">내가 쓴 글</a>
                        <a href="#" class="list-group-item list-group-item-action text-danger" onclick="deleteMember()">회원 탈퇴</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h4 class="mb-4 fw-bold border-bottom pb-2">내 정보 수정</h4>
                        
                        <form action="/member/update" method="post" id="updateForm">
                            <input type="hidden" name="userId" value="${loginMember.userId}">

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label fw-bold">아이디</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control readonly-input" value="${loginMember.userId}" readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label fw-bold">이름</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control readonly-input" value="${loginMember.userName}" readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label fw-bold">닉네임</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="userNickname" value="${loginMember.userNickname}" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label fw-bold">연락처</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="userContact" value="${loginMember.userContact}" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label fw-bold">주소</label>
                                <div class="col-sm-9">
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control" id="postcode" placeholder="우편번호" readonly>
                                        <button class="btn btn-outline-secondary" type="button" onclick="execDaumPostcode()">주소 검색</button>
                                    </div>
                                    <input type="text" class="form-control mb-2" id="roadAddress" placeholder="기본 주소" readonly>
                                    <input type="text" class="form-control" id="detailAddress" placeholder="상세 주소를 입력해주세요">
                                    
                                    <input type="hidden" id="userAddress" name="userAddress" value="${loginMember.userAddress}">
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label fw-bold">가입일</label>
                                <div class="col-sm-9">
                                    <span class="form-control-plaintext">
                                        <fmt:formatDate value="${loginMember.userEnrollDate}" pattern="yyyy년 MM월 dd일"/>
                                    </span>
                                </div>
                            </div>

                            <hr class="my-4">

                            <div class="d-flex justify-content-between">
                                <button type="button" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#pwdChangeModal">비밀번호 변경</button>
                                <button type="submit" class="btn btn-warning fw-bold text-white px-4">정보 수정 저장</button>
                            </div>
                        </form>
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
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
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
        $(document).ready(function() {
            var fullAddr = "${loginMember.userAddress}";
            if(fullAddr) {
                var addrParts = fullAddr.split(", ");
                // 콤마로 단순 분리 (실제 데이터에 콤마가 더 있으면 로직 보강 필요)
                if(addrParts.length >= 1) $("#roadAddress").val(addrParts[0]);
                if(addrParts.length >= 2) $("#detailAddress").val(addrParts[1]);
            }
        });

        // 2. 주소 API (회원가입과 동일)
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress;
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("roadAddress").value = roadAddr;
                    document.getElementById("detailAddress").focus();
                }
            }).open();
        }

        // 3. 폼 제출 전 주소 합치기
        $("#updateForm").on("submit", function() {
            var road = $("#roadAddress").val();
            var detail = $("#detailAddress").val();
            
            // 상세주소가 없어도 콤마 없이 기본주소만이라도 저장
            var fullAddr = road;
            if(detail) fullAddr += ", " + detail;
            
            $("#userAddress").val(fullAddr);
            return true;
        });
        
        // 4. 회원 탈퇴 함수
        function deleteMember() {
            if(confirm("정말로 탈퇴하시겠습니까? 탈퇴 시 복구할 수 없습니다.")) {
                location.href = "/member/delete"; // Controller에 매핑 필요
            }
        }
    </script>
</body>
</html>