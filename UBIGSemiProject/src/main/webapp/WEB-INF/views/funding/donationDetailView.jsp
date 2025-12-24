<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
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
    body { font-family:'Noto Sans KR', sans-serif; background:#f5f6f7; margin:0; padding:0; }
    .container { max-width:900px; margin:40px auto; padding:0 15px; }

    h1 { text-align:center; font-size:2rem; margin-bottom:30px; color:#2c3e50; }

    .section { background:#fff; padding:30px; border-radius:15px; box-shadow:0 8px 20px rgba(0,0,0,0.05); }

    /* 탭 스타일 */
    .tabs { display:flex; margin-bottom:20px; border-radius:10px; overflow:hidden; box-shadow:0 4px 8px rgba(0,0,0,0.1); }
    .tabs button {
        flex:1; padding:15px; border:none; cursor:pointer;
        background:#ddd; font-size:16px; font-weight:600;
        transition: background 0.3s, color 0.3s;
    }
    .tabs button.active { background:#FFC107; color:#fff; }

    .donation-content { display:none; animation:fadeIn 0.5s ease-in-out; }
    .donation-content.active { display:block; }

    .donation-card {
        display:flex; flex-direction:row; gap:20px; align-items:center;
        background:#fff; padding:20px; border-radius:15px;
        box-shadow:0 5px 15px rgba(0,0,0,0.08); margin-bottom:20px;
    }

    .donation-card img {
        width:200px; height:150px; border-radius:10px; object-fit:cover;
    }

    .donation-form {
        flex:1;
    }

    label { display:block; margin-top:10px; font-weight:500; color:#555; }
    input[type=text], input[type=number] { 
        padding:10px; width:100%; margin-top:5px; border:1px solid #ccc; border-radius:5px;
        font-size:1rem;
    }

    .submit-btn {
        margin-top:20px; padding:12px 20px; border:none; background:#FFC107;
        color:#fff; font-size:1rem; font-weight:700; border-radius:50px; cursor:pointer;
        transition: background 0.3s, transform 0.2s;
    }
    .submit-btn:hover { background:#FFA000; transform:translateY(-2px); }

    @keyframes fadeIn {
        from { opacity:0; transform:translateY(20px); }
        to { opacity:1; transform:translateY(0); }
    }

    /* 모바일 대응 */
    @media(max-width:600px){
        .donation-card { flex-direction:column; text-align:center; }
        .donation-card img { width:100%; height:auto; }
        input[type=text], input[type=number] { width:100%; }
    }
</style>

<script>
    function showTab(tabId, btn) {
        document.querySelectorAll('.donation-content').forEach(div => div.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');

        document.querySelectorAll('.tabs button').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
    }

    window.addEventListener('DOMContentLoaded', ()=> {
        document.querySelector('.tabs button').click();
    });
</script>
</head>

<body>
<div class="container">

<h1>🐶 유기견 후원</h1>

<div class="section">
    <div class="tabs">
    	<c:if test="${list.donationType == 2}">
        	<button onclick="showTab('regular', this)">정기 후원</button>
        </c:if>
        <button onclick="showTab('oneTime', this)">일시 후원</button>
    </div>

    <!-- ================= 정기 후원 ================= -->
    	<c:if test="${list.donationType == 2}">
		    <div id="regular" class="donation-content">
		        <div class="donation-card">
		            <img src="${pageContext.request.contextPath}/resources/images/donation/regular1.jpg" alt="정기후원 이미지">
		            <div class="donation-form">
		                <form action="${pageContext.request.contextPath}/donation/donation" method="post">
		                    <input type="hidden" name="donationType" value="1">
		                    <input type="hidden" name="applyStatus" value="신청">
		
		                    <label>회원 아이디</label>
		                    <input type="text" name="userId" value="${loginMember.userId}" readonly>
		
		                    <label>후원 금액</label>
		                    <input type="number" name="donationMoney" placeholder="후원 금액(원)" required>
		
		                    <button type="submit" class="submit-btn">정기 후원 신청</button>
		                </form>
		            </div>
		        </div>
		    </div>
		</c:if>
		
    <!-- ================= 일시 후원 ================= -->
    <div id="oneTime" class="donation-content">
        <div class="donation-card">
            <img src="${pageContext.request.contextPath}/resources/images/donation/onetime1.jpg" alt="일시후원 이미지">
            <div class="donation-form">
                <form action="${pageContext.request.contextPath}/donation/donation2" method="post">
                    <input type="hidden" name="donationType" value="2">
                    <input type="hidden" name="applyStatus" value="신청">

                    <label>회원 아이디</label>
                    <input type="text" name="userId" value="${loginMember.userId}" readonly>

                    <label>후원 금액</label>
                    <input type="number" name="donationMoney" placeholder="후원 금액(원)" required>

                    <button type="submit" class="submit-btn">일시 후원 신청</button>
                </form>
            </div>
        </div>
    </div>

</div>
</div>
</body>
</html>
