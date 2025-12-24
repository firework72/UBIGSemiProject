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
        
        /* 상단 메뉴 */
		.top-menu {
		    float: right;
		    margin-top: -10px;
		}
		.top-menu form {
		    display: inline-block;
		    margin-left: 10px;
		}
		.top-menu input[type="text"] {
		    padding: 8px;
		    border-radius: 5px;
		    border: 1px solid #ccc;
		}
		.top-menu button {
		    padding: 8px 12px;
		    border-radius: 5px;
		    border: none;
		    cursor: pointer;
		    color: white;
		}
		.top-menu .search-btn {
		    background-color: #FFC107;
		}
		.top-menu .add-btn {
		    background-color: #28a745;
		}
    </style>
</head>
<body>

<h2 style="text-align:center;">펀딩 목록</h2>

<!-- 상단 메뉴: 검색 + 펀딩 추가 -->
<div class="top-menu">
    <!-- 검색 폼 -->
    <form action="${pageContext.request.contextPath}/donation/searchKeyword" method="get">
        <select id="searchType">
        	<option value="all">전체</option>
        	<option value="user">작성자</option>
        	<option value="title">제목</option>
        </select>
       	
        <input type="text" id="searchInput" name="searchKeyword" placeholder="검색어 입력" value="${param.searchKeyword}">
        <button type="submit" class="search-btn">검색</button>
    </form>
    
	<script>
	    let select = document.getElementById('searchType');
	    let input = document.getElementById('searchInput');
	
	    select.addEventListener('change', function() {
	        if (this.value === 'user') {
	            input.placeholder = '작성자 입력';
	        } else if (this.value === 'title') {
	            input.placeholder = '후원타입 입력';
	        } 	
	        else {
	            input.placeholder = '검색어 입력';
	        }
	    });
	</script>

</div>

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

<a href="${pageContext.request.contextPath}/donation/donationDetailView" class="btn-back">후원하기</a>

</body>
</html>
