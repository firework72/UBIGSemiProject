<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>UBIG - 입양 동물 관리</title>
            <!-- Global Style -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
            <!-- Adoption Specific Style -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adoption-style.css">
        </head>

        <body>
            <jsp:include page="/WEB-INF/views/common/menubar.jsp" />
            <div class="adoption-container">
                <h1 class="adoption-header">동물 관리</h1>

                <div style="overflow-x: auto;">
                    <table class="adoption-table">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="allCheck"></th>
                                <th>번호</th>
                                <th>이름</th>
                                <th>종류</th>
                                <th>품종</th>
                                <th>성별</th>
                                <th>나이</th>
                                <th>입양상태</th>
                                <th>지역</th>
                                <th>사진</th>
                                <th style="min-width: 150px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="11" align="center">등록된 동물이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="item" items="${list}">
                                        <tr onclick="location.href='adoption.detailpage?anino=${item.animalNo}'">
                                            <td><input type="checkbox" name="animalNo" value="${item.animalNo}"></td>
                                            <td>${item.animalNo}</td>
                                            <td>${item.animalName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.species eq 1}">강아지</c:when>
                                                    <c:when test="${item.species eq 2}">고양이</c:when>
                                                    <c:otherwise>기타</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${item.breed}</td>
                                            <td>${item.gender eq 1 ? '남아' : '여아'}</td>
                                            <td>${item.age}살</td>
                                            <td>${item.adoptionStatus}</td>
                                            <td>${item.hopeRegion}</td>
                                            <td><img src="${pageContext.request.contextPath}/resources/download/adoption/${item.photoUrl}"
                                                    alt="동물 사진" width="50" height="50"></td>
                                            <td>
                                                <div style="display: flex; gap: 5px; flex-direction: column;">
                                                    <button type="button" class="btn-secondary"
                                                        style="padding: 5px 10px; font-size: 0.8rem;"
                                                        onclick="location.href='adoption.updateanimal?anino=${item.animalNo}'">수정</button>
                                                    <button type="button" class="btn-secondary"
                                                        style="padding: 5px 10px; font-size: 0.8rem;"
                                                        onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='adoption.deleteanimal?anino=${item.animalNo}'">삭제</button>

                                                    <c:if test="${item.postNo eq 0 && item.adoptionStatus ne '반려'}">
                                                        <button type="button" class="btn-primary"
                                                            style="padding: 5px 10px; font-size: 0.8rem;"
                                                            onclick="if(confirm('게시글을 등록하시겠습니까?')) location.href='adoption.insert.board.direct?anino=${item.animalNo}'">게시글
                                                            등록</button>
                                                        <button type="button" class="btn-primary"
                                                            style="padding: 5px 10px; font-size: 0.8rem;"
                                                            onclick="if(confirm('게시글을 반려하시겠습니까?')) location.href='adoption.deny.board.direct?anino=${item.animalNo}'">등록
                                                            반려</button>
                                                    </c:if>
                                                    <c:if test="${item.postNo ne 0 && item.adoptionStatus ne '반려'}">
                                                        <span
                                                            style="font-size: 0.8rem; color: green; text-align: center;">등록됨</span>
                                                    </c:if>
                                                    <c:if test="${item.adoptionStatus eq '반려'}">
                                                        <span
                                                            style="font-size: 0.8rem; color: red; text-align: center;">등록
                                                            반려</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <script>
                document.getElementById('allCheck').addEventListener('click', function () {
                    var checks = document.getElementsByName('animalNo');
                    for (var i = 0; i < checks.length; i++) {
                        checks[i].checked = this.checked;
                    }
                });
            </script>
        </body>

        </html>