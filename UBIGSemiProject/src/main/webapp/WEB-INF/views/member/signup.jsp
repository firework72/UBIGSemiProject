<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>유봉일공 - 회원가입</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="">
    
    <style>
        body { background-color: #f8f9fa; }
        .signup-card {
            max-width: 600px;
            margin: 50px auto;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
        }
        .signup-header {
            background-color: #FFC107; /* 유봉일공 테마 컬러 */
            color: white;
            text-align: center;
            padding: 20px;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            font-weight: bold;
            font-size: 1.5rem;
        }
        .form-label { font-weight: bold; font-size: 0.9rem; }
        .btn-custom {
            background-color: #FFC107; border-color: #FFC107; color: white; font-weight: bold;
        }
        .btn-custom:hover { background-color: #e0a800; color: white; }
        .error-msg { color: red; font-size: 0.8rem; display: none; }
    </style>
</head>
<body>
<div class="card signup-card">
    <div class="signup-header">
        유봉일공 회원가입
    </div>
    <div class="card-body p-4">
        
        <form action="${pageContext.request.contextPath}/user/sign.me" method="post" id="signupForm">
            
            <div class="mb-3">
                <label for="userId" class="form-label">아이디</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="userId" name="userId" placeholder="영문, 숫자 포함 6~20자" required>
                </div>
                <div id="idCheckResult" class="form-text"></div>
                <div class="error-msg" id="idError">영문 또는 숫자를 포함하여 6~20자로 작성해주세요.</div>
            </div>

            <div class="mb-3">
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="비밀번호 입력" required>
            </div>
            
            <div class="mb-3">
                <label for="userPwdConfirm" class="form-label">비밀번호 확인</label>
                <input type="password" class="form-control" id="userPwdConfirm" placeholder="비밀번호 재입력" required>
                <div class="error-msg" id="pwdError">비밀번호가 일치하지 않습니다.</div>
            </div>

            <div class="mb-3">
                <label for="userName" class="form-label">이름</label>
                <input type="text" class="form-control" id="userName" name="userName" maxlength="10" required>
                <div class="error-msg" id="userNameError">1~10자의 한글로 작성해주세요.</div>
            </div>

            <div class="mb-3">
                <label for="userNickname" class="form-label">닉네임</label>
                <input type="text" class="form-control" id="userNickname" name="userNickname" maxlength="10" required>
                <div class="error-msg" id="userNicknameError">1~10자의 영문, 한글, 숫자로 작성해주세요.</div>
            </div>

            <div class="mb-3">
                <label for="userContact" class="form-label">연락처</label>
                <input type="text" class="form-control" id="userContact" name="userContact" placeholder="01012345678" maxlength="11" required>
                <div class="error-msg" id="userContactError">숫자로만 11자리 작성해주세요.</div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">성별</label>
                    <div class="d-flex gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="userGender" id="genderM" value="M" checked>
                            <label class="form-check-label" for="genderM">남성</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="userGender" id="genderF" value="F">
                            <label class="form-check-label" for="genderF">여성</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <label for="userAge" class="form-label">나이</label>
                    <input type="number" class="form-control" id="userAge" name="userAge" min="1" max="120" required>
                    <div class="error-msg" id="ageError">19세 미만은 가입할 수 없습니다.</div>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">주소</label>
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="postcode" placeholder="우편번호" readonly>
                    <button class="btn btn-outline-secondary" type="button" onclick="execDaumPostcode()">주소 검색</button>
                </div>
                <input type="text" class="form-control mb-2" id="roadAddress" placeholder="도로명 주소" readonly>
                <input type="text" class="form-control" id="detailAddress" placeholder="상세 주소를 입력하세요" maxlength="20">
                <div class="error-msg" id="detailAddressError">1~20자의 한글, 숫자, 공백으로 작성해주세요.</div>
                <input type="hidden" id="userAddress" name="userAddress">
            </div>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-custom btn-lg">회원가입 완료</button>
            </div>
        </form>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

	// 정규표현식
	let nameRegExr = /^[가-힣]{1,10}$/;
	let nicknameRegExr = /^[a-zA-Z0-9가-힣]{1,10}$/;
	let contactRegExr = /^[0-9]{11}$/;
	let addressRegExr = /^[가-힣0-9\s]+$/;
	
	
    // 1. Daum 주소 API 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소 변수
                var roadAddr = data.roadAddress; 
                
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }

    // 2. 유효성 검사 및 폼 제출 로직
    $(document).ready(function() {
    	
    	// 아이디 중복 확인 및 영문, 숫자 6~20자리인지 확인
    	$("#userId").on("keyup", function() {
    		var userId = $("#userId").val();
    		

            // 아이디 중복 확인
            $.ajax({
                url: "${pageContext.request.contextPath}/user/checkId.me", 
                type: "post",
                data: { userId: userId },
                success: function(result) {
                	// return 값으로 fail 또는 success 중 하나 전송
                    if(result == "fail") {
                        $("#idCheckResult").text("이미 사용 중인 아이디입니다.").css("color", "red");
                    } else {
                        $("#idCheckResult").text("사용 가능한 아이디입니다.").css("color", "green");
                    }
                },
                error: function() {
                    alert("통신 오류가 발생했습니다.");
                }
            });
            
            // 영문, 숫자 6~20자리인지 확인
            let regExp = /^[a-zA-Z0-9]{6,20}$/;
            
            if (!regExp.test(userId)) {
            	$("#idError").show();
            }
            else {
            	$("#idError").hide();
            }
    	});
    
        
        // 비밀번호 일치 확인
        $("#userPwdConfirm").on("keyup", function() {
            var pwd = $("#userPwd").value;
            var pwdConfirm = $(this).val();
            
            if($("#userPwd").val() != pwdConfirm) {
                $("#pwdError").show();
            } else {
                $("#pwdError").hide();
            }
        });
        
        // 19세 미만이면 가입 불가능
        $("#userAge").on("blur", function() {
        	var age = $("#userAge").val();
        	
        	if (age < 19) {
        		$("#ageError").show();
        	}
        	else {
        		$("#ageError").hide();
        	}
        });
        
        // 정규식 표현에 안 맞으면 차단
        
        // 이름
        
        $("#userName").on("keyup", function() {
            var userName = $("#userName").val();
            
            if(!nameRegExr.test(userName)) {
                $("#userNameError").show();
            } else {
                $("#userNameError").hide();
            }
        });
        
        // 닉네임
        
        $("#userNickname").on("keyup", function() {
            var userNickname = $("#userNickname").val();
            
            if(!nicknameRegExr.test(userNickname)) {
                $("#userNicknameError").show();
            } else {
                $("#userNicknameError").hide();
            }
        });
        
        // 연락처
        
        $("#userContact").on("keyup", function() {
            var userContact = $("#userContact").val();
            
            if(!contactRegExr.test(userContact)) {
                $("#userContactError").show();
            } else {
                $("#userContactError").hide();
            }
        });
        
       	// 상세주소
       	
        $("#detailAddress").on("keyup", function() {
            var detailAddress = $("#detailAddress").val();
            
            if(!addressRegExr.test(detailAddress)) {
                $("#detailAddressError").show();
            } else {
                $("#detailAddressError").hide();
            }
        });

        // 폼 제출 시 실행
        $("#signupForm").on("submit", function(e) {
        	
        	// TODO : 아이디 중복이면 차단
            
            // 비밀번호 불일치 시 차단
            if($("#userPwd").val() != $("#userPwdConfirm").val()){
                alert("비밀번호가 일치하지 않습니다.");
                $("#userPwdConfirm").focus();
                e.preventDefault(); // 전송 막기
                return;
            }
        
        	// 19세 미만이면 차단
        	if($("#userAge").val() < 19) {
        		alert("19세 미만은 가입할 수 없습니다.");
        		$("#userAge").focus();
        		e.preventDefault();
        		return;
        	}
        	
        	let userName = $("#userName").val();
        	let userNickname = $("#userNickname").val();
        	let userContact = $("#userContact").val();
        	let detailAddress = $("#detailAddress").val();
        	
        	// 정규식 표현에 안 맞으면 차단
           	
           	if (!nameRegExr.test(userName)) {
           		alert("이름은 1~10글자 사이의 한글만 가능합니다.");
           		return false;
           	}
           	
           	if (!nicknameRegExr.test(userNickname)) {
           		alert("닉네임은 1~10글자 사이의 영문, 한글, 숫자만 가능합니다.");
           		return false;
           	}
           	
           	if (!contactRegExr.test(userContact)) {
           		alert("연락처는 11자리의 숫자만 가능합니다.");
           		return false;
           	}
           	
           	if (!addressRegExr.test(detailAddress)) {
           		alert("상세주소는 한글, 숫자, 공백만 포함 가능합니다.");
           		return false;
           	}

            // 주소 합치기 (도로명 주소 + 상세 주소) -> hidden input에 저장
            var fullAddr = $("#roadAddress").val();
            if($("#detailAddress").val() !== "") {
                fullAddr += ", " + $("#detailAddress").val();
            }
            $("#userAddress").val(fullAddr);
            
            // 주소 입력 확인
            if(fullAddr === "") {
                alert("주소를 검색해주세요.");
                e.preventDefault();
                return;
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>