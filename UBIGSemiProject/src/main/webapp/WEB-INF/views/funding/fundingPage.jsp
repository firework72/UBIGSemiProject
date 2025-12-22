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
        background-color: #f5f6f7;
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

    /* 탭 버튼 */
    .tabs {
        display: flex;
        margin-bottom: 20px;
    }

    .tabs button {
        flex: 1;
        padding: 15px;
        border: none;
        cursor: pointer;
        font-size: 16px;
        background-color: #ddd;
    }

    .tabs button.active {
        background-color: #ff9800;
        color: white;
    }

    .donation-content {
        display: none;
    }

    .donation-content.active {
        display: block;
    }

    .donation-buttons button {
        padding: 10px 20px;
        margin-right: 10px;
        margin-top: 10px;
        border: none;
        border-radius: 5px;
        background-color: #ff9800;
        color: white;
        font-size: 15px;
        cursor: pointer;
    }

    input[type="number"] {
        margin-top: 10px;
        padding: 10px;
        width: 200px;
    }

    /* 펀딩 */
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

    .funding-card button {
        margin-top: 15px;
        width: 100%;
        padding: 10px;
        background-color: #4caf50;
        border: none;
        border-radius: 5px;
        color: white;
        cursor: pointer;
    }
</style>

<script>
    function showTab(tabId, btn) {
        document.querySelectorAll('.donation-content').forEach(div => {
            div.classList.remove('active');
        });
        document.getElementById(tabId).classList.add('active');

        document.querySelectorAll('.tabs button').forEach(b => {
            b.classList.remove('active');
        });
        btn.classList.add('active');
    }
</script>
</head>

<body>
<div class="container">

    <h1>🐶 유기견 후원 & 펀딩</h1>

    <!-- 후원 섹션 -->
    <div class="section">
        <h2>💖 후원하기</h2>

        <div class="tabs">
            <button class="active" onclick="showTab('regular', this)">정기 후원</button>
            <button onclick="showTab('oneTime', this)">일시 후원</button>
        </div>

        <!-- 정기 후원 -->
        <div id="regular" class="donation-content active">
            <p>매달 일정 금액을 후원하여 유기견을 지속적으로 도와주세요.</p>

            <form action="regularDonate.do" method="post">
                <div class="donation-buttons">
                    <button type="submit" name="amount" value="10000">월 10,000원</button>
                    <button type="submit" name="amount" value="30000">월 30,000원</button>
                    <button type="submit" name="amount" value="50000">월 50,000원</button>
                </div>

                <br>
                <label>직접 입력</label><br>
                <input type="number" name="amount" placeholder="월 후원 금액(원)" required>
                <br><br>
                <button type="submit">정기 후원 신청</button>
            </form>
        </div>

        <!-- 일시 후원 -->
        <div id="oneTime" class="donation-content">
            <p>원하는 금액으로 한 번만 후원할 수 있습니다.</p>

            <form action="${pageContext.request.contextPath}/funding/donation" method="post">
                <div class="donation-buttons">
                    <button type="submit" name="amount" value="5000">5,000원</button>
                    <button type="submit" name="amount" value="10000">10,000원</button>
                    <button type="submit" name="amount" value="30000">30,000원</button>
                </div>

                <br>
                <label>직접 입력</label><br>
                <input type="text" name="donationNo" placeholder="입금번호" required>
                <input type="text" name="userId" value="" required>
                <input type="number" name="amount" placeholder="후원 금액(원)" required>
                <input type="number" name="amount" placeholder="후원 금액(원)" required>
                <input type="text" name="donationDate" value="$" required>
                <br><br>
                <button type="submit">일시 후원하기</button>
            </form>
        </div>
    </div>

    <!-- 펀딩 섹션 -->
    <div class="section">
        <h2>🎯 펀딩 프로젝트</h2>

        <div class="funding-list">

            <div class="funding-card">
                <h3>겨울 담요 지원</h3>
                <p>달성률 60%</p>
                <progress value="60" max="100"></progress>
                <button onclick="location.href='fundingDetail.do?id=1'">참여하기</button>
            </div>

            <div class="funding-card">
                <h3>예방접종 비용 마련</h3>
                <p>달성률 40%</p>
                <progress value="40" max="100"></progress>
                <button onclick="location.href='fundingDetail.do?id=2'">참여하기</button>
            </div>

        </div>
    </div>

</div>
</body>
</html>
