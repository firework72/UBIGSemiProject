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
                                <th>체중</th>
                                <th>크기</th>
                                <th>중성화</th>
                                <th>접종</th>
                                <th>건강상태</th>
                                <th>입양상태</th>
                                <th>입양조건</th>
                                <th>지역</th>
                                <th>마감일</th>
                                <th>사진</th>
                                <th style="min-width: 150px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="18" align="center">등록된 동물이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="item" items="${list}">
                                        <tr>
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
                                            <td>${item.weight}kg</td>
                                            <td>${item.petSize}</td>
                                            <td>${item.neutered eq 1 ? '완료' : '미완료'}</td>
                                            <td>${item.vaccinationStatus}</td>
                                            <td>
                                                <div
                                                    style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                    ${item.healthNotes}</div>
                                            </td>
                                            <td>${item.adoptionStatus}</td>
                                            <td>
                                                <div
                                                    style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                    ${item.adoptionConditions}</div>
                                            </td>
                                            <td>${item.hopeRegion}</td>
                                            <td>${item.deadlineDate}</td>
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
                                                    <button type="button" class="btn-primary"
                                                        style="padding: 5px 10px; font-size: 0.8rem;"
                                                        onclick="location.href='adoption.enrollpagepost?anino=${item.animalNo}'">게시글
                                                        등록</button>
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