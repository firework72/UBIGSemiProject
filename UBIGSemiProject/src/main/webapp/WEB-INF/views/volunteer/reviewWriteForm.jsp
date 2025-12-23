<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사 후기 작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<style>
    /* 후기 작성 폼 전용 스타일 */
    body { font-family: 'Pretendard', sans-serif; background-color: #f8f9fa; padding: 20px; }
    .container { width: 800px; margin: 50px auto; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
    h2 { text-align: center; margin-bottom: 30px; color: #333; }
    
    .form-group { margin-bottom: 20px; }
    label { display: block; font-weight: bold; margin-bottom: 8px; color: #555; }
    select, input, textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
    textarea { height: 200px; resize: vertical; }
    
    .btn-area { text-align: center; margin-top: 30px; }
    button { padding: 12px 30px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; font-size: 16px; }
    .btn-submit { background-color: #ffc107; color: white; }
    .btn-cancel { background-color: #6c757d; color: white; margin-left: 10px; }
</style>
</head>
<body>

    <jsp:include page="../common/menubar.jsp" />

    <div class="container">
        <h2>✍️ 봉사활동 후기 작성</h2>
        
        <form action="insertReview.vo" method="post">
            <input type="hidden" name="rId" value="admin1"> 
            
            <div class="form-group">
                <label>어떤 봉사활동을 하셨나요?</label>
                <select name="actId" required>
                    <option value="">봉사활동을 선택해주세요</option>
                    <c:forEach var="a" items="${actList}">
                        <option value="${a.actId}">[${a.actDate}] ${a.actTitle}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>평점</label>
                <select name="rRate">
                    <option value="5">⭐⭐⭐⭐⭐ (5점 - 최고예요)</option>
                    <option value="4">⭐⭐⭐⭐ (4점 - 좋아요)</option>
                    <option value="3">⭐⭐⭐ (3점 - 보통이에요)</option>
                    <option value="2">⭐⭐ (2점 - 아쉬워요)</option>
                    <option value="1">⭐ (1점 - 별로예요)</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>후기 내용</label>
                <textarea name="rReview" placeholder="봉사활동을 하며 느낀 점을 자유롭게 적어주세요." required></textarea>
            </div>
            
            <div class="btn-area">
                <button type="submit" class="btn-submit">등록하기</button>
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>

</body>
</html>