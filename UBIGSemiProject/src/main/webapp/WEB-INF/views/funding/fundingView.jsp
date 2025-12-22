<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>펀딩 목록</title>
    <style>
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #f2f2f2; }
        .btn-back { display:block; width:100px; margin:20px auto; padding:10px; text-align:center; background:#4CAF50; color:white; text-decoration:none; border-radius:5px; }
    </style>
</head>
<body>

<h2 style="text-align:center;">펀딩 목록</h2>

<table>
    <tr>
        <th>번호</th>
        <th>회원 ID</th>
        <th>후원 타입</th>
        <th>금액(원)</th>
        <th>상태</th>
        <th>날짜</th>
    </tr>

    <c:forEach var="d" items="${list}">
        <tr>
            <td>${d.donationNo}</td>
            <td>${d.userId}</td>
            <td>
                <c:choose>
                    <c:when test="${d.donationType == 1}">일시</c:when>
                    <c:when test="${d.donationType == 2}">정기</c:when>
                    <c:otherwise>기타</c:otherwise>
                </c:choose>
            </td>
            <td>${d.donationMoney}</td>
            <td>
	            <c:choose>
	                    <c:when test="${d.donationYn == 1}">신청</c:when>
	                    <c:when test="${d.donationYn == 2}">신청 취소</c:when>
	                    <c:otherwise>기타</c:otherwise>
	                </c:choose>
	        </td>
            <td><fmt:formatDate value="${d.donationDate}" pattern="yyyy-MM-dd"/></td>
        </tr>
    </c:forEach>
</table>

<a href="${pageContext.request.contextPath}/funding/fundingPage" class="btn-back">후원하기</a>

</body>
</html>
