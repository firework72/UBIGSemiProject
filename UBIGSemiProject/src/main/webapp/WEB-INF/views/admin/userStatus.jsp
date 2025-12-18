<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<td>
	    <c:choose>
	        <c:when test="${user.status == 'ACTIVE'}">
	            <button class="btn btn-sm btn-danger" onclick="changeStatus('${user.id}', 'BANNED')">정지</button>
	        </c:when>
	        <c:otherwise>
	            <button class="btn btn-sm btn-success" onclick="changeStatus('${user.id}', 'ACTIVE')">해제</button>
	        </c:otherwise>
	    </c:choose>
	</td>

	<script>
	function changeStatus(userId, status) {
	    if(!confirm("해당 사용자의 상태를 변경하시겠습니까?")) return;
	
	    fetch('/admin/user/status', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify({ id: userId, status: status })
	    }).then(res => {
	        if(res.ok) location.reload(); // 성공 시 새로고침
	        else alert("처리에 실패했습니다.");
	    });
	}
	</script>
</body>
</html>