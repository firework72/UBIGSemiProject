<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 대시보드 | 유기동물 플랫폼</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; }
        .sidebar a { color: rgba(255,255,255,.8); text-decoration: none; padding: 10px 15px; display: block; }
        .sidebar a:hover { background-color: #495057; color: white; }
        .card-stat { border: none; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: transform 0.2s; }
        .card-stat:hover { transform: translateY(-5px); }
        .icon-box { font-size: 2.5rem; opacity: 0.8; }
        .table-card { background: white; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); padding: 20px; }
        .status-badge { font-size: 0.8em; padding: 5px 10px; border-radius: 15px; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block sidebar p-0">
            <div class="p-4 text-center border-bottom border-secondary">
                <h4><i class="fas fa-paw"></i> 관리자 센터</h4>
                <small>Welcome, Admin</small>
            </div>
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/admin" class="active"><i class="fas fa-tachometer-alt me-2"></i> 대시보드</a>
                <a href="${pageContext.request.contextPath}/admin/userStatus"><i class="fas fa-users me-2"></i> 회원 관리</a>
                <a href="${pageContext.request.contextPath}/admin/boardPage"><i class="fas fa-board me-2"></i> 공지글 관리</a>
                <a href="/admin/adoptions"><i class="fas fa-dog me-2"></i> 입양/동물 관리</a>
                <a href="${pageContext.request.contextPath}/admin/activityPage"><i class="fas fa-hand-holding-heart me-2"></i> 봉사활동 관리</a>
                <a href="${pageContext.request.contextPath}/admin/fundingPage"><i class="fas fa-donate me-2"></i> 후원/펀딩 관리</a>
                <a href="/admin/boards"><i class="fas fa-comments me-2"></i> 게시판/신고 관리</a>
                <a href="/admin/chat"><i class="fas fa-headset me-2"></i> 1:1 문의</a>
            </div>
        </nav>

        <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>회원ID</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty list}">
                                <tr><td colspan="2" class="text-center">회원이 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="m" items="${list}">
                                    <tr>
                                        <td>${m.userId}</td>
                                        <td>채팅하기</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>