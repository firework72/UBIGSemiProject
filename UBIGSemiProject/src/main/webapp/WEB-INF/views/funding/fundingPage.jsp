<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>유봉일공 - 펀딩 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    padding: 20px;
}

h2 {
    text-align: center;
    margin-bottom: 40px;
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

/* 반응형: 화면이 작아지면 카드 폭 변경 */
@media (max-width: 1024px) {
    .card {
        width: 45%;
    }
}

@media (max-width: 768px) {
    .card {
        width: 100%;
    }
}
</style>
</head>
<body>

<h2>펀딩 목록</h2>

<div class="container">
    <c:forEach var="funding" items="${list}">
        <div class="card">
            <h3>${funding.fundingTitle}</h3>
            <p><strong>작성자:</strong> ${funding.userId}</p>
            <p>${funding.fundingContent}</p>
            <p class="amount"><strong>목표금액:</strong> ${funding.fundingMaxMoney}원</p>
            <p class="amount"><strong>현재금액:</strong> ${funding.fundingCurrentMoney}원</p>

            <form action="${pageContext.request.contextPath}/funding/fundingDetailView" method="get">
                <input type="hidden" name="fundingNo" value="${funding.fundingNo}">
                <button type="submit">펀딩 참여하기</button>
            </form>
        </div>
    </c:forEach>
</div>

</body>
</html>
