<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>펀딩 목록 - 유봉일공</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Outfit:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <style>
        :root {
            --primary-color: #FFC107;
            --primary-dark: #FFA000;
            --text-dark: #2c3e50;
            --text-gray: #6c757d;
            --bg-light: #f8f9fa;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; color:#333; line-height:1.6; background-color:#fff; }
        .container { max-width: 1200px; margin: 50px auto; padding:0 20px; }
        h1 { font-size:2.5rem; color:var(--text-dark); margin-bottom:30px; text-align:center; }
        .funding-grid { display:grid; grid-template-columns:repeat(auto-fit, minmax(300px, 1fr)); gap:30px; }
        .funding-card { background-color:white; border-radius:15px; overflow:hidden; box-shadow:0 5px 15px rgba(0,0,0,0.08); transition:transform 0.3s, box-shadow 0.3s; cursor:pointer; }
        .funding-card:hover { transform:translateY(-5px); box-shadow:0 10px 25px rgba(0,0,0,0.12); }
        .funding-card img { width:100%; height:200px; object-fit:cover; }
        .card-body { padding:20px; }
        .card-body h3 { font-size:1.3rem; color:var(--text-dark); margin-bottom:10px; }
        .card-body p { color:var(--text-gray); font-size:0.95rem; margin-bottom:10px; }
        .progress-bar { width:100%; background:#eee; height:10px; border-radius:5px; overflow:hidden; margin-bottom:10px; }
        .progress-fill { height:100%; background:linear-gradient(to right, var(--primary-color), var(--primary-dark)); border-radius:5px; }
        .btn-detail, .btn-support {
            display:inline-block; padding:10px 20px; background-color:var(--primary-color); color:white; border-radius:50px; font-weight:700; text-decoration:none; transition:all 0.3s; margin-right:10px;
        }
        .btn-detail:hover, .btn-support:hover { background-color:var(--primary-dark); }
        .footer-simple { background-color:#333; color:#aaa; padding:50px 0; text-align:center; font-size:0.9rem; margin-top:60px; }
    </style>
</head>
<body>

<div class="container">
    <h1>진행 중인 펀딩 프로젝트</h1>
    <div class="funding-grid">
        <c:forEach var="funding" items="${fundingList}">
            <div class="funding-card">
                <img src="${pageContext.request.contextPath}/resources/images/main/main1.png" alt="펀딩 이미지">
                <div class="card-body">
                    <h3>${funding.fTitle}</h3>
                    <p>주최자: <strong>${funding.userId}</strong></p>
                    <div class="progress-bar">
                        <c:set var="percent" value="${(funding.fCurrentMoney / funding.fMaxMoney) * 100}" />
                        <div class="progress-fill" style="width: ${percent > 100 ? 100 : percent}%"></div>
                    </div>
                    <p>모금 현황: <fmt:formatNumber value="${funding.fCurrentMoney}" pattern="#,###"/> / <fmt:formatNumber value="${funding.fMaxMoney}" pattern="#,###"/>원</p>
                    <a href="${pageContext.request.contextPath}/funding/fundingDetailView?fNo=${funding.fNo}" class="btn-detail">상세보기</a>
                    <a href="${pageContext.request.contextPath}/funding/supportPage?fNo=${funding.fNo}" class="btn-support">참여하기</a>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty fundingList}">
            <p style="text-align:center; width:100%; color:var(--text-gray);">현재 진행 중인 펀딩이 없습니다.</p>
        </c:if>
    </div>
</div>

<footer class="footer-simple">
    <div class="container">
        <p>&copy; 2024 UBIG (유봉일공). All rights reserved.</p>
    </div>
</footer>

</body>
</html>
