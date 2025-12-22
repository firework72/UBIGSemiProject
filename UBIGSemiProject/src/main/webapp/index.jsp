<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <title>유봉일공</title>
            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
        </head>

        <body>

            <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

            <main>
                <h1>환영합니다! 유봉일공입니다.</h1>
                <p>유기견 봉사 일등 공신, 여러분의 따뜻한 손길을 기다립니다.</p>
                <!-- Content places here -->
            </main>
            
        <jsp:include page="/WEB-INF/views/common/chat.jsp"/>

        </body>

        </html>