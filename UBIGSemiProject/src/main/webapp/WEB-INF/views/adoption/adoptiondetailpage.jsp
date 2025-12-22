<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
		</head>

		<body>

			<c:if test="${not empty alertMsgAd}">
				<script>
					alert('${alertMsgAd}');
				</script>
				<c:remove var="alertMsgAd" scope="session" />
			</c:if>

			<h1>입양 디테일(동물)페이지 입니다.</h1>
			<div align="center">
				<table border="1">
					<c:if test="${not empty animal.photoUrl}">
						<tr align="center">
							<td colspan="2">
								<img src="${pageContext.request.contextPath}/resources/download/adoption/${animal.photoUrl}"
									alt="ANIMAL PHOTO" width="300">
							</td>
						</tr>
					</c:if>

					<tr align="center">
						<th width="150">동물 고유 번호</th>
						<td>${animal.animalNo}</td>
					</tr>

					<tr align="center">
						<th>종류</th>
						<td>
							<c:choose>
								<c:when test="${animal.species eq 1}">강아지</c:when>
								<c:when test="${animal.species eq 2}">고양이</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose>
						</td>
					</tr>

					<tr align="center">
						<th>이름</th>
						<td>${animal.animalName}</td>
					</tr>

					<tr align="center">
						<th>품종</th>
						<td>${animal.breed}</td>
					</tr>

					<tr align="center">
						<th>성별</th>
						<td>${animal.gender eq 1 ? '남아' : '여아'}</td>
					</tr>

					<tr align="center">
						<th>나이</th>
						<td>${animal.age}세</td>
					</tr>

					<tr align="center">
						<th>체중</th>
						<td>${animal.weight}kg</td>
					</tr>

					<tr align="center">
						<th>크기</th>
						<td>${animal.petSize}</td>
					</tr>

					<tr align="center">
						<th>중성화 여부</th>
						<td>${animal.neutered eq 1 ? '완료' : '미완료'}</td>
					</tr>

					<tr align="center">
						<th>접종 상태</th>
						<td>${animal.vaccinationStatus}</td>
					</tr>

					<tr align="center">
						<th>특이사항</th>
						<td>${animal.healthNotes}</td>
					</tr>

					<tr align="center">
						<th>입양 상태</th>
						<td>${animal.adoptionStatus}</td>
					</tr>

					<tr align="center">
						<th>입양 조건</th>
						<td>${animal.adoptionConditions}</td>
					</tr>

					<tr align="center">
						<th>희망 지역</th>
						<td>${animal.hopeRegion}</td>
					</tr>

					<tr align="center">
						<th>마감 기한</th>
						<td>${animal.deadlineDate}</td>
					</tr>
				</table>
			</div>
			<!-- 입양 수정, 삭제는 관리자 또는 작성자만 가능 -->
			<button id="updatepost">(게시자 전용)수정</button>
			<button id="deletepost">(게시자 전용)삭제</button>
			<button id="application">입양 신청 페이지로 이동(유저가 이용가능한 기능)</button>
		</body>

		<script>
			document.addEventListener("DOMContentLoaded", function () {
				const application = document.querySelector("#application");
				const updatepost = document.querySelector("#updatepost");
				const deletepost = document.querySelector("#deletepost");

				// 입양 신청페이지로 이동
				application.addEventListener('click', function (e) {
					e.preventDefault();
					location.href = '${pageContext.request.contextPath}/adoption.applicationpage?anino=${animal.animalNo}';
				});

				// (게시자가)수정
				updatepost.addEventListener('click', function (e) {
					e.preventDefault();
					location.href = '${pageContext.request.contextPath}/adoption.updateanimal?anino=${animal.animalNo}';
				});

				// (게시자가)삭제
				deletepost.addEventListener('click', function (e) {
					e.preventDefault();
					location.href = '${pageContext.request.contextPath}/adoption.deleteanimal?anino=${animal.animalNo}';
				});
			});

		</script>

		</html>