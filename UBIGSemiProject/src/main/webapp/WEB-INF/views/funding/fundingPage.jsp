<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유봉일공 - 펀딩 현황 및 참여</title>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Outfit:wght@300;500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
}

/* Hero */
.hero {
    height: 40vh;
    background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.6)),
    url('${pageContext.request.contextPath}/resources/images/main/main1.png') center/cover;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
}
.hero h1 {
    font-size: 3rem;
    font-weight: 800;
}

/* Section */
.section {
    padding: 80px 0;
}

.box {
    max-width: 1000px;
    margin: 0 auto;
    background: white;
    padding: 50px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

/* Summary */
.summary-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 30px;
    margin-bottom: 50px;
    text-align: center;
}
.summary-item {
    background: #f8f9fa;
    padding: 30px 20px;
    border-radius: 15px;
}
.summary-item h3 {
    font-size: 2rem;
    color: #FFC107;
}
.summary-item p {
    font-weight: 600;
    color: #555;
}

/* Progress */
.progress-bar {
    height: 22px;
    background: #eee;
    border-radius: 30px;
    overflow: hidden;
    margin-bottom: 10px;
}
.progress {
    height: 100%;
    background: #FFC107;
    width: ${fundingRate}%;
}
.progress-text {
    display: flex;
    justify-content: space-between;
    font-weight: 600;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 40px;
}
th, td {
    padding: 15px;
    border-bottom: 1px solid #ddd;
    text-align: center;
}
th {
    background: #f1f1f1;
}

/* Donate Form */
.donate-form {
    margin-top: 80px;
    padding-top: 50px;
    border-top: 1px solid #ddd;
}
.donate-form h3 {
    font-size: 1.8rem;
    margin-bottom: 30px;
}
.donate-form label {
    font-weight: 600;
    display: block;
    margin-top: 20px;
}
.donate-form input,
.donate-form select {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border-radius: 10px;
    border: 1px solid #ddd;
}
.money-buttons {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}
.money-buttons button {
    flex: 1;
    padding: 10px;
    border-radius: 30px;
    border: none;
    background: #f1f1f1;
    font-weight: 600;
    cursor: pointer;
}
.money-buttons button:hover {
    background: #FFC107;
    color: white;
}
.btn-donate {
    margin-top: 40px;
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

<jsp:include page="/WEB-INF/views/common/menubar.jsp" />

<!-- Hero -->
<section class="hero">
    <div>
        <h1>유기견 치료비 펀딩</h1>
        <p>여러분의 후원이 생명을 살립니다</p>
    </div>
</section>

<section class="section">
    <div class="box">

        <!-- Summary -->
        <div class="summary-grid">
            <div class="summary-item">
                <h3>${totalAmount}원</h3>
                <p>총 모금액</p>
            </div>
            <div class="summary-item">
                <h3>${goalAmount}원</h3>
                <p>목표 금액</p>
            </div>
            <div class="summary-item">
                <h3>${fundingRate}%</h3>
                <p>달성률</p>
            </div>
            <div class="summary-item">
                <h3>${donorCount}명</h3>
                <p>참여 인원</p>
            </div>
        </div>

        <!-- Progress -->
        <div class="progress-bar">
            <div class="progress"></div>
        </div>
        <div class="progress-text">
            <span>0%</span>
            <span>100%</span>
        </div>

        <!-- Donation List -->
        <h3 style="margin-top:60px;">최근 후원 내역</h3>
        <table>
            <thead>
                <tr>
                    <th>후원자</th>
                    <th>후원 유형</th>
                    <th>금액</th>
                    <th>후원일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${donationList}">
                    <tr>
                        <td>${d.userId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${d.donationType == 1}">치료비 지원</c:when>
                                <c:when test="${d.donationType == 2}">물품 후원</c:when>
                                <c:otherwise>보호소 운영</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${d.donationMoney}원</td>
                        <td>${d.donationDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Donate -->
        <div class="donate-form">
            <h3>펀딩 참여하기</h3>

            <form action="${pageContext.request.contextPath}/funding/insertFunding" method="post">
                <label>후원자 아이디</label>
                <input type="text" name="userId" value="${loginMember.userId}" required>

                <label>후원 유형</label>
                <select name="donationType">
                    <option value="1">치료비 지원</option>
                    <option value="2">사료/물품 후원</option>
                    <option value="3">보호소 운영</option>
                </select>

                <label>후원 금액</label>
                <input type="number" name="donationMoney" id="money" required>

                <div class="money-buttons">
                    <button type="button" onclick="setMoney(10000)">10,000원</button>
                    <button type="button" onclick="setMoney(30000)">30,000원</button>
                    <button type="button" onclick="setMoney(50000)">50,000원</button>
                </div>

                <button type="submit" class="btn-donate">펀딩 참여하기</button>
            </form>
        </div>

    </div>
</section>

<footer class="footer-simple">
    <div class="container">
        <p>&copy; 2024 UBIG (유봉일공). All rights reserved.</p>
    </div>
</footer>

<script>
function setMoney(amount) {
    document.getElementById("money").value = amount;
}
</script>

<jsp:include page="/WEB-INF/views/common/chat.jsp"/>

</body>
</html>
