<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>봉사활동 후기 상세</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <style>
                    body {
                        font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
                        background-color: #f8f9fa;
                        margin: 0;
                        padding: 0;
                    }

                    .container {
                        width: 1000px;
                        margin: 50px auto;
                        background-color: white;
                        padding: 40px;
                        border-radius: 15px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                    }

                    h2 {
                        text-align: center;
                        margin-bottom: 40px;
                        color: #333;
                        font-weight: 800;
                    }

                    .detail-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 30px;
                    }

                    .detail-table th,
                    .detail-table td {
                        border-bottom: 1px solid #eee;
                        padding: 15px;
                        text-align: left;
                    }

                    .detail-table th {
                        width: 150px;
                        background-color: #f8f9fa;
                        font-weight: bold;
                        color: #555;
                    }

                    .review-content {
                        min-height: 300px;
                        padding: 30px;
                        background-color: #f9f9f9;
                        border-radius: 10px;
                        line-height: 1.6;
                        color: #444;
                        white-space: pre-line;
                        /* 줄바꿈 적용 */
                    }

                    .star-points {
                        color: #ffc107;
                        letter-spacing: -2px;
                    }

                    .btn-area {
                        text-align: center;
                        margin-top: 40px;
                    }

                    .btn-list {
                        background-color: #007bff;
                        color: white;
                        padding: 12px 30px;
                        border: none;
                        border-radius: 50px;
                        font-weight: bold;
                        text-decoration: none;
                        display: inline-block;
                        transition: background-color 0.3s;
                    }

                    .btn-list:hover {
                        background-color: #0056b3;
                    }

                    /* --- 여기에 추가하세요 --- */
                    .comment-container {
                        background-color: #f8f9fa;
                        border-radius: 12px;
                        padding: 25px;
                        margin-top: 30px;
                        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.02);
                    }

                    .comment-header {
                        display: flex;
                        align-items: center;
                        gap: 20px;
                        margin-bottom: 15px;
                        font-weight: 600;
                        color: #333;
                    }

                    .rating-group {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .rating-item {
                        display: flex;
                        align-items: center;
                        gap: 4px;
                        cursor: pointer;
                        font-size: 15px;
                        transition: color 0.2s;
                    }

                    .rating-item:hover {
                        color: #ffc107;
                    }

                    .rating-item input[type="radio"] {
                        margin: 0;
                        cursor: pointer;
                        accent-color: #ffc107;
                    }

                    .comment-textarea {
                        width: 100%;
                        height: 100px;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        padding: 15px;
                        resize: none;
                        font-family: inherit;
                        font-size: 14px;
                        transition: border-color 0.3s;
                    }

                    .comment-textarea:focus {
                        outline: none;
                        border-color: #007bff;
                        box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
                    }

                    .comment-footer {
                        display: flex;
                        justify-content: flex-end;
                        margin-top: 10px;
                    }

                    .btn-submit {
                        background-color: #333;
                        color: white;
                        padding: 10px 25px;
                        border: none;
                        border-radius: 6px;
                        font-weight: bold;
                        cursor: pointer;
                        transition: background 0.2s;
                    }

                    .btn-submit:hover {
                        background-color: #000;
                    }
                </style>
            </head>

            <body>

                <jsp:include page="../common/menubar.jsp" />

                <div class="container">
                    <h2>📑 후기 상세 보기</h2>

                    <!-- [추가] 후기 제목을 크게 표시 -->
                    <div
                        style="font-size: 24px; font-weight: bold; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #333;">
                        ${r.rTitle}
                    </div>

                    <table class="detail-table">
                        <tr>
                            <th>활동명</th>
                            <td>${r.actTitle}</td>
                            <th>작성일</th>
                            <td>
                                <fmt:formatDate value="${r.rCreate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>${r.rId}</td>
                            <th>별점</th>
                            <td class="star-points">
                                <c:choose>
                                    <c:when test="${r.actRate > 0}">
                                        <span style="font-size: 20px;">⭐</span>
                                        <fmt:formatNumber value="${r.actRate}" pattern="0.0" /> <span
                                            style="color:#aaa; font-size:14px;">/ 5.0</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#ccc;">첫 평점을 남겨주세요! (0.0)</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>

                    <div class="review-content">
                        ${r.rReview}
                    </div>

                    <!-- [추가] 댓글 및 평점 섹션 -->
                    <div style="margin-top: 50px; border-top: 2px solid #eee; padding-top: 30px;">
                        <h3 style="text-align: left; margin-bottom: 20px;">💬 댓글 및 평점</h3>

                        <c:choose>
                            <c:when test="${not empty loginMember}">
                                <div class="comment-container">
                                    <div class="comment-header">
                                        <span>${loginMember.userId}</span>
                                        <div class="rating-group">
                                            <span style="font-size: 14px; color: #666; margin-right: 5px;">평점 선택:</span>
                                            <label class="rating-item">선택안함 <input type="radio" name="cmtRate" value=""
                                                    checked></label>
                                            <label class="rating-item">5 ⭐ <input type="radio" name="cmtRate"
                                                    value="5"></label>
                                            <label class="rating-item">4 ⭐ <input type="radio" name="cmtRate"
                                                    value="4"></label>
                                            <label class="rating-item">3 ⭐ <input type="radio" name="cmtRate"
                                                    value="3"></label>
                                            <label class="rating-item">2 ⭐ <input type="radio" name="cmtRate"
                                                    value="2"></label>
                                            <label class="rating-item">1 ⭐ <input type="radio" name="cmtRate"
                                                    value="1"></label>
                                        </div>
                                    </div>

                                    <textarea class="comment-textarea" id="replyContent"
                                        placeholder="봉사활동에 대한 따뜻한 후기를 남겨주세요!"></textarea>

                                    <div class="comment-footer">
                                        <button type="button" class="btn-submit" onclick="addReply()">등록</button>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div
                                    style="text-align: center; color: #666; padding: 20px; background: #f8f9fa; border-radius: 10px;">
                                    댓글을 작성하려면 <a href="${pageContext.request.contextPath}/user/login.me"
                                        style="color: #007bff; font-weight: bold; text-decoration: none;">로그인</a>이
                                    필요합니다.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div id="replyArea" style="margin-top: 30px;"></div>
                    </div>
                    <script>
                        $(function () {
                            selectReplyList();
                        });

                        // 댓글 목록 조회 (기존 volunteerDetail.jsp 로직 재사용, actId 기준)
                        function selectReplyList() {
                            var actId = "${r.actId}";
                            var reviewNo = "${r.reviewNo}";
                            $.ajax({
                                url: "reviewReplyList.vo",
                                data: {
                                    actId: actId,
                                    reviewNo: reviewNo
                                },
                                success: function (list) {
                                    var value = "";
                                    if (list.length == 0) {
                                        value += "<div style='text-align:center; padding:20px; color:#999;'>첫 번째 댓글의 주인공이 되어보세요!</div>";
                                    } else {
                                        for (var i in list) {
                                            value += "<div style='border-bottom: 1px solid #eee; padding: 15px 0;'>";
                                            value += "   <div style='display:flex; justify-content:space-between; margin-bottom:5px;'>";
                                            value += "      <div>";
                                            value += "         <strong>" + list[i].userId + "</strong>";
                                            value += "         <span style='color:#999; font-size:12px; margin-left:10px;'>" + list[i].cmtDate + "</span>";

                                            // [평점 표시]
                                            if (list[i].cmtRate != null && list[i].cmtRate > 0) {
                                                value += " <span style='color:#ffc107; font-weight:bold; margin-left:10px;'>⭐ " + list[i].cmtRate + "점</span>";
                                            }

                                            value += "      </div>";
                                            // 삭제 버튼
                                            if ("${loginMember.userId}" == list[i].userId || "${loginMember.userRole}" == "ADMIN") {
                                                value += "      <button onclick='deleteReply(" + list[i].cmtNo + ")' style='background:none; border:none; color:red; cursor:pointer; font-size:12px;'>삭제</button>";
                                            }
                                            value += "   </div>";
                                            value += "   <div style='color:#444;'>" + list[i].cmtAnswer + "</div>";
                                            value += "</div>";
                                        }
                                    }
                                    $("#replyArea").html(value);
                                },
                                error: function () { console.log("댓글 조회 실패"); }
                            });
                        }

                        // 댓글 등록
                        function addReply() {
                            var content = $("#replyContent").val();
                            var rating = $("input[name='cmtRate']:checked").val(); // 선택된 별점 값 (없으면 "" 또는 undefined)

                            if (content.trim() == "") { alert("내용을 입력해주세요!"); return; }

                            $.ajax({
                                url: "reviewInsertReply.vo",
                                data: {
                                    actId: "${r.actId}",
                                    reviewNo: "${r.reviewNo}",
                                    userId: "${loginMember.userId}",
                                    cmtAnswer: content,
                                    cmtRate: rating // 별점 전송
                                },
                                success: function (result) {
                                    if (result == "success") {
                                        alert("댓글이 등록되었습니다.");
                                        $("#replyContent").val("");
                                        $("input[name='cmtRate'][value='']").prop("checked", true); // 별점 초기화
                                        selectReplyList();
                                        // 평점 실시간 반영을 위해 새로고침을 할 수도 있지만, 
                                        // 여기서는 간단히 두기 위해(비동기 갱신 복잡도 때문) 그냥 둡니다. 
                                        // 완벽하게 하려면 location.reload()가 가장 확실함.
                                        location.reload();
                                    } else { alert("댓글 등록 실패"); }
                                },
                                error: function () { alert("통신 에러가 발생했습니다."); }
                            });
                        }

                        function deleteReply(cmtNo) {
                            if (confirm("댓글을 삭제하시겠습니까?")) {
                                $.ajax({
                                    url: "deleteReply.vo",
                                    data: { cmtNo: cmtNo },
                                    success: function (result) {
                                        if (result == "success") {
                                            alert("삭제되었습니다.");
                                            location.reload(); // 평점 재계산 반영 위해 새로고침
                                        }
                                        else alert("삭제 실패");
                                    }
                                });
                            }
                        }
                    </script>

                    <div class="btn-area">
                        <a href="reviewList.vo" class="btn-list">목록으로</a>

                        <%-- 아이디가 admin1이거나, 계정 권한(userRole)이 ADMIN인 경우 버튼 노출 --%>
                            <c:if test="${loginMember.userRole eq 'ADMIN'}">
                                <a href="reviewUpdateForm.vo?reviewNo=${r.reviewNo}" class="btn-list"
                                    style="background-color: #ffc107;">수정</a>

                                <a href="deleteReview.vo?reviewNo=${r.reviewNo}"
                                    onclick="return confirm('관리자 권한으로 삭제하시겠습니까?');" class="btn-list"
                                    style="background-color: #dc3545;">삭제</a>
                            </c:if>
                    </div>
                </div>

            </body>

            </html>