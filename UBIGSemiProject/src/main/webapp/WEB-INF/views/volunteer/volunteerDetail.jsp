<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사활동 상세</title>
</head>
<body>

	<h2>봉사활동 상세 정보</h2>

	<table border="1">
		<tr>
			<th width="100">제목</th>
			<td width="400">${vo.actTitle}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${vo.adminId}</td>
		</tr>
		<tr>
			<th>날짜</th>
			<td><fmt:formatDate value="${vo.actDate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<th>장소</th>
			<td>${vo.actAddress}</td>
		</tr>
		<tr>
			<th>참가비</th>
			<td><fmt:formatNumber value="${vo.actMoney}" type="currency" currencySymbol="￦"/></td>
		</tr>
		<tr>
			<th>모집인원</th>
			<td>${vo.actMax} 명</td>
		</tr>
	</table>

	<br>
	
	<div align="center">
		<a href="volunteerList.vo"><button>목록으로</button></a>
		
		<button onclick="alert('준비중입니다')">수정</button>
		<button onclick="alert('준비중입니다')">삭제</button>
	</div>

</body>
</html>