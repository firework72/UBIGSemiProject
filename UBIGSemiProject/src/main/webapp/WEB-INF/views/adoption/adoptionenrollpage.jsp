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


            <h1>입양 등록(관리자) 페이지 입니다.</h1>

            <form action="adoption.insert.board" method="POST">
                <h3>[게시글 등록]</h3>

                <label>게시물 제목 : </label>
                <input type="text" name="postTitle" placeholder="제목을 입력하세요"><br>

                <label>관리자 아이디 : </label>
                <input type="text" name="userId" placeholder="ID 입력"><br>

                <label>동물 고유 번호 : </label>
                <input type="number" name="animalNo" placeholder="숫자만 입력"><br>
                <br>
                <input type="submit" value="게시글 등록하기" />
            </form>


            <form action="adoption.insert.animal" method="POST" enctype="multipart/form-data"><br>
                <h3>[동물 상세 정보 등록]</h3>

                <label>1. 축종 (Species)</label>
                <select name="species">
                    <option value="1">강아지</option>
                    <option value="2">고양이</option>
                    <option value="3">기타</option>
                </select><br>

                <label>2. 이름 (Name)</label>
                <input type="text" name="animalName" placeholder="예: 뽀삐"><br>

                <label>3. 품종 (Breed)</label>
                <input type="text" name="breed" placeholder="예: 말티즈"><br>

                <label>4. 성별 (Gender)</label>
                <div class="radio-group">
                    <input type="radio" name="gender" value="1" checked><span>수컷(M)</span>
                    <input type="radio" name="gender" value="2"><span>암컷(F)</span>
                </div>

                <label>5. 나이 (Age / 살)</label>
                <input type="number" name="age" step="0.1" placeholder="예: 2.5"><br>

                <label>6. 체중 (Weight / kg)</label>
                <input type="number" name="weight" step="0.1" placeholder="예: 5.2"><br>

                <label>7. 크기 (Size)</label>
                <input type="number" name="petSize" step="0.1" placeholder="크기 수치 입력"><br>

                <label>8. 중성화 여부 (Neutered)</label>
                <div class="radio-group">
                    <input type="radio" name="neutered" value="1"><span>완료(Yes)</span>
                    <input type="radio" name="neutered" value="0" checked><span>미완료(No)</span>
                </div>

                <label>9. 접종 상태 (Vaccination Status)</label>
                <input type="text" name="vaccinationStatus" placeholder="예: 3차 완료"><br>

                <label>10. 특이사항 (Health Notes)</label><br>
                <textarea name="healthNotes" rows="3" placeholder="건강 상태 및 특징 작성"></textarea><br>

                <label>11. 입양 상태 (Status)</label>
                <select name="adoptionStatus">
                    <option value="available">입양 가능</option>
                    <option value="reserved">예약중</option>
                    <option value="completed">입양 완료</option>
                </select><br>

                <label>12. 입양 조건 (Conditions)</label><br>
                <textarea name="adoptionConditions" rows="3" placeholder="필수 입양 조건 작성"></textarea><br>

                <label>13. 입양 희망 지역 (Hope Region)</label>
                <div style="margin-bottom: 10px;">
                    <input type="text" id="postcode" placeholder="우편번호" readonly style="width: 100px;">
                    <button type="button" onclick="execDaumPostcode()">주소 검색</button>
                </div>
                <input type="text" id="roadAddress" placeholder="도로명 주소" readonly
                    style="width: 300px; margin-bottom: 5px;"><br>
                <input type="text" id="detailAddress" placeholder="상세 주소" style="width: 300px;">
                <input type="hidden" name="hopeRegion" id="hopeRegion">
                <br>

                <label>14. 공고 마감일 (Deadline)</label>
                <input type="date" name="deadlineDate"><br>

                <label>15. 사진 첨부 (Photo)</label>
                <input type="file" name="uploadFile" accept="image/*"><br><br>
                <input type="submit" value="동물 정보 등록하기">
            </form>

            <!--이 부분은 AI에게 문의하여 작성한 주소 api를 가져와서 입력받는 부분입니다.-->
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
                function execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function (data) {
                            var roadAddr = data.roadAddress; // 도로명 주소 변수
                            var extraRoadAddr = ''; // 참고 항목 변수

                            // bname 이 비어있지 않고, '동,로,가'로 끝난다면
                            if (data.bname !== '' && /[동로가]$/g.test(data.bname)) {
                                extraRoadAddr += data.bname;
                            }
                            // buildingName 이 비어있지 않고, 'Y'일 경우 추가한다.
                            if (data.buildingName !== '' && data.apartment === 'Y') {
                                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if (extraRoadAddr !== '') {
                                extraRoadAddr = ' (' + extraRoadAddr + ')';
                            }

                            // 우편번호와 주소 정보를 해당 필드에 넣는다.
                            document.getElementById('postcode').value = data.zonecode;
                            document.getElementById("roadAddress").value = roadAddr;

                        }
                    }).open();
                }

                // 폼 제출 시 주소 합치기
                document.querySelector('form[action="adoption.insert.animal"]').addEventListener('submit', function (e) {
                    var roadAddr = document.getElementById('roadAddress').value;
                    var detailAddr = document.getElementById('detailAddress').value;

                    if (roadAddr) {
                        var fullAddr = roadAddr;
                        if (detailAddr) {
                            fullAddr += " " + detailAddr;
                        }
                        document.getElementById('hopeRegion').value = fullAddr;
                    }
                });
            </script>
        </body>

        </html>