<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>유봉일공 - 로그인</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f8f9fa;
                    /* 연한 회색 배경 */
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .login-card {
                    width: 100%;
                    max-width: 400px;
                    border: none;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    border-radius: 15px;
                }

                .login-header {
                    background-color: #FFC107;
                    /* 유기견 봉사 느낌의 따뜻한 노란색/주황색 계열 추천 */
                    color: white;
                    text-align: center;
                    padding: 20px;
                    border-top-left-radius: 15px;
                    border-top-right-radius: 15px;
                    font-weight: bold;
                    font-size: 1.5rem;
                }

                .btn-custom {
                    background-color: #FFC107;
                    border-color: #FFC107;
                    color: white;
                    font-weight: bold;
                }

                .btn-custom:hover {
                    background-color: #e0a800;
                    color: white;
                }
            </style>
            
    
        </head>

        <body>

            <div class="card login-card">
                <div class="login-header">
                    유봉일공 LOGIN
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty msg}">
                        <div class="alert alert-danger text-center" role="alert">
                            ${msg}
                        </div>
                        <c:remove var="msg" />
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/login.me" method="post">

                        <div class="mb-3">
                            <label for="userId" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요"
                                required autofocus>
                        </div>

                        <div class="mb-3">
                            <label for="userPwd" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="userPwd" name="userPwd"
                                placeholder="비밀번호를 입력하세요" required>
                        </div>


                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-custom btn-lg">로그인</button>
                        </div>

                        <div class="mt-4 text-center">
                            <span class="text-secondary">아직 회원이 아니신가요?</span>
                            <a href="${pageContext.request.contextPath}/user/signup.me"
                                class="text-decoration-none fw-bold ms-2" style="color: #FFC107;">회원가입</a>
                        </div>
                        <!--                 <div class="mt-2 text-center"> -->
                        <!--                      <a href="/member/findInfo" class="text-decoration-none text-secondary small">아이디 / 비밀번호 찾기</a> -->
                        <!--                 </div> -->

                    </form>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>