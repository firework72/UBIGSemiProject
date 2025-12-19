<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사활동 등록</title>
</head>
<body>

    <h2>새로운 봉사활동 등록</h2>

    <form action="volunteerInsert.vo" method="post">
        <table border="1">
            <tr>
                <th>작성자 ID</th>
                <td><input type="text" name="adminId" value="admin1" readonly></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="actTitle" required placeholder="제목을 입력하세요"></td>
            </tr>
            <tr>
                <th>장소</th>
                <td><input type="text" name="actAddress" required placeholder="장소를 입력하세요"></td>
            </tr>
            <tr>
                <th>참여 인원</th>
                <!-- min으로 최소인원 5명으로 제한 걸어놨음, max를 안넣음으로서 속성 제한 풀어놨음(전체회원) -->
				<td><input type="number" name="actMax" min="5" value="10"
					placeholder="최소 5명"></td>
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

</body>
</html>