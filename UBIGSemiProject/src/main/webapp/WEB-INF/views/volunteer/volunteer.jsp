<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>봉사활동 모집 리스트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        /* reviewList.jsp의 스타일을 가져왔습니다 */
        body {
            font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 1000px;
            margin: 50px auto;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #333;
            font-size: 28px;
            font-weight: 800;
        }

        /* 테이블 디자인 */
        .list-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
        }

        .list-table th {
            background-color: #eef2f6;
            color: #444;
            padding: 15px;
            font-weight: bold;
            border-bottom: 2px solid #ddd;
            text-align: center;
        }

        .list-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            color: #555;
            text-align: center;
        }

        /* 마우스 올렸을 때 효과 */
        .list-table tbody tr:hover {
            background-color: #f1f8ff;
            transform: translateY(-2px);
            transition: all 0.2s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        /* 제목 링크 스타일 */
        .title-link {
            color: #333;
            text-decoration: none;
            font-weight: 600;
            display: block;
            text-align: left;
            padding-left: 10px;
        }

        .title-link:hover {
            color: #007bff;
        }

        /* 버튼 영역 */
        .btn-area {
            text-align: right;
            margin-top: 30px;
        }

        .btn-main {
            background-color: #007bff;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-main:hover {
            background-color: #0056b3;
        }
        
        /* 검색폼 스타일 */
        .search-area {
            margin-bottom: 20px; 
            text-align: right;
        }
        .search-select, .search-input {
            padding: 8px; 
            border-radius: 4px; 
            border: 1px solid #ddd;
        }
        .btn-search {
            padding: 8px 15px;
            background-color: #333; 
            color: white; 
            border: none; 
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>

<body>

    <jsp:include page="../common/menubar.jsp" />

    <div class="container">
        <h2>🤲 봉사활동 모집 리스트</h2>
        <p style="text-align: center; color: #666; margin-bottom: 30px;">
            따뜻한 손길이 필요한 곳을 찾아보세요.
        </p>

        <div class="search-area">
            <form action="volunteerList.vo" method="get">
                <select name="condition" class="search-select">
                    <option value="title" <c:if test="${condition eq 'title'}">selected</c:if>>제목</option>
                    <option value="address" <c:if test="${condition eq 'address'}">selected</c:if>>지역</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" class="search-input">
                <button type="submit" class="btn-search">검색</button>
            </form>
        </div>

        <table class="list-table">
            <thead>
                <tr>
                    <th width="10%">번호</th>
                    <th width="40%">제목</th>
                    <th width="15%">작성자</th>
                    <th width="20%">활동 날짜</th>
                    <th width="15%">지역</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="5" style="padding: 50px 0; color: #999;">
                                🍃 현재 모집 중인 봉사활동이 없습니다.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="vo" items="${list}">
                            <tr>
                                <td>${vo.actId}</td>
                                <td>
                                    <a href="volunteerDetail.vo?actId=${vo.actId}" class="title-link">
                                        ${vo.actTitle}
                                    </a>
                                </td>
                                <td>${vo.adminId}</td>
                                <td>
                                    <fmt:formatDate value="${vo.actDate}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>${vo.actAddress}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <div style="text-align: center; margin-top: 30px;">
            <c:if test="${not empty list}">
                
                <c:choose>
                    <c:when test="${pi.currentPage eq 1}">
                        <button disabled class="btn-page" style="color:#ccc;">&lt;</button>
                    </c:when>
                    <c:otherwise>
                        <a href="volunteerList.vo?cpage=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}" class="btn-page">&lt;</a>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${p eq pi.currentPage}">
                            <button disabled class="btn-page active">${p}</button>
                        </c:when>
                        <c:otherwise>
                            <a href="volunteerList.vo?cpage=${p}&condition=${condition}&keyword=${keyword}" class="btn-page">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:choose>
                    <c:when test="${pi.currentPage eq pi.maxPage}">
                        <button disabled class="btn-page" style="color:#ccc;">&gt;</button>
                    </c:when>
                    <c:otherwise>
                        <a href="volunteerList.vo?cpage=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}" class="btn-page">&gt;</a>
                    </c:otherwise>
                </c:choose>
                
            </c:if>
        </div>

        <style>
            .btn-page {
                display: inline-block;
                padding: 8px 14px;
                margin: 0 3px;
                border: 1px solid #ddd;
                background-color: white;
                color: #333;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s;
            }
            .btn-page:hover:not([disabled]) {
                background-color: #f1f1f1;
                border-color: #bbb;
            }
            .btn-page.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
                cursor: default;
            }
        </style>

        <div class="btn-area">
            <c:if test="${loginMember.userRole eq 'ADMIN'}">
                <a href="volunteerWriteForm.vo" class="btn-main" style="background-color: #28a745;">
                    + 새 활동 등록하기
                </a>
            </c:if>
        </div>
    </div>

</body>
</html>
