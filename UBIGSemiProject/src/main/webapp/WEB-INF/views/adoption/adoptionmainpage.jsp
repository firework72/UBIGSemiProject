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
	<h1>입양 메인 페이지</h1>
	
	<div>
		<table border="1" id="table">
				<tr>
					<td>게시물 고유 번호</td>
					<td>게시물 제목</td>
					<td>동물 사진</td>
					<td>게시물 수정일</td>
					<td>게시물 조회수</td>
				</tr>
			<c:forEach var="post" items="${postList}">
			    <tr data-anino="${post.animalNo }">
			        <td>${post.postNo}</td>
			        <td>${post.postTitle}</td>
					<td>
		                <c:forEach var="ani" items="${animalList}">
		                    <c:if test="${post.animalNo eq ani.animalNo}">
		                        <img src="${pageContext.request.contextPath}/resources/download/adoption/${ani.photoUrl}" width="100" height="100">
		                    </c:if>
		                </c:forEach>
           			</td>
			        <td>${post.postUpdateDate }</td>
			        <td>${post.views}</td>
			    </tr>
			</c:forEach>
		</table>
	</div>
	
	<button id="enroll">입양 등록 페이지(관리자만 활성화- 관리자 페이지에 있을듯?)</button>
</body>
<script>
	document.addEventListener("DOMContentLoaded",function(){
		//element 가져오기
		const adInsert = document.querySelector("#enroll");
		const table = document.querySelector("#table");
		
		//입양디테일 페이지 이동
		table.addEventListener('click',function(e){
			const tr = e.target.closest('tr');
			
			if(tr&& tr.dataset.anino){
				const aniNo = tr.dataset.anino;
				location.href = 'adoption.detailpage?anino=' + aniNo;
			}
		});
		
		//입양 등록페이지로이동
		adInsert.addEventListener('click',function(){
			location.href = 'adoption.enrollpage';
		});

	});
</script>
</html>