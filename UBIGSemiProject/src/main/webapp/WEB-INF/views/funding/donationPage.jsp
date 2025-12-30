<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html>

            <head>
                <title>내 후원 목록</title>

                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?v=3">

                <style>
                    body {
                        font-family: 'Noto Sans KR', sans-serif;
                        background-color: #f8f9fa;
                        padding-top: 50px;
                    }

                    h2 {
                        text-align: center;
                        margin: 30px 0;
                    }

                    /* 상단 영역 */
                    .top-menu {
                        width: 90%;
                        max-width: 1200px;
                        margin: 0 auto 30px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: 15px;
                    }

                    .filter-area {
                        display: flex;
                        gap: 10px;
                    }

                    .filter-btn {
                        padding: 8px 16px;
                        background-color: #17a2b8;
                        color: #fff;
                        border-radius: 20px;
                        text-decoration: none;
                        font-weight: 600;
                        font-size: 0.9rem;
                        transition: 0.3s;
                    }

                    .filter-btn:hover {
                        background-color: #138496;
                        transform: translateY(-2px);
                    }

                    /* 검색 */
                    .search-area {
                        display: flex;
                        gap: 10px;
                    }

                    .search-area select,
                    .search-area input {
                        padding: 8px;
                        border-radius: 5px;
                        border: 1px solid #ccc;
                    }

                    .search-btn {
                        background-color: #FFC107;
                        border: none;
                        padding: 8px 16px;
                        border-radius: 5px;
                        font-weight: bold;
                        cursor: pointer;
                    }

                    /* 테이블 */
                    table {
                        width: 90%;
                        max-width: 1200px;
                        margin: 0 auto 40px;
                        border-collapse: collapse;
                        background: #fff;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    }

                    th,
                    td {
                        padding: 14px;
                        text-align: center;
                        border-bottom: 1px solid #eee;
                    }

                    th {
                        background-color: #FFC107;
                        color: #fff;
                    }

                    tr:hover {
                        background-color: #fff3cd;
                    }

                    /* 버튼 */
                    .cancel-btn {
                        padding: 6px 12px;
                        background-color: #dc3545;
                        color: #fff;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                    }

                    .btn-area {
                        width: 90%;
                        max-width: 1200px;
                        margin: 0 auto 60px;
                        text-align: right;
                    }

                    .btn-back {
                        display: inline-block;
                        padding: 12px 30px;
                        background-color: #28a745;
                        color: #fff;
                        border-radius: 30px;
                        text-decoration: none;
                        font-weight: bold;
                    }
                </style>

                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            </head>

            <body>

                <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

                <main class="community-container">
                    <div class="page-header">
                        <div class="page-title">내 후원 목록</div>
                    </div>

                    <!-- ================= 상단 필터 / 검색 ================= -->
                    <div class="top-menu">

                        <!-- 🔥 빠른 필터 -->
                        <div class="filter-area">
                            <a class="filter-btn" href="${pageContext.request.contextPath}/donation/myDonation">내
                                정기후원</a>
                            <a class="filter-btn" href="${pageContext.request.contextPath}/donation/myDonation2">내
                                일시후원</a>
                            <a class="filter-btn" href="${pageContext.request.contextPath}/donation">전체</a>
                        </div>

                        <!-- 🔍 검색 -->
                        <form class="search-area" action="${pageContext.request.contextPath}/donation/searchKeyword"
                            method="get">

                            <select name="searchType" id="searchType">
                                <option value="user">회원 ID</option>
                                <option value="type">후원 타입</option>
                            </select>

                            <input type="text" name="searchKeyword" id="searchInput" placeholder="회원 ID를 입력하세요">

                            <button type="submit" class="search-btn">검색</button>
                        </form>
                    </div>

                    <!-- ================= 테이블 ================= -->
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
                            <tr>
                                <td>${d.donationNo}</td>
                                <td>${d.userId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.donationType == 1}">정기</c:when>
                                        <c:when test="${d.donationType == 2}">일시</c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${d.donationMoney}" />
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.donationYn == 1}">신청</c:when>
                                        <c:when test="${d.donationYn == 2}">신청 취소</c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatDate value="${d.donationDate}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>
                                    <c:if
                                        test="${d.donationType == 1 && d.donationYn == 1 && loginMember.userId eq d.userId}">
                                        <button class="cancel-btn" data-id="${d.donationNo}">정기 해제</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                    <!-- ================= 하단 버튼 ================= -->
                    <div class="btn-area">
                        <a href="${pageContext.request.contextPath}/donation/donationDetailView"
                            class="btn-back">후원하기</a>
                    </div>
                </main>

                <!-- ================= JS ================= -->
                <script>
                    $(function () {

                        // 검색 placeholder 변경
                        $("#searchType").change(function () {
                            const type = $(this).val();
                            if (type === "user") {
                                $("#searchInput").attr("placeholder", "회원 ID를 입력하세요");
                            } else if (type === "type") {
                                $("#searchInput").attr("placeholder", "정기 / 일시");
                            } else {
                                $("#searchInput").attr("placeholder", "검색어 입력");
                            }
                        });

                        // 정기 후원 해제
                        $(".cancel-btn").click(function () {
                            if (!confirm("정기 후원을 해제하시겠습니까?")) return;

                            const donationNo = $(this).data("id");
                            const btn = $(this);

                            $.ajax({
                                url: "${pageContext.request.contextPath}/donation/cancelDonation",
                                type: "POST",
                                data: { donationNo: donationNo },
                                success: function (res) {
                                    if (res === "success") {
                                        btn.closest("tr").find("td:eq(4)").text("신청 취소");
                                        btn.remove();
                                    } else {
                                        alert("정기 후원 해제 실패");
                                    }
                                },
                                error: function (xhr) {
                                    alert("서버 오류: " + xhr.status);
                                }
                            });
                        });

                    });
                </script>

            </body>

            </html>