<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <header>
        	<c:if test="${not empty alertMsg}">
	            <script>
	                alert('${alertMsg}');
	            </script>
	            <c:remove var="alertMsg"/>
	        </c:if>
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
                            <li><a href="${pageContext.request.contextPath}/community/list?category=FREE">자유게시판</a></li>
                            <li><a href="${pageContext.request.contextPath}/community/list?category=REQUEST">건의사항</a>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/community/list?category=REVIEW">봉사후기</a>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/community/qna">봉사활동 Q&A</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#">후원</a>
                        <ul class="dropdown-content">
                            <li><a href="#">펀딩 목록</a></li>
                            <li><a href="#">후원하기</a></li>
                        </ul>
                    </li>
                    <!-- 유저 관련 메뉴: 로그인 상태에 따라 다르게 보여주면 좋음 -->
                    <li class="dropdown">
                        <a href="#">회원</a>
                        <ul class="dropdown-content">
                            <c:choose>
                                <c:when test="${empty loginUser}">
                                    <li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                                    <li><a href="${pageContext.request.contextPath}/member/enroll">회원가입</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="#">${loginUser.userName}님</a></li>
                                    <li><a href="${pageContext.request.contextPath}/member/mypage">마이페이지</a></li>
                                    <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </li>
                </ul>
            </nav>
        </header>