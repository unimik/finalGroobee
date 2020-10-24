<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_Edit.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myAccount.css">
    <style>
    	#edit_submitBtn{ margin-left:40px; }
    	#imgView{ width:150px; height:150px; float:left; margin:0 50px; border:1px solid #e5e5e5; border-radius:10px;} 
		#imgView img{width:150px; height:150px; border-radius:10px;}
		.change_myImg>p{ font-size:xx-large; line-height: 20pt; margin-top:50px; }
		#imgScript { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }
		#editArea{ margin-left:100px; width:640px; }
		#edit_head>h2{ margin-top:30px; }
		#edit{ width:640px; }
		#check_email p{ position:absolute; margin-right:10px; top:auto; }
		#confirmText,#emailConfirmBtn,#emailConfirmResultBtn,#emailHidden{ 
			margin-top:10px;
			position: relative;
			left:150px;
			top:auto;
			background:#daf4ed;
			border:none;
			border-radius:10px;
			height: 30px;
		}
		#checkbox_interest{
			margin-top:10px;
			position: relative;
			left:150px;
			top:auto;
			background:#daf4ed;
			border:none;
			border-radius:10px;
			font-size:small;
			width:350px;
			padding:5px;
		}
    </style>
</head>
<body>
	 <c:import url="common/menubar.jsp"/>
	 
	         <!-- 피드 부분 -->
<div id="feedArea">
    <div id="feed">  
    <!-- 프로필 편집 부분 -->
    	<form action="mupdate.do" method="post" id="updateForm" enctype="multipart/form-data">
	        <div id="editArea">
	            <div id="edit">
	                <div id="edit_head">
	                    <h2>프로필 편집</h2>
	                </div>
	                
	                <div id="edit_body">
	                    <div id="myProfileImg" style="padding: 40px 0; display:block;">
	                    	<div id="imgView" class="filebox"></div>
	                        <div class="change_myImg">
	                            <p>${ loginUser.userId }</p>
	                            <label for="imgScript">프로필 사진 바꾸기
	                            	<input type="file" id="imgScript" name="file" accept="image/*" onchange="sethumbnail(event);">
	                        	</label>
	                        </div>
	                    </div>
	                    <div id="info_edit">
	                        <div class="info_name">
	                            <p>이름</p>
	                            <input type="text" id="name" name="name" value="${ loginUser.userName}">
	                        </div>
	                        <div class="info_selfIntro">
	                            <p>소개</p>
	                            <textarea id="selfIntro" cols="35" rows="6"></textarea>
	                        </div>
		                    <div class="info_email">
	                            <p>이메일</p>
	                             <c:forTokens var="em" items="${ loginUser.email }" delims="@" varStatus="status">
                  					<c:if test="${ status.index eq 0 }">
                  						<input type="text" id="email1" name="email1" value="${ em }">
	                            	<span>@</span>
                  					</c:if>
	                            	<c:if test="${ status.index eq 1 }">
	                            		 <input type="text" id="email2" name="email2" value="${ em }">
										<input type="hidden" name="random" id="random">
		                                <select name="select_email" id="select_email">
		                                    <option value="직접입력">직접입력</option>
		                                    <option value="naver.com">naver.com</option>
		                                    <option value="daum.net">daum.net</option>
		                                    <option value="gmail.com">gmail.com</option>
		                                    <option value="nate.com">nate.com</option>
		                                </select>
	                            	</c:if>
                                </c:forTokens>
	                        </div>
	                        <div id="check_email">
	                        	<p></p>
                                <input type="text" name="confirmText" id="confirmText">
                                <input type="button" value="인증번호보내기" id="emailConfirmBtn">
                                <input type="button" value="인증확인" id="emailConfirmResultBtn">
                                <input type="hidden" id="emailHidden" value="0">
                            </div>
                            <div id="interests_box">
		                        <p>관심사</p>
		                        <div id="checkbox_interest">	                        
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
	                                <input type="checkbox" name="interest" class="checkBox" value="음악">
	                                <label for="checkbox">음악</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="여행">
	                                <label for="checkbox">여행</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="반려동물">
	                                <label for="checkbox">반려동물</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="엔터테인먼트">
	                                <label for="checkbox">엔터테이먼트</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="육아＊결혼">
	                                <label for="checkbox">육아＊결혼</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="지역">
	                                <label for="checkbox">지역</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="스포츠">
	                                <label for="checkbox">스포츠</label>
	                                <input type="checkbox" name="interest" class="checkBox" value="인테리어＊DIY">
	                                <label for="checkbox">인테리어＊DIY</label>
		                        </div>

                            </div>
	                        
	                    </div>
