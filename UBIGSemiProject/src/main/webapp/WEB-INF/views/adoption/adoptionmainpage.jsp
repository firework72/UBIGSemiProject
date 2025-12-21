<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
		</head>

		<body>
			<h1>입양 메인 페이지</h1>

			<div>
				<table border="1" id="table">
					<tr>
						<td>게시물 고유 번호</td>
						<td>게시물 제목</td>
						<td>동물 사진</td>
						<td>게시물 수정일</td>
						<td>게시물 조회수</td>
					</tr>
					<c:choose>
						<c:when test="${adoptionList.size() eq 0}">
							<tr>
								<td colspan="5">게시글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${adoptionList}">
								<tr data-anino="${item.animalNo}">
									<td>${item.postNo}</td>
									<td>${item.postTitle}</td>
									<td>
										<img src="${pageContext.request.contextPath}/resources/download/adoption/${item.photoUrl}"
											width="100" height="100">
									</td>
									<td>${item.postUpdateDate}</td>
									<td>${item.views}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				<!-- 페이징 -->
				<div id="paging">
					<c:choose>
						<c:when test="${pi.currentPage eq 1}">
							<button disabled>이전</button>
						</c:when>
						<c:otherwise>
							<button>이전</button>
						</c:otherwise>
					</c:choose>
					<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
						<button>${p}</button>
					</c:forEach>
					<c:choose>
						<c:when test="${pi.currentPage > pi.maxPage}">
							<button disabled>다음</button>
						</c:when>
						<c:otherwise>
							<button>다음</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<button id="enroll">입양 등록 페이지(관리자만 활성화- 관리자 페이지에 있을듯?)</button>
		</body>
		<script>
			document.addEventListener("DOMContentLoaded", function () {
				//element 가져오기
				const adInsert = document.querySelector("#enroll");
				const table = document.querySelector("#table");
				const paging = document.querySelector("#paging");

				//입양디테일 페이지 이동
				table.addEventListener('click', function (e) {
					const tr = e.target.closest('tr');

					if (tr && tr.dataset.anino) {
						const aniNo = tr.dataset.anino;
						location.href = 'adoption.detailpage?anino=' + aniNo;
					}
				});

				//입양 등록페이지로이동
				adInsert.addEventListener('click', function () {
					location.href = 'adoption.enrollpage';
				});

				//페이징 처리
				paging.addEventListener('click', function (e) {
					const btn = e.target;
					if (btn.tagName === "button") {
						const page = btn.textContent;
						location.href = 'adoption.mainpage?page=' + page;
					}
				});

			});
		</script>

		</html>