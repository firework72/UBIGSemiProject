<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<style>
			body {
				font-family: sans-serif;
				margin: 0;
				padding: 20px;
			}

			h1 {
				text-align: center;
				margin-bottom: 30px;
			}

			.adoption-grid {
				display: grid;
				grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
				gap: 15px;
				max-width: 1200px;
				margin: 0 auto;
			}

			.adoption-card {
				border: 1px solid #ccc;
				background: white;
				cursor: pointer;
				display: flex;
				flex-direction: column;
				position: relative;
				/* For badge positioning */
			}

			.card-image-wrapper {
				width: 100%;
				aspect-ratio: 1 / 1;
				overflow: hidden;
				background-color: #eee;
				position: relative;
			}

			.card-image {
				width: 100%;
				height: 100%;
				object-fit: cover;
				display: block;
			}

			/* Status Badge */
			.status-badge {
				position: absolute;
				top: 10px;
				right: 10px;
				background-color: rgba(0, 0, 0, 0.6);
				color: white;
				padding: 4px 8px;
				font-size: 12px;
				border-radius: 4px;
				font-weight: bold;
			}

			.card-content {
				padding: 10px;
				text-align: center;
			}

			.card-title {
				font-size: 1rem;
				font-weight: bold;
				margin: 0;
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;
			}

			#paging {
				text-align: center;
				margin-top: 30px;
				margin-bottom: 30px;
			}

			button {
				padding: 5px 10px;
				cursor: pointer;
			}

			#enroll {
				display: block;
				margin: 0 auto;
				padding: 10px 20px;
			}
		</style>
		</head>

		<body>

			<c:if test="${not empty alertMsgAd}">
				<script>
					alert('${alertMsgAd}');
				</script>
				<c:remove var="alertMsgAd" scope="session" />
			</c:if>

			<h1>입양 친구들을 소개합니다</h1>

			<div class="adoption-grid" id="adoptionGrid">
				<c:choose>
					<c:when test="${adoptionList.size() eq 0}">
						<div style="grid-column: 1 / -1; text-align: center; padding: 20px;">
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
									<div class="card-title">${item.postTitle}</div>
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
						<button disabled>&lt;</button>
					</c:when>
					<c:otherwise>
						<button class="prev-btn">&lt;</button>
					</c:otherwise>
				</c:choose>

				<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
					<c:choose>
						<c:when test="${p eq pi.currentPage}">
							<button style="font-weight: bold;">${p}</button>
						</c:when>
						<c:otherwise>
							<button>${p}</button>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${pi.currentPage >= pi.maxPage}">
						<button disabled>&gt;</button>
					</c:when>
					<c:otherwise>
						<button class="next-btn">&gt;</button>
					</c:otherwise>
				</c:choose>
			</div>

			<button id="enroll">입양 글 등록하기</button>
		</body>

		<script>
			document.addEventListener("DOMContentLoaded", function () {
				const adInsert = document.querySelector("#enroll");
				const adoptionGrid = document.querySelector("#adoptionGrid");
				const paging = document.querySelector("#paging");

				// 입양 디테일 페이지 이동 (이벤트 위임)
				adoptionGrid.addEventListener('click', function (e) {
					const card = e.target.closest('.adoption-card');

					if (card && card.dataset.anino) {
						const aniNo = card.dataset.anino;
						location.href = 'adoption.detailpage?anino=' + aniNo;
					}
				});

				// 입양 등록 페이지로 이동
				adInsert.addEventListener('click', function () {
					location.href = 'adoption.enrollpage';
				});

				// 페이징 처리
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

						// 현재 페이지가 숫자가 아닌 경우 (화살표 등) 방지 로직 필요하나
						// 위에서 prev/next 클래스로 처리했으므로 숫자 버튼만 남음
						if (!isNaN(page)) {
							location.href = 'adoption.mainpage?page=' + page;
						}
					}
				});
			});
		</script>

		</html>