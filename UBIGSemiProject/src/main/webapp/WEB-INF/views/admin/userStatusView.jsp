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
        .status-restricted { color: #fd7e14; font-weight: bold; }
        .status-banned { color: #dc3545; font-weight: bold; }
        .search-bar { max-width: 400px; }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-users-cog"></i> 회원 관리 및 제재</h2>
        <div class="search-bar">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="아이디 또는 이름 검색...">
                <button class="btn btn-primary"><i class="fas fa-search"></i></button>
            </div>
        </div>
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
            <tbody>
                <c:forEach var="m" items="${list}">
                    <tr>
                        <td><strong>${m.userId}</strong></td>
                        <td>${m.userName} (${m.userNickname})</td>
                        <td><fmt:formatDate value="${m.userEnrollDate}" pattern="yyyy-MM-dd"/></td>
                        <td><span class="badge bg-info text-dark">${m.userAttendedCount}회</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${m.userStatus == 'Y'}"><span class="status-active">정상</span></c:when>
                                <c:when test="${m.userStatus == 'N'}"><span class="status-banned">탈퇴/추방</span></c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${not empty m.userRestrictEndDate}">
                                <fmt:formatDate value="${m.userRestrictEndDate}" pattern="yyyy-MM-dd"/>
                            </c:if>
                            <c:if test="${empty m.userRestrictEndDate}">-</c:if>
                        </td>
                        <td>
                            <c:if test="${m.userStatus == 'Y'}">
                                <button class="btn btn-sm btn-warning" onclick="openRestrictModal('${m.userId}')">정지</button>
                                <button class="btn btn-sm btn-danger" onclick="confirmKick('${m.userId}')">추방</button>
                                <button class="btn btn-sm btn-open" onclick="changeStatus('${m.userId}')">정지 해제</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="restrictModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원 활동 정지</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/stopUser" method="post">
                <div class="modal-body">
                    <input type="hidden" name="userId" id="modalUserId">
                    <p>대상 아이디: <strong id="displayUserId"></strong></p>
                    <div class="mb-3">
                        <label class="form-label">정지 기간 선택</label>
                        <select class="form-select" name="days">
                            <option value="3">3일 일시 정지</option>
                            <option value="7">7일 일시 정지</option>
                            <option value="30">30일 한 달 정지</option>
                            <option value="999">영구 활동 정지</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-warning">정지 적용</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
	$("")
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openRestrictModal(userId) {
        document.getElementById('modalUserId').value = userId;
        document.getElementById('displayUserId').innerText = userId;
        new bootstrap.Modal(document.getElementById('restrictModal')).show();
    }

    function confirmKick(userId) {
        if(confirm(userId + " 회원을 정말로 추방하시겠습니까?추방 시 로그인이 차단됩니다.")) {
            location.href = "${pageContext.request.contextPath}/admin/deleteUser?userId="+userId;
        }
    }
    
    function changeStatus(userId) {
        if(confirm(userId + " 회원의 정지를 해제하시겠습니까?")) {
            location.href = "${pageContext.request.contextPath}/admin/openUser?userId="+userId;
        }
    }
</script>
</body>
</html>