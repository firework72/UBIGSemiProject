<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <title>유봉일공 - 봉사활동 Q&A</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
            <style>
                .community-container {
                    padding: 120px 0 50px 0;
                    width: 1200px;
                    margin: 0 auto;
                }

                .page-title {
                    text-align: center;
                    margin-bottom: 40px;
                    font-size: 2em;
                    font-weight: bold;
                }

                /* 탭 스타일 (list.jsp와 동일) */
                .tab-menu {
                    display: flex;
                    justify-content: center;
                    margin-bottom: 30px;
                    border-bottom: 1px solid #ddd;
                }

                .tab-item {
                    padding: 15px 30px;
                    cursor: pointer;
                    color: #666;
                    font-weight: 500;
                    text-decoration: none;
                }

                .tab-item:hover {
                    color: #333;
                }

                .tab-item.active {
                    border-bottom: 3px solid #ff9f43;
                    color: #ff9f43;
                    font-weight: bold;
                }

                /* 아코디언 스타일 */
                .accordion {
                    border-top: 2px solid #333;
                }

                .accordion-item {
                    border-bottom: 1px solid #eee;
                }

                .accordion-header {
                    padding: 20px;
                    cursor: pointer;
                    background-color: #fff;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    font-weight: bold;
                    font-size: 1.1em;
                    transition: background-color 0.3s;
                }

                .accordion-header:hover {
                    background-color: #f9f9f9;
                }

                .accordion-header::after {
                    content: '\002B';
                    /* Plus sign */
                    font-size: 1.5em;
                    color: #ff9f43;
                    font-weight: bold;
                }

                .accordion-header.active::after {
                    content: '\2212';
                    /* Minus sign */
                }

                .accordion-header.active {
                    color: #ff9f43;
                }

                .accordion-content {
                    padding: 0 20px;
                    max-height: 0;
                    overflow: hidden;
                    background-color: #fcfcfc;
                    transition: max-height 0.3s ease-out, padding 0.3s ease;
                    color: #555;
                    line-height: 1.6;
                }

                .accordion-content.show {
                    padding: 20px;
                    max-height: 500px;
                    /* 충분한 높이 */
                    border-top: 1px solid #f1f1f1;
                }

                .q-mark {
                    color: #ff9f43;
                    margin-right: 10px;
                }
            </style>
        </head>

        <body>

            <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

            <main class="community-container">

                <div class="page-title">커뮤니티</div>

                <div class="tab-menu">
                    <a href="list?category=NOTICE" class="tab-item">공지사항</a>
                    <a href="list?category=FREE" class="tab-item">자유게시판</a>
                    <a href="list?category=REQUEST" class="tab-item">건의사항</a>
                    <a href="list?category=REVIEW" class="tab-item">봉사후기</a>
                    <a href="qna" class="tab-item active">봉사활동 Q&A</a>
                </div>

                <div class="accordion">
                    <!-- Q1 -->
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <span><span class="q-mark">Q1.</span>봉사활동은 어떻게 참여하나요?</span>
                        </div>
                        <div class="accordion-content">
                            <p>봉사활동 일정 공지를 참고하여 신청 절차에 따라 신청해주세요.</p>
                        </div>
                    </div>

                    <!-- Q2 -->
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <span><span class="q-mark">Q2.</span>봉사활동 장소는 보통 어디에 있나요?</span>
                        </div>
                        <div class="accordion-content">
                            <p>임대료 및 많은 동물의 짖는 소리와 대소변의 냄새로 인해 서울 내에서 보호소를 운영할 수 없습니다.</p>
                            <p>파주, 일산, 시흥, 남양주, 평택, 김포 등 경기도권을 주로 다니고 있으며, 도움이 필요하다는 제보가 있다면 달려갑니다.</p>
                        </div>
                    </div>

                    <!-- Q3 -->
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <span><span class="q-mark">Q3.</span>봉사참여금(10,000원)은 어디에 사용되나요?</span>
                        </div>
                        <div class="accordion-content">
                            <p>1. 약 5,000원 상당의 점심식사를 제공합니다.</p>
                            <p>2. 보호소에 물품을 후원합니다.</p>
                            <p>3. 우리단체를 운영함에 필요한 곳에 사용됩니다.</p>
                        </div>
                    </div>
                </div>

            </main>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const headers = document.querySelectorAll('.accordion-header');

                    headers.forEach(header => {
                        header.addEventListener('click', function () {
                            const content = this.nextElementSibling;
                            const isActive = this.classList.contains('active');

                            // 모든 아이템 닫기 (하나만 열리게 하려면 이 부분 유지)
                            document.querySelectorAll('.accordion-header').forEach(h => {
                                h.classList.remove('active');
                                h.nextElementSibling.classList.remove('show');
                            });

                            // 클릭한 아이템 열기 (이미 열려있었다면 닫힌 상태로 유지됨)
                            if (!isActive) {
                                this.classList.add('active');
                                content.classList.add('show');
                            }
                        });
                    });
                });
            </script>

        </body>

        </html>