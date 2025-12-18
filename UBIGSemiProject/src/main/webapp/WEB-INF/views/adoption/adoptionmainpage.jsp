<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>입양 메인 페이지</h1>
	<button id="detail">입양 디테일 페이지</button><br>
	<button id="enroll">입양 등록 페이지(관리자만 활성화)</button>
</body>
<script>
	document.addEventListener("DOMContentLoaded",function(){
		//element 가져오기
		const adList = document.querySelector("#detail");
		const adInsert = document.querySelector("#enroll");
		
		//입양디테일 페이지 이동
		adList.addEventListener('click',function(){
			location.href = 'adoption.detailpage';
		});
		
		//입양 등록페이지로이동
		adInsert.addEventListener('click',function(){
			location.href = 'adoption.enrollpage';
		});

	});
</script>
</html>