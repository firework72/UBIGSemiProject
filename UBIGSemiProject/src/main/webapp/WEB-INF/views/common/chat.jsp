<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
    /* 1. 둥둥 떠있는 채팅 버튼 (Launcher) */
    #chat-launcher-btn {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background-color: #FFC107; /* 유봉일공 테마 컬러 */
        color: white;
        border-radius: 50%;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        display: flex; /* 아이콘 중앙 정렬 */
        align-items: center;
        justify-content: center;
        font-size: 30px;
        cursor: pointer;
        z-index: 9990; /* 다른 요소보다 위에 */
        transition: transform 0.3s;
    }
    #chat-launcher-btn:hover {
        transform: scale(1.1); /* 마우스 올리면 살짝 커짐 */
        background-color: #e0a800;
    }

    /* 2. 채팅창 본체 (초기 상태: 숨김) */
    #chat-widget-window {
        display: none; /* 처음엔 안 보임 */
        position: fixed;
        bottom: 100px; /* 버튼보다 조금 위에 위치 */
        right: 30px;
        width: 350px;
        height: 500px;
        background-color: white;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        z-index: 9999;
        overflow: hidden;
        flex-direction: column;
    }

    /* 채팅창 헤더 */
    .chat-header {
        background-color: #FFC107;
        color: white;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: bold;
    }
    .chat-close-btn {
        cursor: pointer;
        font-size: 1.2rem;
    }
    .chat-close-btn:hover {
        color: #f8f9fa;
    }

    /* 채팅 내용 영역 */
    .chat-body {
        flex: 1; /* 남은 공간 다 차지 */
        padding: 15px;
        overflow-y: auto; /* 스크롤 생김 */
        background-color: #f8f9fa;
    }
    
    /* 채팅 입력 영역 */
    .chat-footer {
        padding: 10px;
        background-color: white;
        border-top: 1px solid #dee2e6;
        display: flex;
        gap: 10px;
    }
    .chat-input {
        flex: 1;
        border: 1px solid #ced4da;
        border-radius: 20px;
        padding: 5px 15px;
        outline: none;
    }
    .chat-send-btn {
        background-color: #FFC107;
        border: none;
        color: white;
        border-radius: 50%;
        width: 35px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    /* 말풍선 스타일 예시 */
    .msg-row { margin-bottom: 10px; display: flex; }
    .msg-row.my-msg { justify-content: flex-end; }
    .msg-bubble {
        max-width: 70%;
        padding: 8px 12px;
        border-radius: 15px;
        font-size: 0.9rem;
    }
    .my-msg .msg-bubble { background-color: #FFC107; color: white; border-bottom-right-radius: 0; }
    .other-msg .msg-bubble { background-color: #e9ecef; color: black; border-bottom-left-radius: 0; }
</style>

<div id="chat-launcher-btn" onclick="toggleChatWindow()">
    <i class="bi bi-chat-dots-fill"></i>
</div>

<div id="chat-widget-window">
    <div class="chat-header">
        <span>🐕 1:1 문의하기</span>
        <i class="bi bi-x-lg chat-close-btn" onclick="toggleChatWindow()"></i>
    </div>

    <div class="chat-body" id="chatMessageArea">
        <div class="msg-row other-msg">
            <div class="msg-bubble">안녕하세요! 무엇을 도와드릴까요?</div>
        </div>
        </div>

    <div class="chat-footer">
        <input type="text" class="chat-input" id="chatInput" placeholder="메시지를 입력하세요..." onkeypress="handleEnter(event)">
        <button class="chat-send-btn" onclick="sendMessage()">
            <i class="bi bi-send-fill"></i>
        </button>
    </div>
</div>

<script>
    // 1. 채팅창 열고 닫기 (Toggle)
    function toggleChatWindow() {
        var chatWindow = document.getElementById("chat-widget-window");
        var launcherBtn = document.getElementById("chat-launcher-btn");

        if (chatWindow.style.display === "none" || chatWindow.style.display === "") {
            // 열기: 버튼 숨기고 창 보이기 (원하면 버튼 유지하고 창만 띄울 수도 있음)
            chatWindow.style.display = "flex"; 
            launcherBtn.style.display = "none"; // 버튼 숨김
        } else {
            // 닫기: 창 숨기고 버튼 보이기
            chatWindow.style.display = "none";
            launcherBtn.style.display = "flex"; // 버튼 다시 보임
        }
    }
    
    // 2. 엔터키 전송 처리
    function handleEnter(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    }

    // 3. 메시지 전송 (화면에 뿌리기용 - 추후 DB/Socket 연동 필요)
    function sendMessage() {
        var input = document.getElementById("chatInput");
        var msg = input.value.trim();
        var chatArea = document.getElementById("chatMessageArea");

        if (msg === "") return;

        // 내 메시지 HTML 생성
        var myMsgHtml = '<div class="msg-row my-msg">' +
                            '<div class="msg-bubble">' + msg + '</div>' +
                        '</div>';
        
        chatArea.insertAdjacentHTML('beforeend', myMsgHtml);
        
        // 스크롤 최하단으로 이동
        chatArea.scrollTop = chatArea.scrollHeight;

        // 입력창 초기화
        input.value = "";
        input.focus();
        
        // (선택사항) 여기에 실제 서버로 전송하는 AJAX 코드 작성
    }
</script>