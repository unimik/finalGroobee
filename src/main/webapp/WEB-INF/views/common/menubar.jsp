<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kh.spring.member.model.vo.Member"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/alarmPop.css">
<link rel="stylesheet" href="resources/css/user_alarmPop.css">
<link rel="stylesheet" href="resources/css/myAccount.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<script>
	
</script>

<style>
	a{text-decoration:none;}
</style>
</head>
<body>
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	 <div id="header">
            <img src="resources/icons/logo.png" alt="logo" id="logo" name="logo">
     </div>
     <div class="content">
     	<div id="chat" name="chat" class="chat">
            <div class="tab_menu">
                <button class="tab_menu_btn1 tab_menu_btn on">내 채팅</button>
                <button class="tab_menu_btn2 tab_menu_btn">그룹</button>
                <div class="tab_box_container">
                    <div class="tab_box1 tab_box on">
                        <div id="search_f">
                            <input type="search" id="f_list" name="f_list" placeholder="친구 검색">
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                        </div>
                        <div id="mcList">
                            <!-- 채팅목록 공간 냅둬주세요 -->
                        </div>
                    </div>
                    <div class="tab_box2 tab_box">
                        <div id="search_g">
                            <input type="search" id="g_list" name="g_list" placeholder="그룹 검색">
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                        </div>
                        <div id="myGroupChat_list">
                           <!--  <ul id="list">
                                <li><img src="#" alt="" id="chat_back"></li>
                                <li>그룹 이름</li>
                                <li>그룹 대화 마지막 내용</li>
                            </ul> 여기 냅둬주세여 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="chat_room" name="chat_room" class="chat_room">
            <div class="chatRoomContainer">
                <div id="chat_top">
                    <button id="goList"><img src="${ contextPath }/resources/icons/goList.png"></button>
                    <p id="chatUser"></p>
                </div>
                <div id="chatArea">
                   	<!-- 채팅방 안 여기도 -->
                </div>
                <div id="input_chat">
                    <input type="text" id="inputArea" name="inputArea">
                    <input type="submit" id="send" name="send" value="보내기"> 
                </div>
            </div>
        </div>
	     <div class="search_userInfo">
	           <div id="searchbar">
	           	   <form action="search.do" method="post">
		               <input type="search" id="allSearch" name="allSearch">
		               <input type="submit" id="allSearchBtn" name="allSearchBtn" value="검색">
	           	</form>
	    	 </div>
	           <div id="userInfo">
	               <ul>
	                   <li id="goMypage">
	                   		<a href="goMypage.do?mNo=${ loginUser.mNo }">
		                   		<c:if test="${ !empty loginUser.mRenameImage }">
		                   		<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
		                   		</c:if>
		                   		<c:if test="${ empty loginUser.mRenameImage }">
		                   		<img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
		                   		</c:if>
		                   		<p>${ loginUser.userId }</p>
	                   		</a>
	                   </li>
	                   <li><a href="pInsertView.do"><img src="resources/icons/write.png" alt="WRITE" id="writeIcon"></a></li>
	                   <li><img src="resources/icons/alarm.png" alt="" id="alarmIcon" style="cursor:pointer;"></li>
	                   <li><img src="resources/icons/open.png" alt="" id="detailInfo"></li>
	               </ul>
	           </div>
	           <div class="user_alarm" style="display:none; cursor:pointer;">
                    <div id="alarmList">
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>                        
                    </div>
                </div>
	     </div>
	     
	     
	     
	     
	     
	     <div class="myAccount">
				<div id="myId">
					<c:if test="${ !empty loginUser.mRenameImage }">
						<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="myProfile" id="myProfile">
					</c:if>
					<c:if test="${ empty loginUser.mRenameImage }">
						<img src="<%=request.getContextPath()%>/resources/icons/pro_default.png" alt="myProfile" id="myProfile">
					</c:if>
					<p>${ loginUser.userId }</p>
				</div>
				<div id="MyTab">
					<button class="MyTab_tab1 MyTab_tab on">팔로워</button>
					<button class="MyTab_tab2 MyTab_tab">팔로잉</button>
					<button class="MyTab_tab3 MyTab_tab">그룹</button>
					<div id="MyTab_container">
						<!-- 팔로워 -->
						<div class="MyTab_box1 MyTab_box on">
							<div id="My_follower_list">
								<ul id="follower_info">
									<li><img src="../resources/images/IMG_7273.JPEG" alt=""
										id="follower_list_img"></li>
									<li>user02</li>
									<li><button id="follower" name="follower">삭제</button></li>
								</ul>
							</div>
						</div>
						<!-- 팔로잉 -->
						<div class="MyTab_box2 MyTab_box">
							<div id="My_following_list">
								<ul id="following_info">
									<li><img src="../resources/images/IMG_7273.JPEG" alt=""
										id="following_list_img"></li>
									<li>user02</li>
									<li><button id="following" name="following">팔로잉</button></li>
								</ul>
							</div>
						</div>
						<!-- 그룹 -->
						<div class="MyTab_box3 MyTab_box">
							<div id="My_fgroup_list">
								<ul id="fgroup_info">
									<li><img src="../resources/images/IMG_7273.JPEG" alt=""
										id="fgroup_list_img"></li>
									<li>user02</li>
									<li><button id="del_group" name="del_group">탈퇴</button></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
	     
	     <div id="menubar">
	     	 <c:url var="goHome" value="home.do"/>
	     	 <c:url var="glist" value="glist.do"/>
	         <ul id="menu">
	             <li><a href="${ goHome }"><img src="resources/icons/menu_home.png" alt="HOME"></a></li>
	             <li><img src="resources/icons/menu_chat.png" alt="CHAT" id="chat_icon" name="chat_icon"></li>
	
	             <li><a href="${ glist }"><img src="resources/icons/logoicon.png"></a></li>
	             <li><a href="goSetting.do" ><img src="resources/icons/menu_set.png" alt="SET"></a></li>
	         </ul>
	     </div>
     <script type="text/javascript">
     /* 채팅방 채팅내용 불러오기 */
     $(document).on("click",".chRoom",function(){
    	 
    	 $("#inputArea").keydown(function(key){
    		if(key.keyCode == 13) {
   	 			sendMessage();
    		} 
    	 });
    	 
		var crNo = $(this).children("input").val();
		$.ajax({
			url:"oneChatContentList.do",
			data:{crNo:crNo},
         	type:"post",
    		dataType:"json",
    		success:function(data){
    			console.log("ok");
    			var userId = '<c:out value="${loginUser.userId}"/>';
    			$("#chatArea").children().remove();
    			$.each(data,function(index,value){
	    			if(value.fromId == userId) {
	    				$div1 = $("<div class='myChating'>");
	    				$div = $("<div>");
	    				$p = $("<p id='myChatt'>").text(value.cContent);
	    				
	    				$div.append($p);
	    				$div1.append($div);
	    				
	    				$("#chatArea").append($div1);
	    			} else {
	    				$div3 = $("<div class='chating'>");
	    				$inputId = $("<input type='hidden' class='1'>").val(value.fromId);
	    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
	    				$div = $("<div>");
	        			$img = $('<img src="resources/'+value.chatImage+'">');
	        			$p = $("<p id='chatId'>").text(value.fromId);
	        			$div1 = $("<div>");
	        			$a = $("<a id='chatText'>").text(value.cContent);
	        			$userName = $("#chatUser").text(value.fromId);
	        			
	        			$div.append($img);
	        			$div.append($p);
	        			$div1.append($a);
	        			$div.append($div1);
	        			$div3.append($div);
	        			
	        			$("#chatArea").append($div3);
	        			$("#chatArea").append($inputId);
	        			$("#chatArea").append($inputType);
	        			$("#chatArea").append($inputCrNo);
	        			$("#chatArea").append($inputChatImage);
	    			}
    			});
    			$(".chat_room").show();
    			$("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
    		},
    		error:function(){
    			console.log('에러');
    		}
		});
		var msg = $("#inputArea").val();
	 });

     /* 채팅 창 여는 스크립트 */	
     $(function(){
    	 $('#chat_icon').on("click",function(){
             var state = $(".chat").css('display');
             if(state =='none'){
            	 $.ajax({
                 	url:"oneChatList.do",
                 	data:{userId:'<c:out value="${loginUser.userId}"/>'},
                 	type:"post",
            		dataType:"json",
                 	success:function(data){
                 		$("#mcList").children().remove();
                 		$.each(data,function(index,value){
                 			console.log(value.chatImage);
                 			var $div = $('<div class="chRoom">');
    						var $ul = $('<ul>');
    						var $img = $("<li>");
    						var $rImg = $('<img src="resources/'+value.chatImage+'">');
    						var $inputt = $('<input type="hidden" class="crNo">').val(value.crNo);
    						if('<c:out value="${loginUser.userId}"/>' == value.fromId) {
	    						var $id = $("<li>").text(value.toId);
    						} else {
    							var $id = $("<li>").text(value.fromId);
    						}
    						var $cContent = $("<li>").text(value.cContent);
    						
    						$img.append($rImg);
    						$ul.append($img);
    						$ul.append($id);
    						$ul.append($cContent);
    						$div.append($ul);
    						$div.append($inputt);
    						$("#mcList").append($div);
    					});
                 		$('.chat').show();
                 	},
                 	error:function(){
                 		console.log("에러");
                 	}
                  });
             }else{
                 $('.chat').hide();
             }
         });
    	 
    	 /* 채팅방 만들기 */
    	 $("#myFeed_message_btn").on("click",function(){
    		var nId1 = '${loginUser.userId}';
    		var nId2 = '${param.userId}';
    		console.log(nId1+":"+nId2);
    		$.ajax({
    			url:'insertChatRoom.do',
    			data:{myId:nId1,otherId:nId2},
    			success:function(data){
    				console.log("ok");
    				$('.myFeed_popup_others').hide();
    				
    				$div3 = $("<div class='chating'>");
    				$inputId = $("<input type='hidden' class='1'>").val(data.toId);
    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
    				$inputCrNo = $("<input type='hidden' class='3'>").val(data.crNo);
    				console.log(data.toId +":" + data.crNo);
    				$("#chatArea").append($div3);
        			$("#chatArea").append($inputId);
        			$("#chatArea").append($inputType);
        			$("#chatArea").append($inputCrNo);
        			
        			$("#inputArea").keydown(function(key){
        	    		if(key.keyCode == 13) {
        	   	 			sendMessage();
        	   	 			$('#inputArea').val('');
        	    		} 
        	    	 });
    				
    				$(".chat_room").show();
    			},
    			error:function(){
    				console.log("에러");
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

         $("#list").on("click",function(){
             $(".chat_room").show();
         });

         $('#goList').on("click",function(){
             $(".chat_room").hide();
         });
     });
     
     /**************알림창 열기 ****************/
     $('#alarmIcon').on("click",function(){
       
    	 $.ajax({
    		 url: "getNotification.do",
    		 datatype:'json',
    		 success: function(data){
    			 console.log(data);
    			  var i =0;
    			  while(data[i] != null){
    				  console.log(data[i]);
    				  i++;
    				 /*  $('#alarmList').append('<p>'+ data[i].alramContent+'추가 확인.</p><br>'); */
    				  
    				  $('#alarmList').append('<div id="list">'+
                      data[i].alramContent+'</div>');
    				  
    			  }
    		 },error: function(error){
    			 alert('에러');
    		 }
    	 })
    	 
    	 
    	 $('.user_alarm').slideToggle();
                    
       });
     
     /* 채팅 관련(sockJs) */
     $(function(){
 		$("#send").on("click",function(){
 			sendMessage();
 		});
 	 });
     
	 var sock = new SockJS("http://localhost:8787/spring/echo");
 	 sock.onmessage = onMessage;
 	 sock.onclose = onClose;
 	 
 	 // 메시지 전송
 	 function sendMessage() {
 	 	 var toId = $("#chatArea").children(".1").val();
 		 var sendType = $("#chatArea").children(".2").val();
 		 var crNo = $("#chatArea").children(".3").val();
 		 console.log(toId+","+sendType+","+crNo);
 		 sock.send($("#inputArea").val() +"|"+toId+"|"+sendType+"|"+crNo);
 		 $('#inputArea').val('');
 	 }
 	 // 서버로부터 메시지를 받았을 때
 	 function onMessage(msg) {
 		 var data = msg.data;
 		 var dArr = data.split('|');
 		 if(dArr.length == 2) {
 			if(dArr[0] == null || dArr[0] == ' ') {
 				
 			} else {
 				$div1 = $("<div class='myChating'>");
 				$div = $("<div>");
 				$p = $("<p id='myChatt'>").text(dArr[0]);
 				
 				$div.append($p);
 				$div1.append($div);
 				
 				$("#chatArea").append($div1);
 			}
 			
 		 } else {
			if(data == null || data == ' ') {
 				
 			} else {
 				var toId = $("#chatArea").children(".1").val();
 	 			var inputChatImage = $("#chatArea").children(".4").val();
 	 			$div3 = $("<div class='chating'>");
 				$div = $("<div>");
 				$img = $('<img src="resources/'+inputChatImage+'">');
 				$p = $("<p id='chatId'>").text(toId);
 				$div1 = $("<div>");
 				$a = $("<a id='chatText'>").text(data);
 				$userName = $("#chatUser").text(toId);
 				
 				$div.append($img);
 				$div.append($p);
 				$div1.append($a);
 				$div.append($div1);
 				$div3.append($div);
 				
 				$("#chatArea").append($div3);
 			}
 		 }
 		 $("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
 	 }
 	 // 서버와 연결을 끊었을 때
 	 function onClose(evt) {
 		 $("#chatArea").append("연결 끊김");
 	 }
 	 
 	 
 	 
 	/************* 내계정 자세히보기 script **************/

     $(document).ready(function(){
         $('#detailInfo').click(function(){
        	 var mNo = ${ loginUser.mNo };
        	 var mId = ${ loginUser.userId };
        	 $.ajax({
        		url:"getList.do",
        		data:{mNo:mNo, gmId:mId},
        		
        	 });
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
     
     $('.MyTab_tab3').on('click', function(){
         $('.MyTab_box').hide();
         $('.MyTab_box3').show();
     });

     $('#goMypage').click(function(){
         location.href="../views/myPage_Main.html";
     });

     </script>
</body>
</html>