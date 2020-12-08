<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="<%=path%>/resources/css/common.css">
    <link rel="stylesheet" href="<%=path%>/resources/css/memberFind.css">
    <link rel="stylesheet" href="<%=path%>/resources/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=path%>/resources/js/bootstrap.min.js"></script>
    <title>G R O O B E E</title>
</head>
<body>
    <div class="wapper">
        <img src="<%=path%>/resources/icons/logo.png" alt="index_logo" id="index_logo" name="index_logo">
        <div id="content">
            <div id="inContent">
                <form action="#" method="post">
                    <div id="c1">
                        <div id="c1_1">
                            <div id="c1Title"><p>아이디 찾기</p></div>
                            <div id="c1Content1">
                                <p>
                                아이디가 기억나지 않으세요?<br>
                                등록된 회원정보로 아이디를 찾으실 수 있습니다.
                                이메일 인증 후 아래의 버튼을 눌러주세요
                                </p>
                            </div>
                            <div id="c1Name">
                                * 이름
                                <input type="text" name="userName" id="userName">
                            </div>
                            <div id="c1Email">
                                * 이메일
                                <input type="text" name="email1" id="email1">
                                @
                                <input type="text" name="email2" id="email2">
                                <select name="selectEmail" id="selectEmail">
                                    <option value="직접입력">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="nate.com">nate.com</option>
                                </select>
                            </div>
                            <div><button id="userIdFindBtn">아이디 찾기</button></div>
                        </div>
                    </div>
                </form>
                <form action="#" method="post">
                    <div id="c2">
                        <div id="c2_1">
                            <div id="c2Title"><p>비밀번호 찾기</p></div>
                            <div id="c2Content1">
                                <p>
                                비밀번호가 기억나지 않으세요?<br>
                                등록된 아이디 확인 후 <b>임시비밀번호</b>를 이메일로 발송해드립니다.
                                </p>
                            </div>
                            <div id="c2Id">
                                * 아이디
                                <input type="text" name="userId" id="userId">
                            </div>
                            <div id="c2Email">
                                * 이메일
                                <input type="text" name="email11" id="email11">
                                @
                                <input type="text" name="email22" id="email22">
                                <select name="selectEmail2" id="selectEmail2">
                                    <option value="직접입력">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="nate.com">nate.com</option>
                                </select>
                            </div>
                            <input type="hidden" name="random" id="random">
                            <div><button id="userPwdFindBtn">비밀번호 찾기</button></div>
                            <a href="loginView.do" id="goBack"><p>돌아가기</p></a>
                        </div>
                    </div>
                </form>
                <!-- 모달 팝업 -->
                <!-- 아이디 찾기 -->
                <div class="modal fade" id="idFindModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">아이디 찾기 완료</h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">x</span>
                                </button>
                            </div>
                            <div class="modal-body" id="findIdResult"></div>
                            <div class="modal-footer">
                                <button class="btn" type="button" data-dismiss="modal">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 비밀번호 찾기 -->
                <div class="modal fade" id="pwdFindModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">비밀번호 찾기 완료</h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">x</span>
                                </button>
                            </div>
                            <div class="modal-body" id="findPwdResult"></div>
                            <div class="modal-footer">
                                <button class="btn" type="button" data-dismiss="modal">확인</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script>
    	/* 아이디 찾기  */
		$('#userIdFindBtn').click(function(e){
            e.preventDefault();
			var userName = $("#userName").val();
			var email = $("#email1").val() + "@" + $("#email2").val();
			console.log(email);
            $.ajax({
            	url:"findId.do",
            	data:{userName:userName,email:email},
            	dataType:"json",
            	success:function(data){
            		if(data.userId == "no") {
            			$("#findIdResult").html("존재하지 않는 회원정보입니다.");
            		} else {
	            		$("#findIdResult").html("회원님의 아이디는 <b>" + data.userId + "</b> 입니다.");
            		}
					$('#idFindModal').modal("show");
					console.log("gd");
            	},
            	error:function(){
            		console.log("에러");
            	}
            });
        });
    	/* 비밀번호 찾기 */
        $(function(){
        	/* 페이지 로딩시 난수 가져오기 */
			$.ajax({
        		url:"random.do",
        		type:"post",
        		dataType:"json",
        		success:function(data){
        			$("#random").val(data.random);
        			console.log($("#random").val());
        		},
        		error:function(){
        			console.log("에러");
        		}
        	});
			/* 이메일 보내기 */
        	$("#userPwdFindBtn").on("click",function(e){
        		e.preventDefault();
            	var email11 = $("#email11").val();
            	var email22 = $("#email22").val();
            	var email = email11 + "@" + email22;
            	var random = $("#random").val();
            	var userId = $("#userId").val();
            	console.log(email);
            	$.ajax({
            		url:"sendEmailPwd.do",
            		type:"post",
            		data:{email:email, random:random, userId:userId},
            		success:function(data){
            			if(data == false) {
            				$("#findPwdResult").html("존재하지 않는 회원정보입니다.");
            			} else {
            				$("#findPwdResult").html(email + " 으로 임시비밀번호를 전송하였습니다.");
            			}
            			$('#pwdFindModal').modal("show");
            		},
            		error:function(){
            			console.log("에러");
            		}
            	});
        	});
        });
        
        
		$(function(){
			/* 이메일 select값 input에 넘기기 */
        	$("#selectEmail").bind("change",function(){
        		var selectEmail = $("#selectEmail").val();
        		$("#email2").val(selectEmail);
        	});
			/* 이메일 select값 input에 넘기기 */
        	$("#selectEmail2").bind("change",function(){
        		var selectEmail2 = $("#selectEmail2").val();
        		$("#email22").val(selectEmail2);
        	});
		});
		
	</script>
</body>
</html>