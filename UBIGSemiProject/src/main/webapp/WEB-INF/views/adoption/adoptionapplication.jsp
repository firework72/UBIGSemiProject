<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
        <h1>입양 신청서 작성</h1>
        
        <form action="adoption.insertapplication" method="post">
        
            <table border="1">
                
                <tr align="center">
                    <th bgcolor="#f2f2f2" width="150">동물 고유 번호</th>
                    <td>
                        <input type="number" name="animalNo" value="${param.anino}" readonly style="width:100%; border:none; text-align:center;">
                    </td>
                </tr>

                <tr align="center">
                    <th bgcolor="#f2f2f2">신청자 ID</th>
                    <td>
                        <input type="text" name="userId" placeholder="ID를 입력하세요" required style="width:100%; text-align:center;">
		                <input type="hidden" name="adoptStatus" value="1">
                    </td>
                </tr>


            </table>

            <br>
            
            <button type="submit">신청하기</button>
            <button type="button" onclick="history.back()">취소</button>
            
        </form>
        </div>
</body>
</html>