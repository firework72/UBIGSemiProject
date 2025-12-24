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
						<input type="hidden" name="signsId" value="${loginMember.userId}">

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

				<script>
					$(function () {
						var msg = "${sessionScope.alertMsg}";
						if (msg != null && msg !== "") {
							alert(msg);
                <% session.removeAttribute("alertMsg"); %>
            }
					});

					function deleteAction() {
						if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
							location.href = "volunteerDelete.vo?actId=${vo.actId}";
						}
					}
				</script>
			</body>

			</html>