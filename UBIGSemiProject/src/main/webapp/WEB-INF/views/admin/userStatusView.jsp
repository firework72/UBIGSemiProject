<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리 | 관리자 센터</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .table-container { background: white; border-radius: 15px; padding: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .status-active { color: #28a745; font-weight: bold; }
        .status-stoped { color: #fd7e14; font-weight: bold; }
        .status-banned { color: #dc3545; font-weight: bold; }
        .search-bar { max-width: 400px; }
        .btn-sm { margin-right: 5px; }
        .top-menu { display:flex; gap:10px; flex-wrap:wrap; margin-bottom:20px; }
        .top-menu select, .top-menu input { padding:6px 10px; border-radius:5px; border:1px solid #ccc; }
        .search-btn { background-color:#007bff; color:white; border:none; padding:6px 12px; border-radius:5px; cursor:pointer; }
        .search-btn:hover { background-color:#0069d9; }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-users-cog"></i> 회원 관리 및 제재</h2>
    </div>

    <!-- 검색창 -->
    <div class="top-menu">
        <form action="${pageContext.request.contextPath}/admin/searchKeyword" id="searchForm" style="display:flex; gap:10px; flex-wrap:wrap;">
            <select id="searchType" name="searchType">
                <option value="all">전체</option>
                <option value="user">아이디</option>
                <option value="name">이름</option>
            </select>
            <input type="text" id="searchInput" name="searchKeyword" placeholder="검색어 입력">
            <button type="submit" class="search-btn">검색</button>
        </form>
    </div>

    <div class="table-container">
        <table class="table table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>아이디</th>
                    <th>이름(닉네임)</th>
                    <th>가입일</th>
                    <th>봉사횟수</th>
                    <th>가입상태</th>
                    <th>정지해제일</th>
                    <th>관리 액션</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <c:forEach var="m" items="${list}">
                    <tr id="userRow${m.userId}">
                        <td><strong>${m.userId}</strong></td>
                        <td>${m.userName} (${m.userNickname})</td>
                        <td><fmt:formatDate value="${m.userEnrollDate}" pattern="yyyy-MM-dd"/></td>
                        <td><span class="badge bg-info text-dark">${m.userAttendedCount}회</span></td>
                        <td>
                            <jsp:useBean id="now" class="java.util.Date" />
                            <c:choose>
                                <c:when test="${m.userStatus == 'N'}"><span class="status-banned">탈퇴/추방</span></c:when>
                                <c:when test="${m.userStatus eq 'Y' and m.userRestrictEndDate.time gt now.time}">
                                    <span class="status-stoped">정지</span>
                                </c:when>
                                <c:otherwise><span class="status-active">정상</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${not empty m.userRestrictEndDate}">
                                <fmt:formatDate value="${m.userRestrictEndDate}" pattern="yyyy-MM-dd"/>
                            </c:if>
                            <c:if test="${empty m.userRestrictEndDate}">-</c:if>
                        </td>
                        <td>
                            <c:if test="${m.userStatus == 'Y' and (empty m.userRestrictEndDate or m.userRestrictEndDate.time le now.time)}">
                                <button class="btn btn-sm btn-warning stopBtn" data-userid="${m.userId}">정지</button>
                                <button class="btn btn-sm btn-danger kickBtn" data-userid="${m.userId}">추방</button>
                            </c:if>
                            <c:if test="${m.userStatus eq 'Y' and m.userRestrictEndDate.time gt now.time}">
                                <button class="btn btn-sm btn-success openBtn" data-userid="${m.userId}">정지 해제</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 정지 기간 선택 모달 -->
<div class="modal fade" id="restrictModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원 활동 정지</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="modalUserId">
                <p>대상 아이디: <strong id="displayUserId"></strong></p>
                <div class="mb-3">
                    <label class="form-label">정지 기간 선택</label>
                    <select class="form-select" id="stopDays">
                        <option value="3">3일</option>
                        <option value="7">7일</option>
                        <option value="30">30일</option>
                        <option value="999">영구</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-warning" id="applyStopBtn">정지 적용</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function(){
/*
    // 회원 검색
    $("#searchForm").submit(function(e){
        e.preventDefault();
        let keyword = $("#searchInput").val();
        let type = $("#searchType").val();

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/searchUsers",
            type: "GET",
            data: { searchKeyword: keyword, searchType: type },
            success: function(data){
                $("#userTableBody").html(data); // tbody만 교체
            },
            error: function(){
                alert("검색 실패");
            }
        });
    }); */

    // 정지 모달 열기
    $(document).on("click", ".stopBtn", function(){
        let userId = $(this).data("userid");
        $("#modalUserId").val(userId);
        $("#displayUserId").text(userId);
        new bootstrap.Modal(document.getElementById('restrictModal')).show();
    });

    // 정지 적용
    $("#applyStopBtn").click(function(){
        let userId = $("#modalUserId").val();
        let days = $("#stopDays").val();

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/stopUser",
            type: "POST",
            data: { userId: userId, days: days },
            success: function(res){
                alert(userId + " 회원이 정지 처리되었습니다.");
                location.reload();
            },
            error: function(){
                alert("정지 처리 실패");
            }
        });
    });

    // 정지 해제
    $(document).on("click", ".openBtn", function(){
        let userId = $(this).data("userid");
        if(confirm(userId + " 회원의 정지를 해제하시겠습니까?")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/openUser",
                type: "POST",
                data: { userId: userId },
                success: function(){
                    alert(userId + " 회원 정지가 해제되었습니다.");
                    location.reload();
                },
                error: function(){
                    alert("정지 해제 실패");
                }
            });
        }
    });

    // 추방
    $(document).on("click", ".kickBtn", function(){
        let userId = $(this).data("userid");
        if(confirm(userId + " 회원을 정말 추방하시겠습니까?")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/deleteUser",
                type: "POST",
                data: { userId: userId },
                success: function(){
                    alert(userId + " 회원이 추방되었습니다.");
                    location.reload();
                },
                error: function(){
                    alert("추방 실패");
                }
            });
        }
    });

});
</script>

</body>
</html>
