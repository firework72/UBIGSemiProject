<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>봉사활동 목록</title>
                <style>
                    /* 여기서부터 디자인 코드입니다 */
                    body {
                        font-family: 'Noto Sans KR', sans-serif;
                        /* 폰트 깔끔하게 */
                        padding: 20px;
                    }

                    h2 {
                        color: #333;
                        border-left: 5px solid #4CAF50;
                        /* 제목 옆에 초록색 띠 */
                        padding-left: 10px;
                        margin-bottom: 20px;
                    }

                    /* 표(테이블) 스타일 */
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        /* 테두리 겹침 방지 */
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                        /* 그림자 효과 (블록 느낌) */
                    }

                    /* 표 머리글 (제목줄) */
                    th {
                        background-color: #4CAF50;
                        /* 초록색 배경 */
                        color: white;
                        padding: 12px;
                        text-align: center;
                    }

                    /* 표 내용물 (데이터줄) */
                    td {
                        padding: 15px;
                        /* 안쪽 여백을 줘서 뚱뚱하게 만들기 */
                        border-bottom: 1px solid #ddd;
                        /* 줄마다 밑줄 긋기 */
                        text-align: center;
                        color: #333;
                    }

                    /* 마우스 올렸을 때 효과 */
                    tr:hover {
                        background-color: #f5f5f5;
                        /* 회색으로 살짝 변함 */
                    }

                    /* 제목 링크 스타일 */
                    a {
                        text-decoration: none;
                        /* 밑줄 없애기 */
                        color: #333;
                        font-weight: bold;
                        display: block;
                        /* 링크를 블록으로 만들어서 클릭하기 쉽게 */
                    }

                    a:hover {
                        color: #4CAF50;
                        /* 마우스 올리면 초록색 */
                    }

                    /* 버튼 디자인 */
                    button {
                        background-color: #4CAF50;
                        color: white;
                        border: none;
                        padding: 10px 20px;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 16px;
                    }

                    button:hover {
                        background-color: #45a049;
                    }

                    button:hover {
                        background-color: #45a049;
                    }
                </style>
            </head>

            <body>

                <a href="volunteerList.vo" style="text-decoration: none; color: inherit;">
                    <h2>봉사활동 모집 리스트</h2>
                </a>
                <%-- 메인페이지 이동 --%>
                    <a href="${pageContext.request.contextPath}/" style="text-decoration: none; color: inherit;">
                        <h2>유봉일공</h2>
                    </a>

                    <!-- [추가] 검색 폼 -->
                    <div style="margin-bottom: 20px; text-align: right;">
                        <form action="volunteerList.vo" method="get">
                            <select name="condition" style="padding: 5px;">
                                <option value="title" <c:if test="${condition eq 'title'}">selected</c:if>>제목</option>
                                <option value="address" <c:if test="${condition eq 'address'}">selected</c:if>>지역
                                </option>
                            </select>
                            <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요"
                                style="padding: 5px;">
                            <button type="submit" style="padding: 5px 10px; background-color: #333;">검색</button>
                        </form>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th width="10%">번호</th>
                                <th width="40%">제목</th>
                                <th width="15%">작성자</th>
                                <th width="20%">날짜</th>
                                <th width="15%">장소</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vo" items="${list}">
                                <tr>
                                    <td>${vo.actId}</td>

                                    <td style="text-align: left; font-weight: bold;">
                                        <a href="volunteerDetail.vo?actId=${vo.actId}">
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
                        </tbody>
                    </table>

                    <br>

                    <div align="right">
                        <a href="volunteerWriteForm.vo">
                            <button>+ 새 활동 등록하기</button>
                        </a>
                    </div>

            </body>

            </html>