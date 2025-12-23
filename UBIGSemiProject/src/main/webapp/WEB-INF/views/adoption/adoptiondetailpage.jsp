<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adoption-style.css">
		</head>

		<body>
			<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
			<c:if test="${not empty alertMsgAd}">
				<script>
					alert('${alertMsgAd}');
				</script>
				<c:remove var="alertMsgAd" scope="session" />
			</c:if>

			<div class="adoption-container">
				<h1 class="adoption-header">입양 디테일(동물) 페이지</h1>

				<div class="detail-image-container">
					<c:if test="${not empty animal.photoUrl}">
						<img src="${pageContext.request.contextPath}/resources/download/adoption/${animal.photoUrl}"
							class="detail-image" alt="ANIMAL PHOTO">
					</c:if>
				</div>

				<table class="detail-table">
					<tr>
						<th>동물 고유 번호</th>
						<td>${animal.animalNo}</td>
					</tr>

					<tr>
						<th>종류</th>
						<td>
							<c:choose>
								<c:when test="${animal.species eq 1}">강아지</c:when>
								<c:when test="${animal.species eq 2}">고양이</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose>
						</td>
					</tr>

					<tr>
						<th>이름</th>
						<td>${animal.animalName}</td>
					</tr>

					<tr>
						<th>품종</th>
						<td>${animal.breed}</td>
					</tr>

					<tr>
						<th>성별</th>
						<td>${animal.gender eq 1 ? '남아' : '여아'}</td>
					</tr>

					<tr>
						<th>나이</th>
						<td>${animal.age}세</td>
					</tr>

					<tr>
						<th>체중</th>
						<td>${animal.weight}kg</td>
					</tr>

					<tr>
						<th>크기</th>
						<td>${animal.petSize}</td>
					</tr>

					<tr>
						<th>중성화 여부</th>
						<td>${animal.neutered eq 1 ? '완료' : '미완료'}</td>
					</tr>

					<tr>
						<th>접종 상태</th>
						<td>${animal.vaccinationStatus}</td>
					</tr>

					<tr>
						<th>특이사항</th>
						<td>${animal.healthNotes}</td>
					</tr>

					<tr>
						<th>입양 상태</th>
						<td>${animal.adoptionStatus}</td>
					</tr>

					<tr>
						<th>입양 조건</th>
						<td>${animal.adoptionConditions}</td>
					</tr>

					<tr>
						<th>희망 지역</th>
						<td>${animal.hopeRegion}</td>
					</tr>

					<tr>
						<th>마감 기한</th>
						<td>${animal.deadlineDate}</td>
					</tr>
				</table>

				<!-- 입양 수정, 삭제는 관리자 또는 작성자만 가능 -->
				<div class="btn-group">
					<button id="updatepost" class="btn-secondary">(게시자 전용)수정</button>
					<button id="deletepost" class="btn-secondary">(게시자 전용)삭제</button>
					<button id="application" class="btn-primary">입양 신청 페이지로 이동</button>
				</div>
			</div>
		</body>

		<script>
			document.addEventListener("DOMContentLoaded", function () {
				const application = document.querySelector("#application");
				const updatepost = document.querySelector("#updatepost");
				const deletepost = document.querySelector("#deletepost");

				// 입양 신청페이지로 이동
				if (application) {
					application.addEventListener('click', function (e) {
						e.preventDefault();
						location.href = '${pageContext.request.contextPath}/adoption.applicationpage?anino=${animal.animalNo}';
					});
				}

				// (게시자가)수정
				if (updatepost) {
					updatepost.addEventListener('click', function (e) {
						e.preventDefault();
						location.href = '${pageContext.request.contextPath}/adoption.updateanimal?anino=${animal.animalNo}';
					});
				}

				// (게시자가)삭제
				if (deletepost) {
					deletepost.addEventListener('click', function (e) {
						e.preventDefault();
						if (confirm('정말 삭제하시겠습니까?')) {
							location.href = '${pageContext.request.contextPath}/adoption.deleteanimal?anino=${animal.animalNo}';
						}
					});
				}
			});

		</script>

		</html>