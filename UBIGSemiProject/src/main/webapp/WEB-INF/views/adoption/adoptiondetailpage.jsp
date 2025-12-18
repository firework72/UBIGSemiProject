<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>입양 디테일(동물)페이지 입니다.</h1>
	<button id="application">입양 신청 페이지로 이동</button>
</body>
<script>
document.addEventListener("DOMContentLoaded",function(){
	const application = document.querySelector("#application");
	
	application.addEventListener('click',function(){
		location.href = 'adoption.applicationpage'
	})
});

</script>
</html>