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
		
		 <a
			href="volunteerUpdateForm.vo?actId=${vo.actId}">
			<button>수정</button>
		</a>
		<button onclick="deleteAction()">삭제</button>
	</div>
	
	<script>
		function deleteAction() {
			// 1. 정말 지울 건지 물어보기 (확인/취소)
			if(confirm("정말로 이 글을 삭제하시겠습니까?")) {
				
				// 2. '확인' 누르면 삭제 진행 (컨트롤러로 actId를 보냄)
				location.href = "volunteerDelete.vo?actId=${vo.actId}";
			}
			// '취소' 누르면 아무 일도 안 일어남
		}
	</script>

</body>
</html>