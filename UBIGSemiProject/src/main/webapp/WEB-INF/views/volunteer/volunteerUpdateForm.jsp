<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사활동 수정</title>
</head>
<body>

	<h2>봉사활동 게시글 수정</h2>

	<form action="volunteerUpdate.vo" method="post">
		<input type="hidden" name="actId" value="${vo.actId}">

		<table border="1">
			<tr>
				<th>작성자 ID</th>
				<td>${vo.adminId} (수정불가)</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="actTitle" value="${vo.actTitle}" required></td>
			</tr>
			<tr>
				<th>장소</th>
				<td><input type="text" name="actAddress" value="${vo.actAddress}" required></td>
			</tr>
			<tr>
				<th>최대 인원</th>
				<td><input type="number" name="actMax" min="5" value="${vo.actMax}"></td>
			</tr>
			<tr>
				<th>참가비</th>
				<td>10,000원 (고정)</td>
			</tr>
		</table>

		<br>
		<button type="submit">수정 완료</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>

</body>
</html>