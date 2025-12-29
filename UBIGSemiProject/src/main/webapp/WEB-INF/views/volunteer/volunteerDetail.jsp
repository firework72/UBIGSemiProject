<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>봉사활동 상세</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        /* reviewDetail.jsp 스타일 적용 */
        body {
            font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 1000px;
            margin: 50px auto;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #333;
            font-weight: 800;
        }

        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .detail-table th, .detail-table td {
            border-bottom: 1px solid #eee;
            padding: 15px;
            text-align: left;
        }

        .detail-table th {
            width: 150px;
            background-color: #f8f9fa;
            font-weight: bold;
            color: #555;
            border-right: 1px solid #eee;
        }

        /* 신청 영역 스타일 */
        .apply-box {
            background-color: #f1f8ff;
            border: 1px solid #cce5ff;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            margin-top: 30px;
        }
        
        .apply-title {
            font-size: 20px; 
            font-weight: bold; 
            color: #0056b3; 
            margin-bottom: 20px;
        }

        .btn-area {
            text-align: center;
            margin-top: 40px;
        }

        .btn-list {
            background-color: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 50px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
            cursor: pointer;
        }

        .btn-list:hover { background-color: #5a6268; }

        .btn-apply {
            background-color: #007bff;
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 50px;
            font-weight: bold;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-apply:hover { background-color: #0056b3; }

        .btn-status {
            background-color: #28a745;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            margin-left: 10px;
        }
    </style>
</head>

<body>

    <jsp:include page="../common/menubar.jsp" />

    <div class="container">
        <h2>📋 봉사활동 상세 정보</h2>

        <div style="font-size: 24px; font-weight: bold; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #333;">
            ${vo.actTitle}
        </div>

        <table class="detail-table">
            <tr>
                <th>작성자</th>
                <td>${vo.adminId}</td>
                <th>모집인원</th>
                <td>${vo.actCur} / ${vo.actMax} 명</td>
            </tr>
            <tr>
                <th>활동 기간</th>
                <td colspan="3">
                    <fmt:formatDate value="${vo.actDate}" pattern="yyyy-MM-dd" /> ~ 
                    <fmt:formatDate value="${vo.actEnd}" pattern="yyyy-MM-dd" />
                </td>
            </tr>
            <tr>
                <th>활동 장소</th>
                <td colspan="3">${vo.actAddress}</td>
            </tr>
            <tr>
                <th>참가비</th>
                <td colspan="3">
                    <fmt:formatNumber value="${vo.actMoney}" type="currency" currencySymbol="￦" /> (현장 납부)
                </td>
            </tr>
        </table>

        <div class="apply-box">
            <div class="apply-title">📢 이 봉사활동에 참여하시겠습니까?</div>
            
            <form action="volunteerSign.vo" method="post" style="display: inline-block;">
                <input type="hidden" name="actId" value="${vo.actId}">
                <input type="hidden" name="signsId" value="${loginMember.userId}">
                
                <button type="submit" class="btn-apply">
                    ✋ 지금 신청하기
                </button>
            </form>

            <a href="signList.vo?actId=${vo.actId}" class="btn-status">
                👥 신청자 현황 보기
            </a>
        </div>

        <div class="btn-area">
            <a href="volunteerList.vo" class="btn-list">목록으로</a>

            <c:if test="${loginMember.userRole eq 'ADMIN'}">
                <a href="volunteerUpdateForm.vo?actId=${vo.actId}" class="btn-list" style="background-color: #ffc107; color: white;">수정</a>
                <button onclick="deleteAction()" class="btn-list" style="background-color: #dc3545;">삭제</button>
            </c:if>
        </div>
    </div>

    <script>
        $(function () {
            var msg = "${sessionScope.alertMsg}";
            if (msg != null && msg !== "") {
                alert(msg);
                <% session.removeAttribute("alertMsg"); %>
            }
        });

        function deleteAction() {
            if (confirm("정말로 이 봉사활동 게시글을 삭제하시겠습니까?")) {
                location.href = "volunteerDelete.vo?actId=${vo.actId}";
            }
        }
    </script>
</body>
</html>