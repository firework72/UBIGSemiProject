<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 로그인 시 세션에 저장되어 있다고 가정
    String memberId = (String)session.getAttribute("memberId");
    if(memberId == null){
        memberId = "guest"; // 테스트용
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유기견 후원 · 펀딩</title>

<style>
    body { font-family: Arial, sans-serif; background:#f5f6f7; }
    .container { width: 900px; margin: 40px auto; }
    .section { background:#fff; padding:30px; border-radius:10px; margin-bottom:30px; }
    h1 { text-align:center; }

    .tabs { display:flex; margin-bottom:20px; }
    .tabs button {
        flex:1; padding:15px; border:none; cursor:pointer;
        background:#ddd; font-size:16px;
    }
    .tabs button.active { background:#ff9800; color:#fff; }

    .donation-content { display:none; }
    .donation-content.active { display:block; }

    label { display:block; margin-top:10px; }
    input { padding:8px; width:300px; }

    .submit-btn {
        margin-top:20px;
        padding:12px 20px;
        border:none;
        background:#ff9800;
        color:#fff;
        font-size:16px;
        border-radius:5px;
        cursor:pointer;
    }
</style>

<script>
    function showTab(tabId, btn) {
        document.querySelectorAll('.donation-content').forEach(div => div.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');

        document.querySelectorAll('.tabs button').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
    }
</script>
</head>

<body>
<div class="container">

<h1>🐶 유기견 후원</h1>

<div class="section">
    <div class="tabs">
        <button class="active" onclick="showTab('regular', this)">정기 후원</button>
        <button onclick="showTab('oneTime', this)">일시 후원</button>
    </div>

    <!-- ================= 정기 후원 ================= -->
    <div id="regular" class="donation-content active">
        <form action="${pageContext.request.contextPath}/donation/donation" method="post">

            <!-- 공통 데이터 -->
            <input type="hidden" name="donationType" value="1">
            <input type="hidden" name="applyStatus" value="신청">
			
            <label>회원 아이디</label>
            <input type="text" name="userId" value="${loginMember.userId}" readonly>

            <label>후원 금액</label>
            <input type="number" name="donationMoney" placeholder="후원 금액(원)" required>

            <button type="submit" class="submit-btn">정기 후원 신청</button>
        </form>
    </div>

    <!-- ================= 일시 후원 ================= -->
    <div id="oneTime" class="donation-content">
        <form action="${pageContext.request.contextPath}/donation/donation2" method="post">
			
            <!-- 공통 데이터 -->
            <input type="hidden" name="donationType" value="2">
            <input type="hidden" name="applyStatus" value="신청">
			
            <label>회원 아이디</label>
            <input type="text" name="userId" value="${loginMember.userId}" readonly>

            <label>후원 금액</label>
            <input type="number" name="donationMoney" placeholder="후원 금액(원)" required>

            <button type="submit" class="submit-btn">일시 후원하기</button>
        </form>
    </div>

</div>
</div>
</body>
</html>
