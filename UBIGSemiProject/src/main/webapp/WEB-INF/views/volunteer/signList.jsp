<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사활동 신청자 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
    body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; }
    h2 { border-bottom: 2px solid #ccc; padding-bottom: 10px; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
    th { background-color: #f0f0f0; }
    
    .btn-back { 
        display: inline-block; margin-top: 20px; padding: 10px 20px; 
        background-color: #555; color: white; text-decoration: none; border-radius: 4px;
    }
    .empty-alert { text-align: center; padding: 30px; font-weight: bold; color: #777; }
    
    /* 상태값 색상 */
    .status-wait { color: orange; font-weight: bold; }
    .status-ok { color: green; font-weight: bold; }
    .status-no { color: red; font-weight: bold; } /* 반려/취소용 */

    /* [추가] 버튼 스타일 */
    .btn-action {
        padding: 5px 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
        margin: 0 2px;
        color: white;
    }
    .btn-approve { background-color: #28a745; } /* 초록 */
    .btn-reject { background-color: #dc3545; }  /* 빨강 */
    .btn-cancel { background-color: #6c757d; }  /* 회색 */
    
    .btn-action:hover { opacity: 0.8; }
</style>
</head>
<body>

    <h2>👥 신청자 현황</h2>

    <c:choose>
        <c:when test="${empty signList}">
            <div class="empty-alert">
                현재 신청자가 없습니다.
            </div>
        </c:when>
        
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>신청번호</th>
                        <th>신청자ID</th>
                        <th>신청일</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sign" items="${signList}">
                        <tr>
                            <td>${sign.signsNo}</td>
                            <td>${sign.signsId}</td>
                            <td>
                                <fmt:formatDate value="${sign.signsDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            
                            <td>
                                <td>
                                <c:choose>
                                    <c:when test="${sign.signsStatus == 0}">
                                        <span class="status-wait">대기중</span>
                                    </c:when>
                                    <c:when test="${sign.signsStatus == 1}">
                                        <span class="status-ok">승인됨</span>
                                    </c:when>
                                    <c:when test="${sign.signsStatus == 2}">
                                        <span class="status-no">반려됨</span>
                                    </c:when>
                                    <c:when test="${sign.signsStatus == 3}">
                                        <span class="status-no" style="color: gray;">취소됨</span>
                                    </c:when>
                                    <c:when test="${sign.signsStatus == 4}">
                                        <span class="status-ok" style="color: blue;">🏅 활동완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-no">상태미상(${sign.signsStatus})</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            </td>

                            <td>
                                <%-- 1. 관리자(ADMIN)일 때: 대기중(0)인 건에만 승인/반려 버튼 노출 --%>
                                <%-- 1. 관리자(ADMIN)일 때 --%>
                                <c:if test="${sessionScope.loginMember.userRole eq 'ADMIN'}">
                                    
                                    <%-- 대기중(0)일 때: 승인 / 반려 --%>
                                    <c:if test="${sign.signsStatus == 0}">
                                        <button type="button" class="btn-action btn-approve" onclick="updateAdmin(${sign.signsNo}, 'approve')">승인</button>
                                        <button type="button" class="btn-action btn-reject" onclick="updateAdmin(${sign.signsNo}, 'reject')">반려</button>
                                    </c:if>
                                    
                                    <%-- [추가] 승인됨(1) 상태일 때: 봉사 완료 처리 버튼 노출 --%>
                                    <c:if test="${sign.signsStatus == 1}">
                                        <button type="button" class="btn-action" style="background-color: #007bff;" onclick="updateAdmin(${sign.signsNo}, 'complete')">활동완료</button>
                                    </c:if>
                                    
                                </c:if>

                                <%-- 2. 신청자 본인(userId 일치)일 때: 대기(0)거나 승인(1) 상태면 취소 가능 --%>
                                <c:if test="${sessionScope.loginMember.userId eq sign.signsId}">
                                    <c:if test="${sign.signsStatus == 0 or sign.signsStatus == 1}">
                                        <button type="button" class="btn-action btn-cancel" onclick="updateUser(${sign.signsNo})">신청취소</button>
                                    </c:if>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <a href="volunteerDetail.vo?actId=${param.actId}" class="btn-back">뒤로 가기</a>

    <script>
 // 1. 관리자 승인/반려/완료 AJAX
    function updateAdmin(signsNo, statusType) {
        
        // 메시지 동적 설정
        var msg = "";
        if(statusType === 'approve') msg = "승인하시겠습니까?";
        else if(statusType === 'reject') msg = "반려하시겠습니까?";
        else if(statusType === 'complete') msg = "해당 회원의 봉사 활동을 완료 처리하시겠습니까?\n(회원의 봉사 횟수가 1 증가합니다)";

        if(confirm(msg)) {
            $.ajax({
                url: "updateSignStatusAdmin.vo",
                type: "post",
                data: {
                    signsNo: signsNo,
                    status: statusType
                },
                success: function(result) {
                    if(result === "success") {
                        alert("처리되었습니다.");
                        location.reload(); 
                    } else if(result === "full") {
                        alert("⚠️ 모집 인원이 꽉 차서 승인할 수 없습니다!");
                    } else {
                        alert("처리 실패. 관리자에게 문의하세요.");
                    }
                },
                error: function() {
                    alert("통신 오류가 발생했습니다.");
                }
            });
        }
    }
        // 2. 사용자 취소 AJAX
        function updateUser(signsNo) {
            if(confirm("정말 봉사 신청을 취소하시겠습니까?")) {
                $.ajax({
                    url: "updateSignStatusUser.vo",
                    type: "post",
                    data: { signsNo: signsNo },
                    success: function(result) {
                        if(result === "success") {
                            alert("취소되었습니다.");
                            location.reload();
                        } else {
                            alert("취소 처리에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("통신 오류가 발생했습니다.");
                    }
                });
            }
        }
    </script>

</body>
</html>