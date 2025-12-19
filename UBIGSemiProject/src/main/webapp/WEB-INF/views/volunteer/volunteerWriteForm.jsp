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
                <th>최대 인원</th>
                <td><input type="number" name="actMax" value="10"></td>
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