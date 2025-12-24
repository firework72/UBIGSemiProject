<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>UBIG - 입양 친구들 소개</title>
			<!-- Global Style -->
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
			<!-- Adoption Specific Style -->
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
				<h1 class="adoption-header">입양 친구들을 소개합니다</h1>

				<div class="adoption-grid" id="adoptionGrid">
					<c:choose>
						<c:when test="${adoptionList.size() eq 0}">
							<div style="grid-column: 1 / -1; text-align: center; padding: 40px;">
								<p>등록된 게시글이 없습니다.</p>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${adoptionList}">
								<div class="adoption-card" data-anino="${item.animalNo}">
									<div class="card-image-wrapper">
										<img src="${pageContext.request.contextPath}/resources/download/adoption/${item.photoUrl}"
											class="card-image" alt="사진">
										<!-- 입양 상태 표시 -->
										<c:if test="${not empty item.adoptionStatus}">
											<span class="status-badge">${item.adoptionStatus}</span>
										</c:if>
									</div>
									<div class="card-content">
										<div class="card-title">${item.animalName}</div>
										<div class="card-details">
											나이: ${item.animalAge}세<br>
											성별: ${item.animalGender}<br>
											몸무게: ${item.animalWeight}kg<br>
											지역: ${item.hopeRegion}
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- 페이징 -->
				<div id="paging">
					<c:choose>
						<c:when test="${pi.currentPage eq 1}">
							<button class="pagination-btn" disabled>&lt;</button>
						</c:when>
						<c:otherwise>
							<button class="pagination-btn prev-btn">&lt;</button>
						</c:otherwise>
					</c:choose>

					<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
						<c:choose>
							<c:when test="${p eq pi.currentPage}">
								<button class="pagination-btn active">${p}</button>
							</c:when>
							<c:otherwise>
								<button class="pagination-btn">${p}</button>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${pi.currentPage >= pi.maxPage}">
							<button class="pagination-btn" disabled>&gt;</button>
						</c:when>
						<c:otherwise>
							<button class="pagination-btn next-btn">&gt;</button>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="btn-group">
					<button id="enroll" class="btn-primary">입양 글 등록하기</button>
					<button id="postManage" class="btn-secondary">입양 글 관리하기(관리자 전용)</button>
				</div>
			</div>

		</body>

		<script>
			document.addEventListener("DOMContentLoaded", function () {
				const adInsert = document.querySelector("#enroll");
				const paging = document.querySelector("#paging");
				const postManage = document.querySelector("#postManage"); // Added this line

				// 입양 디테일 페이지 이동 (이벤트 위임) - Using closer to pure JS or keeping existing logic
				const adoptionGrid = document.querySelector("#adoptionGrid");
				if (adoptionGrid) {
					adoptionGrid.addEventListener('click', function (e) {
						const card = e.target.closest('.adoption-card');

						if (card && card.dataset.anino) {
							const aniNo = card.dataset.anino;
							location.href = 'adoption.detailpage?anino=' + aniNo;
						}
					});
				}

				// 입양동물 등록 페이지로 이동
				if (adInsert) {
					adInsert.addEventListener('click', function () {
						location.href = 'adoption.enrollpageanimal';
					});
				}

				//입양 관리 페이지로 이동
				if (postManage) {
					postManage.addEventListener('click', function () {
						location.href = 'adoption.postmanage';
					});
				}


				// 페이징 처리
				if (paging) {
					paging.addEventListener('click', function (e) {
						const btn = e.target;
						if (btn.tagName === "BUTTON" && !btn.disabled) {
							let page = btn.textContent;
							const currentPage = parseInt('${pi.currentPage}');

							// 이전/다음 버튼 처리
							if (btn.classList.contains("prev-btn")) {
								page = currentPage - 1;
							} else if (btn.classList.contains("next-btn")) {
								page = currentPage + 1;
							}

							if (!isNaN(page)) {
								location.href = 'adoption.mainpage?page=' + page;
							}
						}
					});
				}
			});
		</script>

		</html>