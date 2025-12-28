<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>UBIG - 동물 등록</title>
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
                <h1 class="adoption-header">
                    <c:choose>
                        <c:when test="${not empty animal}">[동물 정보 수정]</c:when>
                        <c:otherwise>[동물 정보 등록]</c:otherwise>
                    </c:choose>
                </h1>

                <form action="${not empty animal ? 'adoption.update.animal.action' : 'adoption.insert.animal'}"
                    method="POST" enctype="multipart/form-data" class="adoption-form">

                    <c:if test="${not empty animal}">
                        <input type="hidden" name="animalNo" value="${animal.animalNo}">
                        <input type="hidden" name="originalPhotoUrl" value="${animal.photoUrl}">
                    </c:if>

                    <label>1. 축종 (Species)</label>
                    <select name="species" id="species" required>
                        <option value="1">강아지</option>
                        <option value="2">고양이</option>
                    </select>

                    <label>2. 이름 (Name)</label>
                    <input type="text" name="animalName" id="animalName" placeholder="예: 뽀삐" required
                        pattern="^[가-힣a-zA-Z0-9\s]+$" title="특수문자는 사용할 수 없습니다 (한글, 영문, 숫자, 공백 허용)">

                    <label>3. 품종 (Breed)</label>
                    <input type="text" name="breed" id="breed" placeholder="예: 말티즈" required pattern="^[가-힣a-zA-Z\s]+$"
                        title="특수문자 및 숫자는 사용할 수 없습니다 (한글, 영문, 공백 허용)">

                    <label>4. 성별 (Gender)</label>
                    <div class="radio-group">
                        <label style="font-weight: normal; margin-bottom: 0;"><input type="radio" name="gender"
                                id="genderM" value="1" checked> 수컷(M)</label>
                        <label style="font-weight: normal; margin-bottom: 0;"><input type="radio" name="gender"
                                id="genderF" value="2"> 암컷(F)</label>
                    </div>

                    <label>5. 나이 (Age / 살)</label>
                    <input type="number" name="age" id="age" step="0.1" placeholder="예: 2.5" required min="0" max="50">

                    <label>6. 체중 (Weight / kg)</label>
                    <input type="number" name="weight" id="weight" step="0.1" placeholder="예: 5.2" required min="0"
                        max="100">

                    <label>7. 크기 (Size)</label>
                    <input type="number" name="petSize" id="petSize" step="0.1" placeholder="크기 수치 입력" required min="0">

                    <label>8. 중성화 여부 (Neutered)</label>
                    <div class="radio-group">
                        <label style="font-weight: normal; margin-bottom: 0;"><input type="radio" name="neutered"
                                id="neuteredY" value="1"> 완료(Yes)</label>
                        <label style="font-weight: normal; margin-bottom: 0;"><input type="radio" name="neutered"
                                id="neuteredN" value="0" checked> 미완료(No)</label>
                    </div>

                    <label>9. 접종 상태 (Vaccination Status)_선택</label>
                    <input type="text" name="vaccinationStatus" id="vaccinationStatus" placeholder="예: 3차 완료"
                        defaultValue="미접종">

                    <label>10. 특이사항 (Health Notes)_선택</label>
                    <textarea name="healthNotes" id="healthNotes" rows="3" placeholder="건강 상태 및 특징 작성"
                        defaultValue="건강 상태 정상"></textarea>

                    <label>11. 입양 상태 (Status)_선택</label>
                    <select name="adoptionStatus" id="adoptionStatus">
                        <option value="대기중">대기중</option>
                        <option value="신청중" disabled>신청중</option>
                        <option value="완료" disabled>완료</option>
                    </select>

                    <label>12. 입양 조건 (Conditions)_선택</label>
                    <textarea name="adoptionConditions" id="adoptionConditions" rows="3" placeholder="필수 입양 조건 작성"
                        defaultValue="조건 없음"></textarea>

                    <label>13. 입양 희망 지역 (Hope Region)</label>
                    <div style="display: flex; gap: 10px; margin-bottom: 10px;">
                        <input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly
                            style="width: 150px; margin-bottom: 0;" required>
                        <button type="button" onclick="execDaumPostcode()" class="btn-secondary"
                            style="padding: 10px;">주소 검색</button>
                    </div>
                    <input type="text" id="roadAddress" name="roadAddress" placeholder="도로명 주소" readonly
                        style="margin-bottom: 10px;" required>
                    <input type="hidden" name="hopeRegion" id="hopeRegion">

                    <label>14. 공고 마감일 (Deadline)</label>
                    <input type="date" name="deadlineDate" id="deadlineDate" required>

                    <label>15. 사진 첨부 (Photo)</label>
                    <c:if test="${not empty animal.photoUrl}">
                        <div style="margin-bottom: 5px;">현재 파일: ${animal.photoUrl}</div>
                    </c:if>
                    <input type="file" name="uploadFile" accept="image/*" style="border: none; padding-left: 0;" ${empty
                        animal ? 'required' : '' }>

                    <div class="text-center mt-20">
                        <input type="submit" value="${not empty animal ? '동물 정보 수정하기' : '동물 정보 등록하기'}"
                            class="btn-primary">
                    </div>
                </form>
            </div>

            <!--작성한 주소 api를 가져와서 입력받는 부분입니다.-->
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

                // 폼 제출 시 주소 합치기 (상세 주소 로직 제거)
                document.querySelector('.adoption-form').addEventListener('submit', function (e) {
                    var roadAddr = document.getElementById('roadAddress').value;

                    if (roadAddr) {
                        document.getElementById('hopeRegion').value = roadAddr;
                    }
                });

                //동물 정보 가져온 것 대입하기
                document.addEventListener('DOMContentLoaded', function () {
                    if ("${animal.species}") document.querySelector("#species").value = "${animal.species}";
                    if ("${animal.animalName}") document.querySelector("#animalName").value = "${animal.animalName}";
                    if ("${animal.breed}") document.querySelector("#breed").value = "${animal.breed}";
                    if ("${animal.gender}") {
                        const genderVal = "${animal.gender}";
                        const genderRadio = document.querySelector(`input[name="gender"][value="${animal.gender}"]`);
                        if (genderRadio) genderRadio.checked = true;
                    }
                    if ("${animal.age}") document.querySelector("#age").value = "${animal.age}";
                    if ("${animal.weight}") document.querySelector("#weight").value = "${animal.weight}";
                    if ("${animal.petSize}") document.querySelector("#petSize").value = "${animal.petSize}";
                    if ("${animal.neutered}") {
                        const neuteredVal = "${animal.neutered}";
                        const neuteredRadio = document.querySelector(`input[name="neutered"][value="${animal.neutered}"]`);
                        if (neuteredRadio) neuteredRadio.checked = true;
                    }
                    if ("${animal.vaccinationStatus}") document.querySelector("#vaccinationStatus").value = "${animal.vaccinationStatus}";
                    if ("${animal.healthNotes}") document.querySelector("#healthNotes").value = "${animal.healthNotes}";

                    // 수정 시에는 상태가 '대기중'으로 초기화되므로 폼에서도 대기중으로 표시 (backend에서 forced reset)
                    if ("${animal.animalNo}") {
                        document.querySelector("#adoptionStatus").value = "대기중";
                        // 사용자 혼란 방지를 위해 비활성화 하거나 메시지 표시 (선택사항)
                    } else {
                        if ("${animal.adoptionStatus}") document.querySelector("#adoptionStatus").value = "${animal.adoptionStatus}";
                    }
                    if ("${animal.adoptionConditions}") document.querySelector("#adoptionConditions").value = "${animal.adoptionConditions}";

                    // 주소 정보 처리
                    if ("${animal.hopeRegion}") {
                        document.querySelector("#hopeRegion").value = "${animal.hopeRegion}";
                        // 도로명 주소란에 전체 주소 표시
                        document.querySelector("#roadAddress").value = "${animal.hopeRegion}";
                    }

                    if ("${animal.deadlineDate}") document.querySelector("#deadlineDate").value = "${animal.deadlineDate}";
                });
            </script>
        </body>

        </html>