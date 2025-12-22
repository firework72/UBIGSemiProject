<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유기견 후원 · 펀딩</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 900px;
        margin: 40px auto;
    }

    h1 {
        text-align: center;
        margin-bottom: 30px;
    }

    .section {
        background: #fff;
        padding: 30px;
        margin-bottom: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .section h2 {
        margin-bottom: 20px;
    }

    /* 후원 버튼 */
    .donation-buttons button {
        padding: 10px 20px;
        margin-right: 10px;
        border: none;
        border-radius: 5px;
        background-color: #ff9800;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

    .donation-buttons button:hover {
        background-color: #e68900;
    }

    input[type="number"] {
        padding: 10px;
        width: 200px;
        margin-top: 10px;
    }

    /* 펀딩 카드 */
    .funding-list {
        display: flex;
        gap: 20px;
    }

    .funding-card {
        flex: 1;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
    }

    .funding-card h3 {
        margin-top: 0;
    }

    .funding-card progress {
        width: 100%;
        height: 20px;
    }

    .funding-card button {
        margin-top: 15px;
        width: 100%;
        padding: 10px;
        background-color: #4caf50;
        border: none;
        border-radius: 5px;
        color: white;
        font-size: 15px;
        cursor: pointer;
    }

    .funding-card button:hover {
        background-color: #43a047;
    }
</style>

<script>
    function donate(amount) {
        alert(amount + "원 후원이 선택되었습니다.");
        // 실제로는 서버로 전송
        // location.href="donate.do?amount=" + amount;
    }

    function funding(projectId) {
        alert("펀딩 참여 프로젝트 ID: " + projectId);
        // location.href="funding.do?projectId=" + projectId;
    }
</script>
</head>

<body>
<div class="container">

    <h1>🐶 유기견 후원 & 펀딩</h1>

    <!-- 후원 섹션 -->
    <div class="section">
        <h2>💖 정기/일시 후원</h2>
        <p>여러분의 작은 후원이 유기견의 큰 희망이 됩니다.</p>

        <div class="donation-buttons">
            <button onclick="${pageContext.request.contextPath}/funding/donation">10,000원</button>
            <button onclick="${pageContext.request.contextPath}/funding/donation">30,000원</button>
            <button onclick="${pageContext.request.contextPath}/funding/donation">50,000원</button>
        </div>

        <br>
        <label>직접 입력</label><br>
        <input type="number" placeholder="금액 입력(원)">
    </div>

    <!-- 펀딩 섹션 -->
    <div class="section">
        <h2>🎯 유기견 펀딩 프로젝트</h2>

        <div class="funding-list">

            <div class="funding-card">
                <h3>겨울 담요 지원</h3>
                <p>추운 겨울을 버틸 수 있도록 담요를 지원합니다.</p>
                <progress value="60" max="100"></progress>
                <p>60% 달성</p>
                <button onclick="funding(1)">펀딩 참여</button>
            </div>

            <div class="funding-card">
                <h3>예방접종 비용 마련</h3>
                <p>유기견들의 건강을 위한 예방접종 펀딩</p>
                <progress value="40" max="100"></progress>
                <p>40% 달성</p>
                <button onclick="funding(2)">펀딩 참여</button>
            </div>

            <div class="funding-card">
                <h3>사료 후원 프로젝트</h3>
                <p>보호소 사료 부족 문제 해결</p>
                <progress value="80" max="100"></progress>
                <p>80% 달성</p>
                <button onclick="funding(3)">펀딩 참여</button>
            </div>

        </div>
    </div>

</div>
</body>
</html>
