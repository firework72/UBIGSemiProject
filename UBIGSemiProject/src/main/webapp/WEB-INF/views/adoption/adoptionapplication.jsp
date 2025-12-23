<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>UBIG - 입양 신청</title>
            <!-- Global Style -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
            <!-- Adoption Specific Style -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adoption-style.css">
        </head>

        <body>
            <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

            <c:if test="${not empty alertMsgAd}">
                <script>
                    alert('${alertMsgAd}');
                </script>
                <c:remove var="alertMsgAd" scope="session" />
            </c:if>

            <div class="adoption-container">
                <h1 class="adoption-header">입양 신청서 작성</h1>

                <form action="adoption.insertapplication" method="post" class="adoption-form">

                    <label>동물 고유 번호</label>
                    <input type="number" name="animalNo" value="${param.anino}" readonly>

                    <label>신청자 ID</label>
                    <input type="text" name="userId" placeholder="ID를 입력하세요" required value="${loginMember.userId}"
                        readonly>
                    <!-- Note: Value seems to be placeholder literal in original -->
                    <input type="hidden" name="adoptStatus" value="1" />

                    <div style="margin-top: 30px; border-top: 1px solid #eee; padding-top: 20px;">
                        <label>약관 동의</label>

                        <div style="margin-bottom: 20px;">
                            <textarea readonly
                                style="height: 80px; resize: none;">약관1 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구</textarea>
                            <div style="text-align: right; margin-top: 5px;">
                                <label style="display: inline-block; font-weight: normal;"><input name="agree1"
                                        type="checkbox" required style="width: auto; margin-bottom: 0;"> 동의</label>
                            </div>
                        </div>

                        <div style="margin-bottom: 20px;">
                            <textarea readonly
                                style="height: 80px; resize: none;">약관2 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구</textarea>
                            <div style="text-align: right; margin-top: 5px;">
                                <label style="display: inline-block; font-weight: normal;"><input name="agree2"
                                        type="checkbox" required style="width: auto; margin-bottom: 0;"> 동의</label>
                            </div>
                        </div>

                        <div style="margin-bottom: 20px;">
                            <textarea readonly
                                style="height: 80px; resize: none;">약관3 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구</textarea>
                            <div style="text-align: right; margin-top: 5px;">
                                <label style="display: inline-block; font-weight: normal;"><input name="agree3"
                                        type="checkbox" required style="width: auto; margin-bottom: 0;"> 동의</label>
                            </div>
                        </div>

                        <div
                            style="text-align: right; margin-top: 20px; border-top: 1px dashed #ddd; padding-top: 15px;">
                            <label
                                style="display: inline-block; font-weight: bold; font-size: 1.1rem; color: #ff8e3c;"><input
                                    name="allagree" id="allagree" type="checkbox"
                                    style="width: auto; margin-bottom: 0;"> 약관 전체 동의</label>
                        </div>
                    </div>

                    <div class="text-center mt-20 btn-group">
                        <button type="submit" class="btn-primary">신청하기</button>
                        <button type="button" class="btn-secondary" onclick="history.back()">취소</button>
                    </div>

                </form>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const allagree = document.querySelector("#allagree");
                    // Select all required checkboxes (agree1, agree2, agree3)
                    const checkboxes = document.querySelectorAll("input[name^='agree']");

                    allagree.addEventListener("change", function () {
                        checkboxes.forEach(checkbox => {
                            checkbox.checked = allagree.checked;
                        });
                    });

                    checkboxes.forEach(checkbox => {
                        checkbox.addEventListener("change", function () {
                            // Update allagree based on whether all required checkboxes are checked
                            allagree.checked = Array.from(checkboxes).every(cb => cb.checked);
                        });
                    });
                });
            </script>
        </body>

        </html>