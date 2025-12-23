<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${funding.fTitle} - 펀딩 참여</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Outfit:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <style>
        :root {
            --primary-color: #FFC107;
            --primary-dark: #FFA000;
            --text-dark: #2c3e50;
            --text-gray: #6c757d;
            --bg-light: #f8f9fa;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; line-height:1.6; color:#333; background-color:#fff; }
        .container { max-width: 800px; margin: 50px auto; padding: 0 20px; }
        h1 { font-size:2.5rem; color:var(--text-dark); margin-bottom:20px; }
        p { color:var(--text-gray); margin-bottom:20px; }
        .funding-img { width:100%; max-height:400px; object-fit:cover; border-radius:15px; margin-bottom:30px; }
        .funding-content { font-size:1.1rem; color:#555; line-height:1.8; margin-bottom:30px; }
        .support-form input { width:100%; padding:15px; border:2px solid #eee; border-radius:12px; font-size:1rem; margin-bottom:15px; outline:none; transition:border-color 0.3s; }
        .support-form input:focus { border-color:var(--primary-color); }
        .btn-main { display:block; width:100%; padding:18px; background-color:var(--primary-color); color:white; font-weight:700; border:none; border-radius:50px; font-size:1.1rem; cursor:pointer; transition:all 0.3s; }
        .btn-main:hover { background-color:var(--primary-dark); transform:translateY(-3px); box-shadow:0 6px 20px rgba(255,193,7,0.4); }
        .money-info { margin-bottom:30px; }
        .money-info .current { font-size:1.4rem; font-weight:700; color:var(--text-dark); }
        .money-info .goal { color:var(--text-gray); font-size:0.95rem; }
        .footer-simple { background-color:#333; color:#aaa; padding:50px 0; text-align:center; font-size:0.9rem; margin-top:60px; }
    </style>
</head>
<body>

    <div class="container">
        <h1>제목</h1>
        <p>주최자: <strong>${loginMember.userId}</strong></p>
        <img src="${pageContext.request.contextPath}/resources/images/main/main1.png" alt="펀딩 이미지" class="funding-img">
        <div class="funding-content">
            내용
        </div>

        <div class="money-info">
            <div class="current">현재 모금액: <fmt:formatNumber value="${list.fCurrentMoney}" pattern="#,###"/>원</div>
            <div class="goal">목표 금액: <fmt:formatNumber value="${list.fMaxMoney}" pattern="#,###"/>원</div>
        </div>

        <!-- 후원 폼 -->
        <form action="${pageContext.request.contextPath}/funding/insertMoney" method="post" class="support-form">
            <input type="hidden" name="userId" value="${loginMember.userId}">
            <input type="hidden" name="fNo" value="4">
            <label for="fMoney" style="font-weight:500; margin-bottom:10px; display:block;">후원 금액</label>
            <input type="number" id="fMoney" name="fMoney" placeholder="예: 5000원" min="1000" required>
            <button type="submit" class="btn-main">따뜻한 마음 나누기</button>
        </form>
        <p style="margin-top:20px; font-size:0.85rem; color:#999;">* 펀딩 참여 시 취소가 어려우니 신중히 결정해주세요.</p>
    </div>

    <footer class="footer-simple">
        <div class="container">
            <p>&copy; 2024 UBIG (유봉일공). All rights reserved.</p>
        </div>
    </footer>

</body>
</html>
