<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { display: flex; min-height: 100vh; background-color: #f8f9fa; }
        #sidebar { width: 250px; background: #343a40; color: white; }
        #content { flex: 1; padding: 20px; }
        .nav-link { color: rgba(255,255,255,.8); }
        .nav-link:hover { color: #fff; background: #495057; }
    </style>
</head>
<body>

    <nav id="sidebar" class="d-flex flex-column p-3">
        <h3 class="text-center">Admin Panel</h3>
        <hr>
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item"><a href="#" class="nav-link active">대시보드</a></li>
            <li><a href="#" class="nav-link">사용자 관리</a></li>
            <li><a href="#" class="nav-link">게시글 관리</a></li>
            <li><a href="#" class="nav-link">설정</a></li>
        </ul>
        <hr>
        <div class="dropdown">
            <strong>관리자님</strong>
        </div>
    </nav>

    <main id="content">
        <header class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">통계 현황</h1>
        </header>

        <div class="row">
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body">
                        <h5 class="card-title">신규 회원</h5>
                        <p class="card-text fs-2">120 명</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">오늘의 매출</h5>
                        <p class="card-text fs-2">₩ 1,500,000</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-warning mb-3">
                    <div class="card-body">
                        <h5 class="card-title">미확인 문의</h5>
                        <p class="card-text fs-2">5 건</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-4">
            <h3>최근 가입 사용자</h3>
            <table class="table table-striped table-hover mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>가입일</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>user01</td>
                        <td>홍길동</td>
                        <td>2023-10-27</td>
                        <td><span class="badge bg-success">활성</span></td>
                    </tr>
                    </tbody>
            </table>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>