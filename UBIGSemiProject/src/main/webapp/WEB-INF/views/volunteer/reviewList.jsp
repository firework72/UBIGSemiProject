<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>봉사활동 후기 게시판</title>

                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

                <style>
                    /* 폰트 및 기본 설정 */
                    body {
                        font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
                        background-color: #f8f9fa;
                        margin: 0;
                        padding: 0;
                    }

                    /* 컨테이너: 전체 내용을 중앙 정렬하고 깔끔하게 모음 */
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
                    .review-table {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0;
                        margin-top: 20px;
                    }

                    .review-table th {
                        background-color: #eef2f6;
                        color: #444;
                        padding: 15px;
                        font-weight: bold;
                        border-bottom: 2px solid #ddd;
                        text-align: center;
                    }

                    .review-table td {
                        padding: 15px;
                        border-bottom: 1px solid #eee;
                        color: #555;
                        text-align: center;
                    }

                    /* 마우스 올렸을 때 효과 */
                    .review-table tbody tr:hover {
                        background-color: #f1f8ff;
                        /* 살짝 푸른 빛 */
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
                        /* 클릭 영역 확대 */
                        text-align: left;
                        padding-left: 10px;
                    }

                    .title-link:hover {
                        color: #007bff;
                    }

                    /* 별점 스타일 */
                    .star-points {
                        color: #ffc107;
                        font-size: 14px;
                        letter-spacing: -2px;
                        /* 별 간격 좁게 */
                    }

                    /* 버튼 영역 */
                    .btn-area {
                        text-align: right;
                        /* 오른쪽 정렬 */
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

                    /* 게시글 없을 때 */
                    .empty-msg {
                        padding: 50px 0;
                        color: #999;
                        font-size: 16px;
                    }
                </style>
            </head>

            <body>

                <jsp:include page="../common/menubar.jsp" />

                <div class="container">
                    <h2>📝 봉사활동 참여 후기</h2>
                    <p style="text-align: center; color: #666; margin-bottom: 30px;">
                        따뜻한 나눔의 이야기를 확인해보세요.
                    </p>

                    <!-- [추가] 검색 폼 -->
                    <div style="margin-bottom: 20px; text-align: right;">
                        <form action="reviewList.vo" method="get">
                            <select name="condition" style="padding: 6px; border-radius: 4px; border: 1px solid #ddd;">
                                <option value="title" <c:if test="${condition eq 'title'}">selected</c:if>>활동명</option>
                                <option value="writer" <c:if test="${condition eq 'writer'}">selected</c:if>>작성자
                                </option>
                                <option value="content" <c:if test="${condition eq 'content'}">selected</c:if>>내용
                                </option>
                            </select>
                            <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요"
                                style="padding: 6px; border-radius: 4px; border: 1px solid #ddd;">
                            <button type="submit"
                                style="padding: 7px 15px; background-color: #333; color: white; border: none; border-radius: 4px;">검색</button>
                        </form>
                    </div>

                    <table class="review-table">
                        <thead>
                            <tr>
                                <th width="8%">번호</th>
                                <th width="">봉사명</th>
                                <th width="30%">후기 제목</th>
                                <th width="15%">별점</th>
                                <th width="10%">작성자</th>
                                <th width="12%">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="6" class="empty-msg">
                                            🍃 아직 등록된 후기가 없습니다.<br>첫 번째 후기의 주인공이 되어주세요!
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="r" items="${list}">
                                        <tr>
                                            <td>${r.reviewNo}</td>
                                            <td>
                                                <!-- 활동 제목 (단순 표시) -->
                                                ${r.actTitle}
                                            </td>
                                            <td style="text-align: left; padding-left: 20px;">
                                                <!-- [수정] 후기 제목 (클릭 시 상세 이동) -->
                                                <a href="reviewDetail.vo?reviewNo=${r.reviewNo}" class="title-link">
                                                    ${r.rTitle}
                                                </a>
                                            </td>
                                            <td class="star-points">
                                                <c:forEach begin="1" end="${r.rRate}">⭐</c:forEach>
                                            </td>
                                            <td>${r.rId}</td>
                                            <td>
                                                <fmt:formatDate value="${r.rCreate}" pattern="yyyy-MM-dd" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <div class="btn-area">
                        <a href="volunteerList.vo" class="btn-main">봉사 목록으로</a>
                    </div>
                </div>
                <div class="btn-area">
                    <%-- 아이디 체크 대신 userRole이 ADMIN인지 확인하도록 변경 --%>
					<c:if test="${loginMember.userRole eq 'ADMIN'}">
					    <a href="reviewWriteForm.vo" class="btn-main"
					        style="background-color: #ffc107; color: #333; margin-right: 10px;">
					        ✏️ 후기 작성하기 (관리자)
					    </a>
					</c:if>
                </div>

            </body>

            </html>