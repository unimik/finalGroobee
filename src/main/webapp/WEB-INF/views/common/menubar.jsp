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
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

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
                        <!-- 채팅목록 공간 -->
                        </div>
                    </div>
                    <div class="tab_box2 tab_box">
                        <div id="search_g">
                            <input type="search" id="g_list" name="g_list" placeholder="그룹 검색">
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                        </div>
                        <div id="myGroupChat_list">
                            <!-- <ul id="list">
                                <li><img src="#" alt="" id="chat_back"></li>
                                <li>그룹 이름</li>
                                <li>그룹 대화 마지막 내용</li>
                            </ul> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="chat_room" name="chat_room" class="chat_room">
            <div class="chatRoomContainer">
                <div id="chat_top">
                    <button id="goList"><img src="${ contextPath }/resources/icons/goList.png"></button>
                    <p>user02</p>
                </div>
                <div id="chatArea">
                    <div id="chating">
                        <img src="${ contextPath }/resources/images/IMG_7273.JPEG">
                        <p id="chatId">상대방 아이디</p>
                        <div id="chatBox">
                            <a id="chatText">상대 채팅 내용내용내용내용내용내용내용</a>
                        </div>
                    </div>
                    <div id="myChating">
                        <p>내꺼 내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</p>
                    </div>
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
		                   		<c:if test="${ !empty loginUser.mImage }">
		                   		</c:if>
		                   		<c:if test="${ empty loginUser.mImage }">
		                   		<img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
		                   		</c:if>
		                   		<p>${ loginUser.userId }</p>
	                   		</a>
	                   </li>
	                   <li><a href="pInsertView.do"><img src="resources/icons/write.png" alt="WRITE" id="writeIcon"></a></li>
	                   <li><img src="resources/icons/alarm.png" alt="" id="alarmIcon"></li>
	                   <li><img src="resources/icons/open.png" alt="" id="detailInfo"></li>
	               </ul>
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
                 			var $div = $("<div>");
    						var $ul = $("<ul>");
    						var $img = $("<li>");
    						var $rImg = $('<img src="#">');
    						if('<c:out value="${loginUser.userId}"/>' == value.fromId) {
	    						var $id = $("<li>").text(value.toId);
    						} else {
    							var $id = $("<li>").text(value.fromId);
    						}
    						var $cContent = $("<li>").text(value.cContent);
    						var $input = $('<input type="hidden" id="crNo">').val(value.crNo);
    						
    						
    						$img.append($rImg);
    						$ul.append($img);
    						$ul.append($id);
    						$ul.append($cContent);
    						$ul.append($input);
    						$div.append($ul);
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

         $("<ul>").on("click",function(){
             $(".chat_room").show();
         });

         $('#goList').on("click",function(){
             $(".chat_room").hide();
         });
     });
     /* 채팅 관련(sockJs) */
     $(function(){
 		$("#sendBtn").click(function() {
 			sendMessage();
 			$('#message').val('')
 		});
 	 });
     
	 var sock = new SockJS("http://localhost:8787/spring/echo");
 	 sock.onmessage = onMessage;
 	 sock.onclose = onClose;
 	 
 	 // 메시지 전송
 	 function sendMessage() {
 	 	 var toId = $("#toId").val();
 		 var sendType = $("#sendType").val();
 		 var crNo = $("#chatRoom").val();
 		 sock.send($("#message").val() +"|"+toId+"|"+sendType+"|"+crNo);
 	 }
 	 // 서버로부터 메시지를 받았을 때
 	 function onMessage(msg) {
 		 var data = msg.data;
 		 var dArr = data.split('|');
 		 if(dArr.length == 2) {
 		 	 $("#messageArea").append(dArr[0] + "<br/>");
 		 } else {
 			 $("#messageArea").append(data + "<br/>");
 		 }
 	 }
 	 // 서버와 연결을 끊었을 때
 	 function onClose(evt) {
 		 $("#messageArea").append("연결 끊김");
 	 }
     </script>
</body>
</html>