<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <title>유봉일공 - 커뮤니티</title>
                <!-- [Step 6: JSP 만들기] 공통 스타일 시트를 연결합니다. -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
                <style>
                    /* 커뮤니티 페이지 전용 스타일 */
                    .community-container {
                        padding: 120px 0 50px 0;
                        width: 1200px;
                        margin: 0 auto;
                    }

                    .page-title {
                        text-align: center;
                        margin-bottom: 40px;
                        font-size: 2em;
                        font-weight: bold;
                    }

                    /* 탭 스타일 */
                    .tab-menu {
                        display: flex;
                        justify-content: center;
                        margin-bottom: 30px;
                        border-bottom: 1px solid #ddd;
                    }

                    .tab-item {
                        padding: 15px 30px;
                        cursor: pointer;
                        color: #666;
                        font-weight: 500;
                        text-decoration: none;
                    }

                    .tab-item:hover {
                        color: #333;
                    }

                    .tab-item.active {
                        border-bottom: 3px solid #ff9f43;
                        color: #ff9f43;
                        font-weight: bold;
                    }

                    /* 게시판 테이블 스타일 */
                    .board-table {
                        width: 100%;
                        border-collapse: collapse;
                        text-align: center;
                    }

                    .board-table th {
                        padding: 15px;
                        background-color: #f9f9f9;
                        border-top: 2px solid #333;
                        border-bottom: 1px solid #ddd;
                        font-weight: bold;
                    }

                    .board-table td {
                        padding: 15px;
                        border-bottom: 1px solid #eee;
                        color: #333;
                    }

                    .board-table tr:hover {
                        background-color: #f8f8f8;
                    }

                    .board-title {
                        text-align: left;
                        padding-left: 20px;
                    }

                    .board-title a {
                        text-decoration: none;
                        color: #333;
                    }

                    .board-title a:hover {
                        text-decoration: underline;
                    }
                </style>
            </head>

            <body>

                <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

                <main class="community-container">

                    <div class="page-title">커뮤니티</div>

                    <!-- [Step 7: 탭 메뉴 구현] 
             Controller에서 보내준 'category' 변수를 이용해서 
             현재 보고 있는 탭에 'active' 클래스를 붙여줍니다. (삼항연산자 사용)
        -->
                    <div class="tab-menu">
                        <a href="?category=NOTICE" class="tab-item ${category == 'NOTICE' ? 'active' : ''}">공지사항</a>
                        <a href="?category=FREE" class="tab-item ${category == 'FREE' ? 'active' : ''}">자유게시판</a>
                        <a href="?category=REQUEST" class="tab-item ${category == 'REQUEST' ? 'active' : ''}">건의사항</a>
                        <a href="?category=REVIEW" class="tab-item ${category == 'REVIEW' ? 'active' : ''}">봉사후기</a>
                    </div>

                    <!-- [Step 11: 글쓰기 버튼 추가] 
             관리자(ADMIN)일 때만 글쓰기 버튼이 보입니다.
             공지사항 탭에서 글쓰기를 누르면 자동으로 category=NOTICE를 들고 갑니다.
             (테스트를 위해 잠시 권한 체크를 주석 처리합니다)
        -->
                    <c:if test="${loginUser.userRole == 'ADMIN'}">
                        <div style="text-align: right; margin-bottom: 10px;">
                            <a href="write?category=${category}" class="btn"
                                style="background: #ff9f43; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">글쓰기</a>
                        </div>
                        </c:if>

                            <table class="board-table">
                                <colgroup>
                                    <col width="10%">
                                    <col width="50%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="10%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>조회수</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- [Step 8: 목록 출력] 
                     JSTL forEach를 사용하여 Controller가 보내준 'list' 보따리를 하나씩 꺼내서 출력합니다.
                -->
                                    <c:choose>
                                        <c:when test="${empty list}">
                                            <tr>
                                                <td colspan="5">게시글이 없습니다.</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="b" items="${list}">
                                                <tr>
                                                    <td>${b.boardId}</td>
                                                    <td class="board-title">
                                                        <a href="detail?boardId=${b.boardId}">
                                                            ${b.title}
                                                        </a>
                                                    </td>
                                                    <td>${b.userId}</td>
                                                    <td>
                                                        <fmt:formatDate value="${b.createDate}" pattern="yyyy.MM.dd" />
                                                    </td>
                                                    <td>${b.viewCount}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>

                </main>

            </body>

            </html>