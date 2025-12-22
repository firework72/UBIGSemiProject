<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty alertMsgAd}">
	    <script>
	        alert('${alertMsgAd}');
	    </script>
	    <c:remove var="alertMsgAd" scope="session" />
	</c:if>
	
	
	<h1>입양 등록(관리자) 페이지 입니다.</h1>
	
	<form action="adoption.insert.board" method="POST">
	    <h3>[게시글 등록]</h3>
	
	    <label>게시물 제목 : </label>
	    <input type="text" name="postTitle" placeholder="제목을 입력하세요"><br>
	
	    <label>관리자 아이디 : </label>
	    <input type="text" name="userId" placeholder="ID 입력"><br>
	
	    <label>동물 고유 번호 : </label>
	    <input type="number" name="animalNo" placeholder="숫자만 입력"><br>
	    <br>
	    <input type="submit" value="게시글 등록하기" />
	</form>

</body>
</html>