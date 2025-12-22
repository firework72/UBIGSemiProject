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
                        <a href="list?category=REQUEST"
                            class="tab-item ${category == 'REQUEST' ? 'active' : ''}">건의사항</a>
                        <a href="list?category=REVIEW" class="tab-item ${category == 'REVIEW' ? 'active' : ''}">봉사후기</a>
                        <a href="qna" class="tab-item ${category == 'QNA' ? 'active' : ''}">봉사활동 Q&A</a>
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

                    <!-- 페이징 처리 및 게시글 수 선택 -->
                    <div class="paging-area" style="text-align: center; margin-top: 30px;">

                        <!-- 1. 게시글 수 선택 (limit) -->
                        <div style="float: right; margin-bottom: 10px;">
                            <select id="boardLimit" onchange="changeLimit(this.value)">
                                <option value="10" ${limit==10 ? 'selected' : '' }>10개씩 보기</option>
                                <option value="20" ${limit==20 ? 'selected' : '' }>20개씩 보기</option>
                                <option value="50" ${limit==50 ? 'selected' : '' }>50개씩 보기</option>
                            </select>
                        </div>

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
                                <!-- [Step 8: 목록 출력] -->
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

                        <!-- 2. 페이징 바 -->
                        <div class="pagination" style="margin-top: 20px;">
                            <!-- 이전 페이지 -->
                            <c:if test="${pi.currentPage > 1}">
                                <a href="list?category=${category}&cpage=${pi.currentPage - 1}&limit=${limit}"
                                    class="btn">&lt;</a>
                            </c:if>

                            <!-- 페이지 번호 -->
                            <!-- 
                             [페이징 로직]
                             startPage 부터 endPage 까지 반복문을 돌면서 버튼을 생성합니다.
                             현재 페이지인 경우 강조 표시를 합니다.
                        -->
                            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                                <c:choose>
                                    <c:when test="${p == pi.currentPage}">
                                        <a href="#" class="btn"
                                            style="background : #ff9f43; color : white; border : 1px solid #ff9f43">${p}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="list?category=${category}&cpage=${p}&limit=${limit}"
                                            class="btn">${p}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- 다음 페이지 -->
                            <c:if test="${pi.currentPage < pi.maxPage}">
                                <a href="list?category=${category}&cpage=${pi.currentPage + 1}&limit=${limit}"
                                    class="btn">&gt;</a>
                            </c:if>
                        </div>

                    </div>

                    <script>
                        function changeLimit(limit) {
                            location.href = "list?category=${category}&cpage=1&limit=" + limit;
                        }
                    </script>

                </main>

            </body>

            </html>