<!-- 	                        <div class="info_email">
	                            <p>이메일</p>
	                            <input type="text" id="email1" name="email1">@
	                            <input type="text" id="email2" name="email2">
								<input type="hidden" name="random" id="random">
                                <select name="selectEmail" id="selectEmail">
                                    <option value="직접입력">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="nate.com">nate.com</option>
                                </select>
	                        </div>
	                        <div id="check_email">
	                        	<p></p>
                                <input type="text" name="confirmText" id="confirmText">&nbsp;&nbsp;
                                <input type="button" value="인증번호보내기" id="emailConfirmBtn">
                                <input type="button" value="인증확인" id="emailConfirmResultBtn">
                                <input type="hidden" id="emailHidden" value="0">
                            </div>
	                        
                            <div id="info_interests">
                                <p>관심사</p>
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
                            </div> -->
	                </div>
	            <!-- 버튼 만들기 -->
	                <div id="edit_body2">
	                    <div id="editBtnArea">
	                        <input type="submit" id="edit_submitBtn" class="completeBtn" value="변경하기">
	                        <input type="button" id="edit_cancleBtn" class="completeBtn" value="취소" onclick="goBack()">
	                    </div>
	                </div>
	            </div>
	        </div>
        </form>
     </div>
</div>
	    <script>
	    $(function(){
		    $("input[name=interests]:checked").each(function() { var test = $(this).val(); });	    	
	    });
	    	
	    $(function(){
	    	var filterArr = '${ loginUser.interestes }'.split(', ');
			$('input:checkbox').each(function(){
				if($.inArray($(this).val(),filterArr) > -1)
					$(this).prop('checked', true);
			});	    	
	    });
	    
	    function sethumbnail(event){
		    var reader = new FileReader();
			
			reader.onload = function(event){
				var img = document.createElement('img');
				img.setAttribute("src",event.target.result);
				document.querySelector("div#imgView>img").remove();
				document.querySelector("div#imgView").appendChild(img);
			};
			
			reader.readAsDataURL(event.target.files[0]);
		};
	    
/* 		    function sethumbnail(event){
				var reader = new FileReader();
				var x = document.getElementById("imgScript");
		    	var txt = "";
				
				reader.onload = function(event){
					var img = document.createElement('img');
					img.setAttribute("src",event.target.result);
					document.querySelector("div#imgView").appendChild(img);
					
				};
				reader.readAsDataURL(event.target.files[0]);
			}; */
	    
	        $(document).ready(function(){
	            $('#chat_icon').click(function(){
	                var state = $(".chat").css('display');
	                if(state=='none'){
	                    $('.chat').show();
	                }else{
	                    $('.chat').hide();
	                }
	            });
	        });
	
	       $('.tab_menu_btn').on('click',function(){
	            $('.tab_menu_btn').removeClass('on');
	            $(this).addClass('on')
	        });
	
	        $('.tab_menu_btn1').on('click',function(){
	            $('.tab_box').hide();
	            $('.tab_box1').show();
	        });
	
	        $('.tab_menu_btn2').on('click',function(){
	            $('.tab_box').hide();
	            $('.tab_box2').show();
	        });
	
	        $(document).ready(function(){
	            $('#detailInfo').click(function(){
	                $(".myAccount").animate({width:"toggle"},250);
	            });
	        });
	
	        $('.MyTab_tab').on("click",function(){
	            $('.MyTab_tab').removeClass('on');
	            $(this).addClass('on')
	        });
	
	        $('.MyTab_tab1').on('click', function(){
	            $('.MyTab_box').hide();
	            $('.MyTab_box1').show();
	        });
	
	        $('.MyTab_tab2').on('click', function(){
	            $('.MyTab_box').hide();
	            $('.MyTab_box2').show();
	        });
	
	        /* 게시글, 보관함, 내 그룹 전환 시 스크립트 */
	        $('.feedPost_btn').click(function() {
	            $(this).css({'border-bottom' : '2px solid #47c6a3'});
	            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
	            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
	        });
	
	        $('.feedStorageBox_btn').click(function() {
	            $(this).css({'border-bottom' : '2px solid #47c6a3'});
	            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
	            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
	        });
	
	        $('.feedMyGroup_btn').click(function() {
	            $(this).css({'border-bottom' : '2px solid #47c6a3'});
	            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
	            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
	        });
	
	        $('div[type = button]').css({'cursor' : 'pointer'});
	        $('input[type = button]').css({'cursor' : 'pointer'});
	        $('input[type = submit]').css({'cursor' : 'pointer'});
	        $('img[type = button]').css({'cursor' : 'pointer'});
	
	        function goBack() {
	            window.history.back();
	        }
        	/* 이메일 select값 input에 넘기기 */
        	$("#select_email").bind("change",function(){
        		var selectEmail = $("#select_email").val();
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
        	

	
	    </script>
</body>
</html>