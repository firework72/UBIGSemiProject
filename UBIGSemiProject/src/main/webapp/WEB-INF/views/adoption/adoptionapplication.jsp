<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
        </head>

        <body>

            <c:if test="${not empty alertMsgAd}">
                <script>
                    alert('${alertMsgAd}');
                </script>
                <c:remove var="alertMsgAd" scope="session" />
            </c:if>

            <div align="center">
                <h1>입양 신청서 작성</h1>

                <form action="adoption.insertapplication" method="post">

                    <table border="1">

                        <tr align="center">
                            <th bgcolor="#f2f2f2" width="150">동물 고유 번호</th>
                            <td>
                                <input type="number" name="animalNo" value="${param.anino}" readonly
                                    style="width: 100%; border: none; text-align: center; box-sizing: border-box;">
                            </td>
                        </tr>

                        <tr align="center">
                            <th bgcolor="#f2f2f2">신청자 ID</th>
                            <td>
                                <input type="text" name="userId" placeholder="ID를 입력하세요" required
                                    style="width: 100%; text-align: center; box-sizing: border-box;"
                                    value="session.userId값" />
                                <input type="hidden" name="adoptStatus" value="1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" id="requiredcheckbox">
                                <textarea readonly
                                    style="width: 100%; height: 80px; resize: none; box-sizing: border-box;">
                            약관1 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구
                        </textarea>
                                <p align="right">
                                    <label for="agree1">동의</label><input name="agree1" type="checkbox" required />
                                </p>
                                <textarea readonly
                                    style="width: 100%; height: 80px; resize: none; box-sizing: border-box;">
                            약관2 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구
                        </textarea>
                                <p align="right">
                                    <label for="agree2">동의</label><input name="agree2" type="checkbox" required />
                                </p>
                                <textarea readonly
                                    style="width: 100%; height: 80px; resize: none; box-sizing: border-box;">
                            약관3 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구약관 어쩌구 저쩌구
                        </textarea>
                                <p align="right">
                                    <label for="agree3">동의</label><input name="agree3" type="checkbox" required />
                                    <br>
                                    <label for="allagree">전부 동의</label><input name="allagree" id="allagree"
                                        type="checkbox" />
                                </p>
                            </td>
                        </tr>
                    </table>

                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const allagree = document.querySelector("#allagree");
                            const requiredcheckbox = document.querySelector("#requiredcheckbox");
                            // '전부 동의' 체크박스를 제외한 나머지 체크박스들만 선택
                            const checkboxes = requiredcheckbox.querySelectorAll("input[type='checkbox']:not(#allagree)");

                            allagree.addEventListener("change", function () {
                                checkboxes.forEach(checkbox => {
                                    checkbox.checked = allagree.checked;
                                });
                            });

                            checkboxes.forEach(checkbox => {
                                checkbox.addEventListener("change", function () {
                                    // 개별 체크박스 상태에 따라 '전부 동의' 상태 업데이트
                                    allagree.checked = Array.from(checkboxes).every(cb => cb.checked);
                                });
                            });
                        });
                    </script>

                    <br>

                    <button type="submit">신청하기</button>
                    <button type="button" onclick="history.back()">취소</button>

                </form>
            </div>
        </body>

        </html>