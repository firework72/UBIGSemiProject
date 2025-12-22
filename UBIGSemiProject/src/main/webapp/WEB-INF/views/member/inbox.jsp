<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유봉일공 - 쪽지함</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        body { background-color: #f8f9fa; }
        .msg-container { max-width: 1000px; margin: 50px auto; }
        
        /* 탭 스타일 */
        .nav-tabs .nav-link { color: #495057; font-weight: 500; }
        .nav-tabs .nav-link.active { color: #000; font-weight: bold; border-bottom: 3px solid #FFC107; }
        
        /* 테이블 스타일 */
        .table-hover tbody tr { cursor: pointer; transition: 0.2s; }
        .unread-msg { font-weight: bold; background-color: #fffef0; } /* 읽지 않은 쪽지 배경색 */
        .msg-preview {
            display: inline-block;
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
        }
        
        .btn-write { background-color: #FFC107; border: none; font-weight: bold; color: white; }
        .btn-write:hover { background-color: #e0a800; color: white; }
    </style>
</head>
<body>

<div class="container msg-container">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">📬 나의 쪽지함</h2>
        <button class="btn btn-write px-4 py-2" data-bs-toggle="modal" data-bs-target="#writeModal">
            + 쪽지 쓰기
        </button>
    </div>

    <ul class="nav nav-tabs mb-3">
        <li class="nav-item">
            <a class="nav-link active" href="/message/inbox">받은 쪽지함 <span class="badge bg-danger rounded-pill ms-1">${unreadCount}</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/message/sent">보낸 쪽지함</a>
        </li>
    </ul>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <table class="table table-hover mb-0 text-center align-middle">
                <thead class="table-light">
                    <tr>
                        <th scope="col" style="width: 10%;">상태</th>
                        <th scope="col" style="width: 15%;">보낸 사람</th>
                        <th scope="col" style="width: 60%;">내용</th>
                        <th scope="col" style="width: 15%;">날짜</th>
                    </tr>
                </thead>
                <tbody>
                	<!-- 받은 쪽지가 없으면 받은 쪽지가 없습니다. 텍스트를 출력하고, 아니라면 받은 메시지 리스트를 보여주기 -->
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="5" class="py-5 text-secondary">받은 쪽지가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="msg" items="${list}">
                                <tr class="${msg.messageIsCheck == 'N' ? 'unread-msg' : ''}" 
                                    onclick="openMessageDetail(${msg.messageNo}, '${msg.messageSendUserId}', '${msg.messageContent}', '${msg.messageCreateDate}', '${msg.messageIsCheck}')">
                                    
                                    <td>
                                        <c:if test="${msg.messageIsCheck == 'N'}">
                                            <span class="badge bg-danger">안 읽음</span>
                                        </c:if>
                                        <c:if test="${msg.messageIsCheck == 'Y'}">
                                            <span class="badge bg-secondary">읽음</span>
                                        </c:if>
                                    </td>

                                    <td>${msg.messageSendUserId}</td>

                                    <td class="text-start ps-4">
                                        <span class="msg-preview text-dark text-decoration-none">
                                            ${msg.messageContent}
                                        </span>
                                    </td>

                                    <td class="text-secondary small">
                                        <fmt:formatDate value="${msg.messageCreateDate}" pattern="yyyy.MM.dd HH:mm"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    </div>

<!-- 쪽지 상세 보기 모달 -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold">쪽지 내용</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3 border-bottom pb-2">
                    <label class="text-secondary small">보낸 사람</label>
                    <div class="fw-bold fs-5" id="modalSender"></div>
                </div>
                <div class="mb-3 border-bottom pb-2">
                    <label class="text-secondary small">보낸 날짜</label>
                    <div id="modalDate"></div>
                </div>
                <div class="mb-3">
                    <label class="text-secondary small">내용</label>
                    <div class="p-3 bg-light rounded" id="modalContent" style="min-height: 100px; white-space: pre-wrap;"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="btnReply">답장하기</button>
            </div>
        </div>
    </div>
</div>

<!-- 쪽지 보내기 모달 -->
<div class="modal fade" id="writeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #FFC107; color: white;">
                <h5 class="modal-title fw-bold">쪽지 보내기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="/message/send" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold">받는 사람 ID</label>
                        <input type="text" class="form-control" name="messageReceiveUserId" id="receiveIdInput" placeholder="회원 ID를 입력하세요" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">내용</label>
                        <textarea class="form-control" name="messageContent" rows="5" placeholder="내용을 입력하세요 (최대 200자)" maxlength="200" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-warning text-white fw-bold">보내기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 1. 쪽지 상세 보기 함수
    function openMessageDetail(msgNo, sender, content, date, isCheck) {
        // 모달 내용 채우기
        $("#modalSender").text(sender);
        $("#modalContent").text(content); // text()로 넣어야 XSS 방지
        $("#modalDate").text(date); // 포맷팅된 문자열이 들어온다고 가정
        
        // 답장하기 버튼 클릭 시 -> 쓰기 모달의 받는 사람에 세팅하고 쓰기 모달 띄우기
        $("#btnReply").off("click").on("click", function() {
             // 상세 모달 닫고
             $("#detailModal").modal("hide");
             // 쓰기 모달 열기 + ID 세팅 (여기선 닉네임이 아니라 ID가 필요하므로, 실제론 ID도 파라미터로 넘겨야 함. 예시에선 닉네임으로 가정)
             // 주의: 실제 답장을 보내려면 senderId(USER_ID)가 필요합니다. 
             // JSP 루프에서 senderId도 같이 넘겨주는 것을 권장합니다.
             $("#receiveIdInput").val(sender); // 일단 초기화 (ID를 넘겨받았다면 .val(senderId))
             $("#writeModal").modal("show");
        });

        // 모달 띄우기
        $("#detailModal").modal("show");

        // 만약 선택된 쪽지가 아직 읽지 않은 쪽지라면, 읽음 상태로 변경한다.
        if(isCheck === 'N') {
            $.ajax({
                url: "/message/read",
                type: "POST",
                data: { messageNo: msgNo },
                success: function(res) {
                    // 성공 시 UI 업데이트 (뱃지 제거 등)는 새로고침 혹은 JS로 처리
                    console.log("읽음 처리 완료");
                }
            });
        }
    }
</script>

</body>
</html>