<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>봉사활동 상세</title>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
				<style>
					/* 간단한 스타일 정리 */
					body {
						font-family: 'Malgun Gothic', sans-serif;
						padding: 20px;
					}

					table {
						border-collapse: collapse;
						margin-bottom: 20px;
					}

					th,
					td {
						padding: 10px;
						border: 1px solid #ddd;
					}

					th {
						background-color: #f0f0f0;
						width: 100px;
						text-align: center;
					}

					td {
						width: 400px;
					}

					.btn-area {
						text-align: center;
						margin-top: 20px;
					}

					button {
						cursor: pointer;
						padding: 5px 10px;
					}
				</style>
			</head>

			<body>

				<h2>봉사활동 상세 정보</h2>

				<table>
					<tr>
						<th>제목</th>
						<td>${vo.actTitle}</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${vo.adminId}</td>
					</tr>
					<tr>
						<th>날짜</th>
						<td>
							<fmt:formatDate value="${vo.actDate}" pattern="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>장소</th>
						<td>${vo.actAddress}</td>
					</tr>
					<tr>
						<th>참가비</th>
						<td>
							<fmt:formatNumber value="${vo.actMoney}" type="currency" currencySymbol="￦" />
						</td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td>${vo.actMax} 명</td>
					</tr>
				</table>

				<div style="padding: 15px; border: 1px solid #ddd; background-color: #f9f9f9; width: 500px;">
					<h3>📢 참여 신청</h3>

					<form action="volunteerSign.vo" method="post" style="display: inline-block;">
						<input type="hidden" name="actId" value="${vo.actId}">
						<input type="hidden" name="signsId" value="admin1">

						<button type="submit"
							style="padding: 10px 20px; background-color: #007bff; color: white; border: none; font-weight: bold;">
							✋ 지금 바로 신청하기
						</button>
					</form>

					<a href="signList.vo?actId=${vo.actId}"
						style="margin-left: 10px; padding: 10px 20px; background-color: #28a745; color: white; text-decoration: none; display: inline-block;">
						👥 신청자 현황 보기 (${vo.actCur}/${vo.actMax}명)
					</a>
				</div>

				<div class="btn-area">
					<a href="volunteerList.vo"><button>목록으로</button></a>
					<a href="volunteerUpdateForm.vo?actId=${vo.actId}"><button>수정</button></a>
					<button onclick="deleteAction()">삭제</button>
				</div>

				<hr style="margin: 30px 0;">

				<div style="width: 800px;">
					<h3>💬 봉사활동 댓글</h3>

					<div style="background: #eee; padding: 15px; border-radius: 5px;">
						<strong>작성자: admin1</strong>
						<textarea id="replyContent" style="width: 100%; height: 50px; margin-top: 5px;"
							placeholder="내용을 입력하세요"></textarea>
						<button onclick="addReply()" style="float: right; margin-top: 5px;">등록</button>
						<div style="clear: both;"></div>
					</div>

					<div id="replyArea" style="margin-top: 20px;">
					</div>
				</div>

				<hr style="margin: 30px 0;">

				<div style="width: 800px;">
					<h3>⭐ 참여 후기 (${reviewList.size()}개)</h3>

					<div style="background: #f9f9f9; padding: 20px; border: 1px solid #eee; border-radius: 5px;">
						<form action="insertReview.vo" method="post">
							<input type="hidden" name="actId" value="${vo.actId}">
							<input type="hidden" name="rId" value="admin1">

							<div style="margin-bottom: 10px;">
								<strong>별점:</strong>
								<select name="rRate" style="padding: 5px;">
									<option value="5">⭐⭐⭐⭐⭐ (5점)</option>
									<option value="4">⭐⭐⭐⭐ (4점)</option>
									<option value="3">⭐⭐⭐ (3점)</option>
									<option value="2">⭐⭐ (2점)</option>
									<option value="1">⭐ (1점)</option>
								</select>
							</div>
							<textarea name="rReview" style="width: 100%; height: 60px;"
								placeholder="후기를 남겨주세요!"></textarea>
							<div style="text-align: right; margin-top: 10px;">
								<button type="submit"
									style="background-color: #ffc107; border: none; padding: 8px 20px; font-weight: bold;">후기
									등록</button>
							</div>
						</form>
					</div>

					<div style="margin-top: 30px;">
						<c:choose>
							<c:when test="${empty reviewList}">
								<p style="text-align: center; color: #999;">아직 등록된 후기가 없습니다.</p>
							</c:when>
							<c:otherwise>
								<c:forEach var="r" items="${reviewList}">
									<div style="border-bottom: 1px solid #eee; padding: 15px 0;">
										<div style="display: flex; justify-content: space-between;">
											<div>
												<span style="color: #ffc107;">
													<c:forEach begin="1" end="${r.rRate}">⭐</c:forEach>
												</span>
												<strong>${r.rId}</strong>
											</div>
											<span style="font-size: 12px; color: #888;">
												<fmt:formatDate value="${r.rCreate}" pattern="yyyy-MM-dd" />
											</span>
										</div>
										<p style="margin-top: 10px; color: #555;">${r.rReview}</p>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<br><br><br>

				<script>
					// 페이지 로딩 시 댓글 목록 가져오기 & 알림창 체크
					$(function () {
						selectReplyList(); // 댓글 불러오기

						// 알림 메시지 체크
						var msg = "${sessionScope.alertMsg}";
						if (msg != null && msg !== "") {
							alert(msg);
							session.removeAttribute("alertMsg");
						}
					});

					// 삭제 확인
					function deleteAction() {
						if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
							location.href = "volunteerDelete.vo?actId=${vo.actId}";
						}
					}

					// --- AJAX 댓글 기능 ---
					function selectReplyList() {
						var actId = "${vo.actId}";
						$.ajax({
							url: "replyList.vo",
							data: { actId: actId },
							success: function (list) {
								var value = "";
								if (list.length == 0) {
									value += "<p>등록된 댓글이 없습니다.</p>";
								} else {
									for (var i in list) {
										value += "<div style='border-bottom: 1px solid #ddd; padding: 10px;'>";
										value += "   <b>" + list[i].userId + "</b> ";
										value += "   <span style='font-size: 12px; color: gray;'>" + list[i].cmtDate + "</span>";
										value += "   <button onclick='deleteReply(" + list[i].cmtNo + ")' style='float:right; font-size:11px; color:red;'>삭제</button>";
										value += "   <p style='margin-top: 5px;'>" + list[i].cmtAnswer + "</p>";
										value += "</div>";
									}
								}
								$("#replyArea").html(value);
							},
							error: function () { console.log("댓글 조회 실패"); }
						});
					}

					function addReply() {
						var content = $("#replyContent").val();
						if (content.trim() == "") { alert("내용을 입력해주세요!"); return; }

						$.ajax({
							url: "insertReply.vo",
							data: { actId: "${vo.actId}", userId: "admin1", cmtAnswer: content },
							success: function (result) {
								if (result == "success") {
									alert("댓글 등록 성공!");
									$("#replyContent").val("");
									selectReplyList();
								} else { alert("댓글 등록 실패"); }
							}
						});
					}

					function deleteReply(cmtNo) {
						if (confirm("삭제하시겠습니까?")) {
							$.ajax({
								url: "deleteReply.vo",
								data: { cmtNo: cmtNo },
								success: function (result) {
									if (result == "success") selectReplyList();
									else alert("삭제 실패");
								}
							});
						}
					}
				</script>

			</body>

			</html>