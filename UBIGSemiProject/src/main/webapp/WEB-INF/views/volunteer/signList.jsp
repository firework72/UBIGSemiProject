<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사활동 신청자 목록</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; } /* 폰트 약간 개선 */
    h2 { border-bottom: 2px solid #ccc; padding-bottom: 10px; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
    th { background-color: #f0f0f0; }
    .btn-back { 
        display: inline-block; margin-top: 20px; padding: 10px 20px; 
        background-color: #555; color: white; text-decoration: none; border-radius: 4px;
    }
    .empty-alert { text-align: center; padding: 30px; font-weight: bold; color: #777; }
    
    /* 상태값에 색상 입히기 (선택사항) */
    .status-wait { color: orange; font-weight: bold; }
    .status-ok { color: green; font-weight: bold; }
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
                                <c:choose>
                                    <c:when test="${sign.signsStatus == 0}">
                                        <span class="status-wait">대기중</span>
                                    </c:when>
                                    <c:when test="${sign.signsStatus == 1}">
                                        <span class="status-ok">승인됨</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>취소/기타</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <a href="volunteerDetail.vo?actId=${param.actId}" class="btn-back">뒤로 가기</a>

</body>
</html>