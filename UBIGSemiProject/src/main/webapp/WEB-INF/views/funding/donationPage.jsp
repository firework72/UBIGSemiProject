<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?v=3">
    <title>후원 목록</title>

    <style>
        body { font-family:'Noto Sans KR', sans-serif; background-color:#f8f9fa; padding-top:50px; color:#333; line-height:1.6; }
        h2 { text-align:center; font-size:2rem; margin:40px 0 20px; color:#2c3e50; }

        /* 상단 메뉴 */
        .top-menu { display:flex; justify-content:flex-end; align-items:center; margin:0 20px 30px; gap:10px; flex-wrap:wrap; }
        .top-menu select, .top-menu input[type="text"] { padding:8px 12px; border-radius:5px; border:1px solid #ccc; font-size:0.95rem; }
        .top-menu button { padding:8px 16px; border:none; border-radius:5px; font-weight:600; cursor:pointer; transition: all 0.3s; }
        .search-btn { background-color:#FFC107; color:white; }
        .search-btn:hover { background-color:#FFA000; transform:translateY(-2px); }
        .add-btn { background-color:#28a745; color:white; }
        .add-btn:hover { background-color:#218838; transform:translateY(-2px); }

        /* 테이블 */
        table { width:90%; max-width:1200px; margin:0 auto 40px; border-collapse:collapse; background-color:white; border-radius:10px; overflow:hidden; box-shadow:0 8px 20px rgba(0,0,0,0.1); }
        th, td { padding:15px; text-align:center; border-bottom:1px solid #eee; }
        th { background-color:#FFC107; color:white; font-weight:700; }
        tr:nth-child(even) { background-color:#f9f9f9; }
        tr:hover { background-color:#fff3cd; }

        /* 정기 해제 버튼 */
        .cancel-btn { padding:5px 10px; background:#dc3545; color:white; border:none; border-radius:5px; cursor:pointer; transition:all 0.2s; }
        .cancel-btn:hover { background:#c82333; transform:translateY(-2px); }

        /* 후원하기 버튼 */
        .btn-back { display:inline-block; width:150px; margin:0 auto 60px; padding:12px 0; text-align:center; background-color:#28a745; color:white; text-decoration:none; border-radius:50px; font-weight:700; box-shadow:0 4px 8px rgba(0,0,0,0.2); transition:all 0.3s; }
        .btn-back:hover { background-color:#218838; transform:translateY(-3px); }

        /* 반응형 */
        @media(max-width:1024px){
            .top-menu { flex-direction:column; align-items:flex-start; }
            table { width:95%; }
        }
        @media(max-width:768px){
            table, th, td { font-size:0.85rem; }
            .btn-back { width:120px; padding:10px 0; }
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/menubar.jsp"></jsp:include>

<h2>후원 목록</h2>

<div class="top-menu">
    <form action="${pageContext.request.contextPath}/donation/searchKeyword" method="get" style="display:flex; gap:10px; flex-wrap:wrap;">
        <select id="searchType" name="searchType">
            <option value="all">전체</option>
            <option value="user">작성자</option>
            <option value="title">후원타입</option>
        </select>
        <label>정기</label>
        <input type="radio" name="donationType" value="1">
        <label>일시</label>
        <input type="radio" name="donationType" value="2">
        <input type="text" id="searchInput" name="searchKeyword" placeholder="검색어 입력" value="${param.searchKeyword}">
        <button type="submit" class="search-btn">검색</button>
    </form>
</div>

<table>
    <tr>
        <th>번호</th>
        <th>회원 ID</th>
        <th>후원 타입</th>
        <th>금액(원)</th>
        <th>상태</th>
        <th>날짜</th>
        <th>관리</th>
    </tr>

    <c:forEach var="d" items="${list}">
        <tr id="donationRow${d.donationNo}">
            <td>${d.donationNo}</td>
            <td>${d.userId}</td>
            <td>
                <c:choose>
                    <c:when test="${d.donationType == 1}">정기</c:when>
                    <c:when test="${d.donationType == 2}">일시</c:when>
                    <c:otherwise>기타</c:otherwise>
                </c:choose>
            </td>
            <td>${d.donationMoney}</td>
            <td id="status${d.donationNo}">
                <c:choose>
                    <c:when test="${d.donationYn == 1}">신청</c:when>
                    <c:when test="${d.donationYn == 2}">신청 취소</c:when>
                    <c:otherwise>기타</c:otherwise>
                </c:choose>
            </td>
            <td><fmt:formatDate value="${d.donationDate}" pattern="yyyy-MM-dd"/></td>
            <td>
                <c:if test="${d.donationType == 1 && d.donationYn == 1}">
                    <button class="cancel-btn" data-id="${d.donationNo}">정기 해제</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<a href="${pageContext.request.contextPath}/donation/donationDetailView" class="btn-back">후원하기</a>

<script>
$(document).ready(function(){
    $(".cancel-btn").click(function(){
        if(!confirm("정기 후원을 해제하시겠습니까?")) return;

        let donationNo = $(this).data("id");
        let btn = $(this);

        $.ajax({
            url: "${pageContext.request.contextPath}/donation/cancelDonation",
            type: "POST",
            data: { donationNo: donationNo },
            success: function(response){
                // 상태 변경
                $("#status" + donationNo).text("신청 취소");
                // 버튼 제거
                btn.remove();
            },
            error: function(xhr, status, error){
                alert("정기 후원 해제 실패: " + error);
            }
        });
    });

    // 검색 placeholder 변경
    $("#searchType").change(function(){
        if(this.value==='user'){ $("#searchInput").attr("placeholder","작성자 입력"); }
        else if(this.value==='title'){ $("#searchInput").attr("placeholder","후원타입 입력"); }
        else { $("#searchInput").attr("placeholder","검색어 입력"); }
    });
});
</script>

</body>
</html>
