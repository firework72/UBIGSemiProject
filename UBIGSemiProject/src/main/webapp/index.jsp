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

            <header>
                <nav>
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/">유봉일공</a>
                    </div>
                    <ul class="nav-links">
                        <li class="dropdown">
                            <a href="#">봉사활동</a>
                            <ul class="dropdown-content">
                                <li><a href="#">봉사 프로그램</a></li>
                                <li><a href="#">봉사 신청</a></li>
                                <li><a href="#">봉사 후기</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">입양</a>
                            <ul class="dropdown-content">
                                <li><a href="#">입양 공고</a></li>
                                <li><a href="#">동물 소개</a></li>
                                <li><a href="#">입양 신청</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">커뮤니티</a>
                            <ul class="dropdown-content">
                                <li><a href="${pageContext.request.contextPath}/community/list?category=NOTICE">공지사항</a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/community/list?category=FREE">자유게시판</a>
                                </li>
                                <li><a
                                        href="${pageContext.request.contextPath}/community/list?category=REQUEST">건의사항</a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/community/list?category=REVIEW">봉사후기</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">후원</a>
                            <ul class="dropdown-content">
                                <li><a href="#">펀딩 목록</a></li>
                                <li><a href="#">후원하기</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">회원</a>
                            <ul class="dropdown-content">
                                <li><a href="#">로그인</a></li>
                                <li><a href="#">회원가입</a></li>
                                <li><a href="#">마이페이지</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </header>

            <main>
                <h1>환영합니다! 유봉일공입니다.</h1>
                <p>유기견 봉사 일등 공신, 여러분의 따뜻한 손길을 기다립니다.</p>
                <!-- Content places here -->
            </main>

        </body>

        </html>