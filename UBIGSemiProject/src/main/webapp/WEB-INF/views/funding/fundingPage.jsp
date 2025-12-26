<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>펀딩 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?v=3">

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    padding: 100px;
}

h2 {
    display: inline-block;
}

/* 카드 컨테이너 */
.container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

/* 카드 스타일 */
.card {
    background: white;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    width: 300px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: transform 0.2s;
}

.card:hover {
    transform: translateY(-5px);
}

.card h3 {
    margin: 0 0 10px 0;
    font-size: 1.5rem;
}

.card p {
    margin: 5px 0;
    color: #555;
    font-size: 0.95rem;
}

.card .amount {
    margin-top: 10px;
    font-weight: bold;
}

.card button {
    margin-top: 15px;
    padding: 12px;
    border: none;
    border-radius: 30px;
    background: #FFC107;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.2s;
}

.card button:hover {
    background: #FFA000;
}

/* 진행률 */
.progress-bar {
    width: 100%;
    height: 20px;
    background: #eee;
    border-radius: 20px;
    overflow: hidden;
    margin: 15px 0;
}
.progress {
    height: 100%;
    background: #FFC107;
}

/* 반응형 */
@media (max-width: 1024px) { .card { width: 45%; } }
@media (max-width: 768px) { .card { width: 100%; } }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/menubar.jsp"></jsp:include>

<h2>펀딩 목록</h2>

<h2>펀딩 목록</h2>

<!-- 펀딩 추가 버튼 -->
<div style="text-align: right; margin-bottom: 20px;">
    <form action="${pageContext.request.contextPath}/funding/insertPage" method="get">
        <button type="submit" style="
            padding: 12px 25px;
            border-radius: 30px;
            border: none;
            background: #FFC107;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        " onmouseover="this.style.background='#FFA000';" onmouseout="this.style.background='#FFC107';">
            펀딩 추가
        </button>
    </form>
</div>


<div class="container">
    <c:forEach var="funding" items="${list}">
        <div class="card">
            <h3>${funding.fundingTitle}</h3>
            <p><strong>작성자:</strong> ${funding.userId}</p>
            <p>${funding.fundingContent}</p>
            <p class="amount"><strong>목표금액:</strong> ${funding.fundingMaxMoney}원</p>
            <p class="amount"><strong>현재금액:</strong> ${funding.fundingCurrentMoney}원</p>

            <!-- 달성률 계산 -->
            <c:choose>
                <c:when test="${funding.fundingMaxMoney > 0}">
                    <c:set var="fundingRate" value="${funding.fundingCurrentMoney * 100.0 / funding.fundingMaxMoney}" />
                </c:when>
                <c:otherwise>
                    <c:set var="fundingRate" value="0" />
                </c:otherwise>
            </c:choose>

            <!-- 달성률 표시 -->
            <p><strong>달성률:</strong> 
                <fmt:formatNumber value="${fundingRate}" type="number" maxFractionDigits="2"/>%
            </p>

            <!-- 진행률 표시 -->
            <div class="progress-bar">
                <div class="progress" style="width: <c:out value='${fundingRate}'/>%; min-width:1%;"></div>
            </div>

            <!-- 상세보기 버튼 -->
            <form action="${pageContext.request.contextPath}/funding/fundingDetailView" method="get">
                <input type="hidden" name="fundingNo" value="${funding.fundingNo}">
                <button type="submit">펀딩 참여하기</button>
            </form>
        </div>
    </c:forEach>
</div>

</body>
</html>
