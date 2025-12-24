<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>펀딩 상세보기</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}
.container {
    max-width: 800px;
    margin: 50px auto;
    background: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

/* 펀딩 정보 */
.funding-title {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 20px;
}
.funding-info p {
    font-size: 1.1rem;
    margin: 5px 0;
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

/* 후원 폼 */
.donate-form {
    margin-top: 30px;
}
.donate-form input[type="number"] {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    border-radius: 10px;
    border: 1px solid #ddd;
    font-size: 1rem;
}
.btn-donate {
    width: 100%;
    padding: 15px;
    border-radius: 50px;
    border: none;
    font-size: 1.2rem;
    font-weight: 700;
    background: #FFC107;
    color: white;
    cursor: pointer;
}
.btn-donate:hover {
    background: #FFA000;
}
</style>
</head>
<body>

<div class="container">

    <!-- 펀딩 정보 -->
    <div class="funding-title">${list.fundingTitle}</div>
    <div class="funding-info">
        <p><strong>작성자:</strong> ${list.userId}</p>
        <p><strong>내용:</strong> ${list.fundingContent}</p>
        <p><strong>목표 금액:</strong> ${list.fundingMaxMoney}원</p>
        <p><strong>현재 금액:</strong> ${list.fundingCurrentMoney}원</p>
        <c:choose>
		    <c:when test="${list.fundingMaxMoney > 0}">
		        <p><strong>달성률:</strong> 
		            ${list.fundingCurrentMoney / list.fundingMaxMoney * 100}%
		        </p>
		    </c:when>
		    <c:otherwise>
		        <p><strong>달성률:</strong> 0%</p>
		    </c:otherwise>
		</c:choose>
    </div>

    <!-- 진행률 표시 -->
    <div class="progress-bar">
        <div class="progress" style="width:${list.fundingCurrentMoney / list.fundingMaxMoney * 100}%;"></div>
    </div>

    <!-- 후원 참여 -->
    <div class="donate-form">
        <h3>펀딩 참여하기</h3>
        <form action="${pageContext.request.contextPath}/funding/insertMoney" method="post">
            <input type="hidden" name="userId" value="${loginMember.userId}">
            <input type="hidden" name="fundingNo" value="${list.fundingNo}">
            <label for="fundingMoney">후원 금액 입력:</label>
            <input type="number" name="fundingMoney" id="fundingMoney" placeholder="금액 입력" min="1" required>
            <button type="submit" class="btn-donate">후원 참여</button>
        </form>
    </div>

</div>

</body>
</html>
