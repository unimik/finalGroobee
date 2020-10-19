<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/memberJoinForm.css">
    <title>GROOBEE</title>
</head>
<body>
    <div class="wapper">
        <img src="<%=request.getContextPath()%>/resources/icons/logo.png" alt="index_logo" id="index_logo" name="index_logo">
        <div id="content">
            <div id="inContent">
                <form action="memberJoin.do" method="post">
                    <div id="c1">
                        <div id="c1_1">
                            <div id="c1_1_1"><p>이용약관</p></div>
                            <div id="c1_1_2">
                                <textarea id="terms"  rows="9" readonly>
<제1장 총칙>
제1조(목적)
이 약관은 (주)넥슨코리아(이하 "회사"라고 함)가 제공하는 게임 및 제반 서비스의 이용과 관련하여 회원과 회사 간의 조건 및 절차에 관한 기본적인 사항을 정함을 목적으로 합니다.

제2조(용어의 정의)
① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1. 이용 계약: 회사가 제공하는 서비스 이용과 관련하여 회사와 이용 고객 간에 체결하는 계약을 말합니다.
2. 회원: 회사가 제공하는 절차에 따른 가입 신청 및 이용 계약 체결을 완료한 뒤, ID를 발급받아 회사의 서비스를 이용할 수 있는 자를 말합니다.
3. ID: 회원 식별과 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자, 특수문자, 숫자 등의 조합을 말합니다.
4. 체험 ID: 회원 식별과 회사가 제공하는 특정 서비스를 이용하기 위하여 회원이 선정하고 회사가 승인하는 문자, 특수문자, 숫자 등을 말합니다.
5. PASSWORD(이하 "비밀번호"라고 함): 회원이 자신의 ID 또는 체험 ID와 일치하는 이용 고객임을 확인하기 위해 선정한 문자, 특수문자, 숫자 등의 조합을 말합니다.
6. 회원 탈퇴: 회원이 이용 계약을 해지함을 의미합니다.
7. 계정 : ID에 수반하여 게임 이용을 위해 회원이 별도로 생성하는 캐릭터, 게임 ID 등을 의미합니다.
② 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계 법령 및 각 서비스 별 안내에서 정하는 바에 의합니다. 관계 법령과 각 서비스 별 안내에서 정하지 않는 것은 일반적인 상관례에 의합니다.
제3조(약관의 효력 및 적용과 변경)
① 회사는 이 약관의 내용을 회원이 알 수 있도록 회사에서 운영하는 홈페이지(www.nexon.com, 이하 "홈페이지"라 함)에 게시하거나 연결화면을 제공하는 방법으로 회원에게 공지합니다.
② 이 약관에 동의하고 회원 가입을 한 회원은 약관에 동의한 시점부터 동의한 약관의 적용을 받고 약관의 변경이 있을 경우에는 변경의 효력이 발생한 시점부터 변경된 약관의 적용을 받습니다. 이 약관에 동의하는 것은 정기적으로 홈페이지를 방문하여 약관의 변경 사항을 확인하는 것에 동의하는 것을 의미합니다.
③ 회사는 필요하다고 인정되는 경우 이 약관을 변경할 수 있습니다. 회사는 약관이 변경되는 경우에 변경된 약관의 내용과 시행일을 정하여, 그 시행일로부터 7일전 홈페이지에 온라인으로 공시합니다. 다만, 이용자에게 불리하게 약관 내용을 변경하는 경우에는 시행일로부터 30일전 홈페이지에 온라인으로 공시하거나 회원이 회원 가입 시 등록한 e-mail로 전송하는 방법으로 회원에게 고지합니다. 변경된 약관은 공시하거나 고지한 시행일로부터 효력이 발생합니다.
④ 회원은 변경된 약관에 대해 거부할 권리가 있습니다. 본 약관의 변경에 대해 이의가 있는 회원은 서비스 이용을 중단하고 회원 탈퇴를 할 수 있습니다. 회원이 변경된 이용약관의 시행일 이후에도 서비스를 계속 이용하는 경우에는 변경된 약관에 동의한 것으로 봅니다.
제4조(개인정보의 보호 및 사용)
① 회사는 관계법령이 정하는 바에 따라 이용자 등록정보를 포함한 이용자의 개인 정보를 보호하기 위해 노력합니다. 이용자의 개인 정보 보호 및 사용에 대해서는 관련 법령 및 회사의 개인정보처리방침이 적용됩니다. 단, 회사의 공식 사이트 이외의 링크된 사이트에서는 회사의 개인정보처리방침이 적용되지 않습니다.
② 회사는 이용자의 귀책 사유로 인해 노출된 이용자의 계정 정보를 비롯한 모든 정보에 대해서 일체의 책임을 지지 않습니다.
제5조(운영 정책)
① 회사는 약관을 적용하기 위해 필요한 사항과 회원의 권익을 보호하고 게임 세계 내 질서를 유지하기 위하여 약관에서 구체적 범위를 정하여 위임한 사항을 게임 서비스 운영 정책(이하 "운영 정책"이라고 함)으로 정할 수 있습니다.
② 회사는 운영 정책의 내용을 회원이 알 수 있도록 게임별 서비스 홈페이지(이하 "게임 홈페이지"라고 함)에 게시하거나 연결 화면을 제공하는 방법으로 회원에게 공지합니다.
③ 회원의 권리 또는 의무에 중대한 변경을 가져오거나 약관 내용을 변경하는 것과 동일한 효력이 발생하는 운영정책 개정의 경우에는 제3조 제3항의 절차에 따릅니다. 단, 운영정책 개정이 다음 각 호의 어느 하나에 해당하는 경우에는 본 조 제2항의 방법으로 사전에 공지합니다.
1. 약관에서 구체적으로 범위를 정하여 위임한 사항을 개정하는 경우
2. 회원의 권리·의무와 관련 없는 사항을 개정하는 경우
3. 운영정책의 내용이 약관에서 정한 내용과 근본적으로 다르지 않고 회원이 예측 가능한 범위 내에서 운영정책을 개정하는 경우
제6조(약관의 규정 외 사항에 관한 준칙)
이 약관에 규정 되지 않은 사항과 이 약관의 해석에 대해서는 회사가 정한 개별 서비스 이용약관, 운영정책 및 관계법령이 적용됩니다.

