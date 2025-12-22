<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <input type="text" name="hopeRegion" placeholder="예: 서울, 경기"><br>

            <label>14. 공고 마감일 (Deadline)</label>
            <input type="date" name="deadlineDate"><br>

            <label>15. 사진 첨부 (Photo)</label>
            <input type="file" name="uploadFile" accept="image/*"><br><br>
            <input type="submit" value="동물 정보 등록하기">
        </form>
    </body>

    </html>