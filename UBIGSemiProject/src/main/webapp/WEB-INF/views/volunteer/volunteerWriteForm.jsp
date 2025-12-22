<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사활동 등록</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

	<h2>새로운 봉사활동 등록</h2>

	<form action="volunteerInsert.vo" method="post">
		<input type="hidden" name="adminId" value="admin1"> 
		
		<table border="1">
			<tr>
				<th>작성자 ID</th>
				<td>admin1 (자동입력)</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="actTitle" required placeholder="제목을 입력하세요"></td>
			</tr>
			<tr>
				<th>장소</th>
				<td>
					<input type="text" name="actAddress" id="address" placeholder="주소 검색 버튼을 클릭하세요" size="40" required readonly>
					<button type="button" onclick="execDaumPostcode()">🔍 주소 검색</button>
				</td>
			</tr>
			<tr>
				<th>참여 인원</th>
				<td><input type="number" name="actMax" min="5" value="10" placeholder="최소 5명"></td>
			</tr>
			<tr>
				<th>봉사 시작일</th>
				<td><input type="date" name="actDate" required></td>
			</tr>
			<tr>
				<th>봉사 종료일</th>
				<td><input type="date" name="actEnd" required></td>
			</tr>
			<tr>
				<th>참가비</th>
				<td>10,000원(고정)</td>
			</tr>
		</table>

		<br>
		<button type="submit">등록하기</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
	
	<script>
		// 우편번호 찾기 기능 (지도 기능은 뺐습니다!)
		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 1. 주소 선택 시 입력칸에 넣기
					document.getElementById("address").value = data.address;
				}
			}).open();
		}
	</script>

</body>
</html>