<제2장 서비스 이용 계약>
                                   </textarea>
                            </div>
                            <div id="c1_1_3">
                                <div id="agreeBox">
                                    <p>동의하시겠습니까?</p>
                                    <input type="checkbox" name="agree" id="agree" value="동의"><label for="agree">동의</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="c2">
                        <div id="cHeader">
                            <p>회원 가입</p>
                        </div>
                        <div id="cContent">
                            <div id="con1">
                                &nbsp;&nbsp;&nbsp;* 아이디&nbsp;&nbsp;&nbsp;&nbsp; 
                                <input type="text" name="userId" id="userId" placeholder="  4자리 이상 입력">&nbsp;&nbsp;
                                <input type="button" value="중복확인" id="idCheck">&nbsp;&nbsp;
                                <span class="idCheck ok">사용 가능합니다</span>
                                <span class="idCheck fail">이미 존재하는 아이디입니다</span>
                                <input type="hidden" id="idCheckHidden" value="0">
                            </div>
                            <div id="con2">
                                &nbsp;&nbsp;&nbsp;&nbsp;* 이름&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="text" name="userName" id="userName">
                            </div>
                            <div id="con3">
                                &nbsp;&nbsp;* 비밀번호&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="password" name="userPwd1" id="userPwd1" onkeyup="passwordCheckFunction();" placeholder="  4자리 이상 입력">
                            </div>
                            <div id="con4">
                                * 비밀번호 확인&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="password" name="userPwd2" id="userPwd2" onkeyup="passwordCheckFunction();">&nbsp;&nbsp;
                                <span id="pwdCheckResult"> </span>
                            </div>
                            <div id="con5">
                                &nbsp;&nbsp;&nbsp;* 이메일&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="text" name="email1" id="email1"> @
                                <input type="text" name="email2" id="email2">
                                <input type="hidden" name="random" id="random">
                                <select name="selectEmail" id="selectEmail">
                                    <option value="직접입력">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="nate.com">nate.com</option>
                                </select>&nbsp;
                            </div>
                            <div id="con6">
                                <input type="text" name="confirmText" id="confirmText">&nbsp;&nbsp;
                                <input type="button" value="인증번호보내기" id="emailConfirmBtn">
                                <input type="button" value="인증확인" id="emailConfirmResultBtn">
                                <input type="hidden" id="emailHidden" value="0">
                            </div>
                            <div id="con7">
                                &nbsp;&nbsp;&nbsp;* 관심사&nbsp;&nbsp;
                                <div id="con7Box">
                                    <input type="checkbox" name="interest" class="checkBox" value="문학＊책">
                                    <label for="checkbox">문학＊책</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="영화">
                                    <label for="checkbox">영화</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="미술＊디자인">
                                    <label for="checkbox">미술＊디자인</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="공연＊전시">
                                    <label for="checkbox">공연＊전시</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="외국어">
                                    <label for="checkbox">외국어</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="맛집">
                                    <label for="checkbox">맛집</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="요리＊레시피">
                                    <label for="checkbox">요리＊레시피</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="인테리어＊DIY">
                                    <label for="checkbox">인테리어＊DIY</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="음악">
                                    <label for="checkbox">음악</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="엔터테인먼트">
                                    <label for="checkbox">엔터테이먼트</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="반려동물">
                                    <label for="checkbox">반려동물</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="여행">
                                    <label for="checkbox">여행</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="육아＊결혼">
                                    <label for="checkbox">육아＊결혼</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="스포츠">
                                    <label for="checkbox">스포츠</label>
                                    <input type="checkbox" name="interest" class="checkBox" value="지역">
                                    <label for="checkbox">지역</label>
                                </div>  
                            </div>
                        </div>
                        <div id="cFooter">
                            <div>
                                <input type="submit" id="insertBtn" value="가입하기">
                                <input type="button" id="insertCancleBtn" value="취소">
                            </div>
                        </div>
                    </div>
                </form>
                <div id="copy">
                    <p>GROOBEE © 2020</p>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function(){
        	/* 약관 동의 및 입력 예외처리(알럿) */
        	$("#insertBtn").on("click",function(){
        		var chk = $("#agree");
        		if(!chk.prop("checked")) {
        			alert("약관에 동의해 주세요");
        			return false;
        		}
        		var idCheck = $("#idCheckHidden").val();
        		if(idCheck != 1) {
        			alert("아이디 중복체크를 해주세요");
        			return false
        		}
        		var userName = $("#userName").val();
        		if(userName == "" || userName == null) {
        			alert("이름을 입력해주세요");
        			return false
        		}
        		var pwd1 = $("#userPwd1").val();
        		var pwd2 = $("#userPwd2").val();
        		if(pwd1 == null || pwd1 == "" || pwd2 == null || pwd2 == "") {
        			alert("비밀번호를 입력해주세요");
        			return false
        		} else if(pwd1 != pwd2) {
        			alert("비밀번호를 동일하게 입력해주세요");
        			return false
        		}
        		var emailHidden = $("#emailHidden").val();
        		if(emailHidden != 1) {
        			alert("이메일 인증을 확인해주세요");
        			return false
        		}
        		var interest = $(".interest").val();
        		if(!$(':input:checkbox[name=interest]:checked').val()) {
        			alert("최소 1개 이상의 관심사를 선택해주세요");
        			return false
        		}
        		
        	});
        	/* 아이디 중복확인 */
        	$("#idCheck").on("click",function(){
	        	var userId = $("#userId").val();
        		$.ajax({
        			url:"idCheck.do",
        			data:{userId:userId},
        			type:"POST",
        			success:function(data){
        				if(data == "ok") {
        					$(".ok").show();
        					$(".fail").hide();
        					$("#idCheckHidden").val(1);
        				} else if(data == "fail") {
        					$(".ok").hide();
        					$(".fail").show();
        				}
        			},
        			error:function(){
        				console.log("실패");
        			}
        		});
        	});
        	/* 이메일 select값 input에 넘기기 */
        	$("#selectEmail").bind("change",function(){
        		var selectEmail = $("#selectEmail").val();
        		$("#email2").val(selectEmail);
        	})
        	/* 이메일 인증 랜덤값 가져오기 */
        	$.ajax({
        		url:"random.do",
        		type:"post",
        		dataType:"json",
        		success:function(data){
        			$("#random").val(data.random);
        		},
        		error:function(){
        			console.log("에러");
        		}
        	})
        	/* 이메일 인증 보내기 */
        	$("#emailConfirmBtn").on("click",function(){
            	var email1 = $("#email1").val();
            	var email2 = $("#email2").val();
            	var email = email1 + "@" + email2;
            	var random = $("#random").val();
            	if(email1 == null || email2 == null || email1 == "" || email2 == "") {
            		alert("이메일을 입력해주세요");
            		return false;
            	} else {
	        		$("#emailConfirmResultBtn").show();
	            	$.ajax({
	            		url:"sendEmail.do",
	            		type:"post",
	            		data:{email:email, random:random},
	            		success:function(data){
	            			if(data == false) {
	  							alert("올바른 이메일을 작성해주세요");          				
	            			} else {
		            			alert("이메일을 확인하여 인증번호를 입력해주세요");
	            			}
	            		},
	            		error:function(){
	            			console.log("에러");
	            		}
	            	});
            	}
        	});
        	/* 인증번호 확인 */
        	$("#emailConfirmResultBtn").on("click",function(){
        		var emailCode = $("#random").val();
        		var inputCode = $("#confirmText").val();
        		if(emailCode == inputCode) {
        			alert("인증되었습니다.");
        			$("#emailHidden").val(1);
        			return true;
        		} else {
        			alert("인증번호를 다시 확인해 주세요.");
        			return false;
        		}
        	});
        	/* 페이지 돌아가기 */
        	$("#insertCancleBtn").on("click",function(){
        		location.href = "loginView.do";
        	})
        });
        /* 비밀번호 같은지 체크 */
    	function passwordCheckFunction() {
        	var userPwd1 = $("#userPwd1").val();
			var userPwd2 = $("#userPwd2").val();
			if(userPwd1 != userPwd2) {
				$("#pwdCheckResult").html("비밀번호가 일치하지 않습니다.");
			} else {
				$("#pwdCheckResult").html(" ");
			}
    	}
    </script>
</body>
</html>