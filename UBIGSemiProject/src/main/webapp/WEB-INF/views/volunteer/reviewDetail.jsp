<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>봉사활동 후기 상세</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
                <style>
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
                        font-weight: 800;
                    }

                    .detail-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 30px;
                    }

                    .detail-table th,
                    .detail-table td {
                        border-bottom: 1px solid #eee;
                        padding: 15px;
                        text-align: left;
                    }

                    .detail-table th {
                        width: 150px;
                        background-color: #f8f9fa;
                        font-weight: bold;
                        color: #555;
                    }

                    .review-content {
                        min-height: 300px;
                        padding: 30px;
                        background-color: #f9f9f9;
                        border-radius: 10px;
                        line-height: 1.6;
                        color: #444;
                        white-space: pre-line;
                        /* 줄바꿈 적용 */
                    }

                    .star-points {
                        color: #ffc107;
                        letter-spacing: -2px;
                    }

                    .btn-area {
                        text-align: center;
                        margin-top: 40px;
                    }

                    .btn-list {
                        background-color: #007bff;
                        color: white;
                        padding: 12px 30px;
                        border: none;
                        border-radius: 50px;
                        font-weight: bold;
                        text-decoration: none;
                        display: inline-block;
                        transition: background-color 0.3s;
                    }

                    .btn-list:hover {
                        background-color: #0056b3;
                    }
                </style>
            </head>

            <body>

                <jsp:include page="../common/menubar.jsp" />

                <div class="container">
                    <h2>📑 후기 상세 보기</h2>

                    <!-- [추가] 후기 제목을 크게 표시 -->
                    <div
                        style="font-size: 24px; font-weight: bold; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #333;">
                        ${r.rTitle}
                    </div>

                    <table class="detail-table">
                        <tr>
                            <th>활동명</th>
                            <td>${r.actTitle}</td>
                            <th>작성일</th>
                            <td>
                                <fmt:formatDate value="${r.rCreate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>${r.rId}</td>
                            <th>별점</th>
                            <td class="star-points">
                                <c:forEach begin="1" end="${r.rRate}">⭐</c:forEach>
                                <span style="color: #666; font-size: 14px; margin-left: 5px;">(${r.rRate}점)</span>
                            </td>
                        </tr>
                    </table>

                    <div class="review-content">
                        ${r.rReview}
                    </div>

                    <div class="btn-area">
                        <a href="reviewList.vo" class="btn-list">목록으로</a>

                        <%-- 아이디가 admin1이거나, 계정 권한(userRole)이 ADMIN인 경우 버튼 노출 --%>
					<c:if test="${loginMember.userRole eq 'ADMIN'}">
					    <a href="reviewUpdateForm.vo?reviewNo=${r.reviewNo}" class="btn-list"
					        style="background-color: #ffc107;">수정</a>
					
					    <a href="deleteReview.vo?reviewNo=${r.reviewNo}" onclick="return confirm('관리자 권한으로 삭제하시겠습니까?');"
					        class="btn-list" style="background-color: #dc3545;">삭제</a>
					</c:if>
                    </div>
                </div>

            </body>

            </html>