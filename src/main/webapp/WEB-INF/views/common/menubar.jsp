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
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/Alarm.js"></script>

<style>
   a{text-decoration:none;}
</style>
</head>
<body>
   <c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
    <div id="header">
            <img src="resources/icons/logo.png" alt="logo" id="logo" name="logo">
     </div>
     <!-- 채팅 사람 추가 모달 -->
     <div class="modal fade" id="plusGroupUser" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">그룹원 추가하기</h5>
                      <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">x</span>
                      </button>
                  </div>
                  <div class="modal-body" id="findIdResult">
                  <!-- 추가할 멤버 -->                        
                  </div>
                  <div class="modal-footer">
                      <button class="btn" id="plusGroupChatBtn" type="button" data-dismiss="modal">추가</button>
                  </div>
              </div>
          </div>
      </div>
      <!-- 채팅 모달 -->
      <div class="chat_menu">
          <div id="chat_menu_list">
              <ul>
                  <li><a id="chat_delete" onclick="chatDelete();">채팅방 나가기</a></li> 
                  <li><a class="close">취소</a></li>
              </ul>
          </div>
      </div>
      <!-- 그룹채팅 모달 -->
      <div class="group_chat_menu">
          <div id="group_chat_menu_list">
              <ul>
                  <li><a class="plusChatUser">사람 추가하기</a></li> 
                  <li><a id="group_chat_delete" onclick="groupChatDelete();">채팅방 나가기</a></li> 
                  <li><a class="close">취소</a></li>
              </ul>
          </div>
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
                            <!-- 채팅목록 공간 냅둬주세요 -->
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
             
                     <input type="search" id="allSearch" name="allSearch">
                     <input type="button" id="allSearchBtn" name="allSearchBtn" value="검색" onclick="search()"/>
             
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
                      <li><a><img src="resources/icons/open.png" alt="" id="detailInfo"></a></li>
                  </ul>
              </div>
              <div class="user_alarm" style="display:none; cursor:pointer;">
                    <div id="alarmList">
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
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
							
							</div>
						</div>
						<!-- 팔로잉 -->
						<div class="MyTab_box2 MyTab_box">
							<div id="My_following_list">
							
							</div>
						</div>
						<!-- 그룹 -->
						<div class="MyTab_box3 MyTab_box">
							<div id="My_fgroup_list">
								
							</div>
						</div>
					</div>
				</div>
			</div>
	     
	     <div id="menubar">
	     	 <c:url var="goHome" value="home.do"/>
	     	 <c:url var="glist" value="glist.do"/>
	         <ul id="menu">
	             <li><a href="${ goHome }?userId=${ loginUser.userId }"><img src="resources/icons/menu_home.png" alt="HOME"></a></li>
             	 <li><img src="resources/icons/menu_chat.png" alt="CHAT" id="chat_icon" name="chat_icon"></li>
             	 
	             <li><a href="${ glist }"><img src="resources/icons/logoicon.png"></a></li>
	             <li><a href="goSetting.do" ><img src="resources/icons/menu_set.png" alt="SET"></a></li>
	         </ul>
	     </div>
	     <audio src="resources/sounds/카톡.mp3" id="messageSound"></audio>
     <script type="text/javascript">
     /* 채팅 알림 */
     function messageSound() {
    	 var a = new Audio("resources/sounds/카톡.mp3");
    	 a.play();
     }
     /* 채팅방 나가기 */
     function chatDelete() {
    	 var crNo = $("#chatArea").children(".3").val();
    	 $.ajax({
    		 url:"deleteOneChat.do",
    		 data:{crNo:crNo},
    		 success:function(data){
   				 console.log(data);
    			 if(data == "ok") {
    				 alert("채팅방 나가기에 성공했수다");
    				 $(".chat_room").hide();
    				 openChat();
    				 $(".chat").show();
    				 $(".chat_menu").hide();
    			 } else {
    				 console.log("??");
    			 }
    		 },
    		 error:function(){
    			 console.log("에러");
    		 }
    	 });
     }
     /* 그룹 채팅방 나가기*/
     function groupChatDelete() {
    	 var gNo = $("#chatArea").children(".1").val();
    	 var userId = '${loginUser.userId}';
    	 $.ajax({
    		url:"deleteGroupChat.do",
    		data:{gNo:gNo,fromId:userId},
    		success:function(data) {
    			if(data == "ok") {
    			 alert("채팅방 나가기에 성공했수다");
				 $(".chat_room").hide();
				 openGruopChat();
				 $(".chat").show();
				 $(".group_chat_menu").hide();
    			} else {
    				console.log(data);
    			}
    		},
    		error:function() {
    			console.log("에러");
    		}
    	 });
     }
     /* 그룹 채팅방 사람 추가하기 */
     $(document).on("click",".plusChatUser",function(){
    	$(".group_chat_menu").hide();
        $('#plusGroupUser').modal("show");
        var gNo = $(".1").val();
        var myId = '<c:out value="${loginUser.userId}"/>';
        console.log(gNo+":"+myId);
        $.ajax({
         url:"findGroupMember.do",
         data:{gNo:gNo},
         dataType:"json",
         success:function(data){
            console.log("굳");
            $("#findIdResult").children().remove();
            $.each(data,function(index,value){
               if(myId == value.gmId) {
               } else {
                      $div = $("<div>");
                      $ul = $("<ul>");
                      $li1 = $("<li>");
                      $li2 = $("<li>");
                      $li3 = $("<li>")
                      $radio = $("<input type='radio' name='plusGroupChatMember' value='"+value.gmId+"' id='m"+index+"'/>");
                      $img = $("<img src='resources/"+value.gmImage+"'/>");
                      $label = $("<label for='m"+index+"'/>").text(value.gmId);;
                      
                      $li1.append($radio);
                      $li2.append($img);
                      $li3.append($label);
                      $ul.append($li1);
                      $ul.append($li2);
                      $ul.append($li3);
                      $div.append($ul);
               }
                $("#findIdResult").append($div);       
            });
         },
         error:function(){
            console.log("에러");
         }
        });
        $("#plusGroupChatBtn").on("click",function(){
           var plusId = $('input[name="plusGroupChatMember"]:checked').val();
           var gNo = $("#chatArea").children(".1").val();
           var crNo = $("#chatArea").children(".3").val();
           console.log(plusId+":"+gNo+":"+crNo);
           $.ajax({
             url:"plusGroupChatMember.do",
             data:{plusId:plusId,gNo:gNo,crNo:crNo},
             success:function(data){
                console.log(data);
                if(data == "ok") {
                   sock.send(plusId+"!@#$" +"|"+gNo+"|"+"groupChatting"+"|"+crNo);
                } else {
                   
                }
             },
             error:function(){
                console.log("에러");
             }
           });
       });
     });
     
     /* 채팅 읽음 처리  */
     function countChatRead() {
       var myId = '<c:out value="${loginUser.userId}"/>';
       $.ajax({
          url:"countChat.do",
          data:{myId:myId},
          dataType:"json",
          success:function(data){
             $("#menu li:nth-child(2)").children().remove();
             if(data.countChat > 0) {
                var $img = '<img src="resources/icons/menu_chat_new.png" alt="CHAT" id="chat_icon" name="chat_icon">';
             } else {
                var $img = '<img src="resources/icons/menu_chat.png" alt="CHAT" id="chat_icon" name="chat_icon">';
             }
             $("#menu li:nth-child(2)").append($img);
          },
          error:function(){
             console.log("에러");
          }
       });
     }
     /* 채팅 창 여는 스크립트 */   
     function openChat() {
        	 $.ajax({
             	url:"oneChatList.do",
             	data:{userId:'<c:out value="${loginUser.userId}"/>'},
             	type:"post",
        		dataType:"json",
             	success:function(data){
             		$("#mcList").children().remove();
             		$.each(data,function(index,value){
             			var $div = $('<div class="chRoom">');
						var $ul = $('<ul>');
						var $img = $("<li>");
						var $rImg = $('<img src="resources/'+value.chatImage+'">');
						var $inputt = $('<input type="hidden" class="crNo" data-tt="kk">').val(value.crNo);
						if(value.read == 'N') {
							if('<c:out value="${loginUser.userId}"/>' == value.fromId) {
								var $nImg = $('<img class="chat_read" src="resources/icons/chat_new.png" style="width: 10px; height:10px;">');
	    						var $id = $("<li>").text(value.toId+"  ");
	    						$id.append($nImg);
	    						var $inputId = $('<input type="hidden" class="readId">').val(value.toId);
    						} else {
    							var $nImg = $('<img class="chat_read" src="resources/icons/chat_new.png" style="width: 10px; height:10px;">');
    							var $id = $("<li>").text(value.fromId);
    							$id.append($nImg);
    							var $inputId = $('<input type="hidden" class="readId">').val(value.fromId);
    						}
						} else {
							if('<c:out value="${loginUser.userId}"/>' == value.fromId) {
	    						var $id = $("<li>").text(value.toId);
	    						var $inputId = $('<input type="hidden" class="readId">').val(value.toId);
    						} else {
    							var $id = $("<li>").text(value.fromId);
    							var $inputId = $('<input type="hidden" class="readId">').val(value.fromId);
    						}
						}
						var $cContent = $("<li>").text(value.cContent);
						
						$img.append($rImg);
						$ul.append($img);
						$ul.append($id);
						$ul.append($cContent);
						$div.append($ul);
						$div.append($inputt);
						$div.append($inputId);
						$("#mcList").append($div);
					});
             	},
             	error:function(){
             		console.log("에러");
             	}
           	});
     }
     /* 그룹 채팅창 여는 스크립트 */
     function openGruopChat(){
        $.ajax({
             url:"GroupChatList.do",
             data:{userId:'<c:out value="${loginUser.userId}"/>'},
             type:"post",
           dataType:"json",
             success:function(data){
                $("#myGroupChat_list").children().remove();
                $.each(data,function(index,value){
                   var $div = $('<div class="chRoom2">');
               var $ul = $('<ul>');
               var $img = $("<li>");
               var $rImg = $('<img src="resources/'+value.chatImage+'">');
               var $inputt = $('<input type="hidden" class="crNo">').val(value.crNo);
               if(value.read == 'N') {
                  var $nImg = $('<img class="chat_read" src="resources/icons/chat_new.png" style="width: 10px; height:10px;">');
                  var $id = $("<li>").text(value.gName);
                  $id.append($nImg);
                  var $inputId = $('<input type="hidden" class="readId">').val(value.gNo);
               } else {
                     var $id = $("<li>").text(value.gName);
                     var $inputId = $('<input type="hidden" class="readId">').val(value.gNo);
               }
               var $cContent = $("<li>").text(value.cContent);
               
               $img.append($rImg);
               $ul.append($img);
               $ul.append($id);
               $ul.append($cContent);
               $div.append($ul);
               $div.append($inputt);
               $div.append($inputId);
               $("#myGroupChat_list").append($div);
            });
             },
             error:function(){
                console.log("에러");
             }
           });
     }
     
     /* 스크롤 하면 채팅 내용 불러오기 */
     function chatContentLoad() {
        $("#chatArea").scroll(function(){
         var sT = $("#chatArea").scrollTop();
            if(sT == 0) {
               var cNo = $(".5").val();
               var crNo = $(".3").val();
               $.ajax({
                  url:"chatContentLoad.do",
                  data:{cNo:cNo,crNo:crNo},
                  dataType:"json",
                  success:function(data){
                     var userId = '<c:out value="${loginUser.userId}"/>';
                     $.each(data,function(index,value){
                         if(value.fromId == userId) {
                            $div1 = $("<div class='myChating'>");
                            $div = $("<div>");
                            $p = $("<p id='myChatt'>").text(value.cContent);
                            $inputId = $("<input type='hidden' class='1'>").val(value.toId);
                            $inputType = $("<input type='hidden' class='2'>").val("chatting");
                            $inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
                            $inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
                            
                            $div.append($p);
                            $div1.append($div);
                            
                            $("#chatArea").prepend($div1);
                            $("#chatArea").prepend($inputId);
                             $("#chatArea").prepend($inputType);
                             $("#chatArea").prepend($inputCrNo);
                             $("#chatArea").prepend($inputcNo);
                            
                         } else {
                            $div3 = $("<div class='chating'>");
                            $inputId = $("<input type='hidden' class='1'>").val(value.fromId);
                            $inputType = $("<input type='hidden' class='2'>").val("chatting");
                            $inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
                            $inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
                            $inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
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
                             
                             $("#chatArea").prepend($div3);
                             $("#chatArea").prepend($inputId);
                             $("#chatArea").prepend($inputType);
                             $("#chatArea").prepend($inputCrNo);
                             $("#chatArea").prepend($inputChatImage);
                             $("#chatArea").prepend($inputcNo);
                         }
                      });
                  },
                  error:function(){
                     console.log("에러");
                  }
               });
            }
         });
     }
     
     /* 스크롤 하면 그룹채팅 내용 불러오기 */
     function groupChatContentLoad() {
        $("#chatArea").scroll(function(){
         var sT = $("#chatArea").scrollTop();
            if(sT == 0) {
               var gNo = $(".1").val();
               var crNo = $(".3").val();
               var cNo = $(".5").val();
               $.ajax({
                  url:"groupChatContentLoad.do",
                  data:{gNo:gNo,crNo:crNo,cNo:cNo},
                  dataType:"json",
                  success:function(data){
                     console.log("불러오기 성공");
                     var userId = '<c:out value="${loginUser.userId}"/>';
                      $.each(data,function(index,value){
                         var str = value.cContent;
                         if(str.slice(-8) == "입장하셨습니다.") {
                            $("#chatArea").prepend($("<p class='closeServer'>"+value.cContent+"<p/>"));
                         } else {
                            if(value.fromId == userId) {
                               $div1 = $("<div class='myChating'>");
                               $div = $("<div>");
                               $p = $("<p id='myChatt'>").text(value.cContent);
                               $inputId = $("<input type='hidden' class='1'>").val(value.gNo);
                               $inputType = $("<input type='hidden' class='2'>").val("groupChatting");
                               $inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
                               $inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
                               
                               $div.append($p);
                               $div1.append($div);
                               
                               $("#chatArea").prepend($div1);
                               $("#chatArea").prepend($inputId);
                                $("#chatArea").prepend($inputType);
                                $("#chatArea").prepend($inputCrNo);
                                $("#chatArea").prepend($inputcNo);
                            } else {
                               $div3 = $("<div class='chating'>");
                               $inputId = $("<input type='hidden' class='1'>").val(value.gNo);
                               $inputType = $("<input type='hidden' class='2'>").val("groupChatting");
                               $inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
                               $inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
                               $inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
                               $div = $("<div>");
                                $img = $('<img src="resources/'+value.chatImage+'">');
                                $p = $("<p id='chatId'>").text(value.fromId);
                                $div1 = $("<div>");
                                $a = $("<a id='chatText'>").text(value.cContent);
                                
                                $div.append($img);
                                $div.append($p);
                                $div1.append($a);
                                $div.append($div1);
                                $div3.append($div);
                                
                                $("#chatArea").prepend($div3);
                                $("#chatArea").prepend($inputId);
                                $("#chatArea").prepend($inputType);
                                $("#chatArea").prepend($inputCrNo);
                                $("#chatArea").prepend($inputChatImage);
                                $("#chatArea").prepend($inputcNo);
                            }
                         }
                      });
                  },
                  error:function(){
                     console.log("에러");
                  }
               });
            }
         });
     }
     /* 스크롤 하면 그룹채팅 내용 불러오기 */
     function groupChatContentLoad() {
    	 $("#chatArea").scroll(function(){
			var sT = $("#chatArea").scrollTop();
				if(sT == 0) {
					var gNo = $(".1").val();
					var crNo = $(".3").val();
					var cNo = $(".5").val();
					$.ajax({
						url:"groupChatContentLoad.do",
						data:{gNo:gNo,crNo:crNo,cNo:cNo},
						dataType:"json",
						success:function(data){
							console.log("불러오기 성공");
							var userId = '<c:out value="${loginUser.userId}"/>';
			    			$.each(data,function(index,value){
			    				var str = value.cContent;
			    				if(data == null) {
			    					console.log("값 X");
			    				} else if(str.slice(-8) == "입장하셨습니다.") {
			    					$inputId = $("<input type='hidden' class='1'>").val(value.gNo);
				    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
				    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
			    					$("#chatArea").prepend($("<p class='closeServer'>"+value.cContent+"<p/>"));
			    					$("#chatArea").prepend($inputId);
				        			$("#chatArea").prepend($inputCrNo);
				        			$("#chatArea").prepend($inputcNo);
			    				} else {
					    			if(value.fromId == userId) {
					    				$div1 = $("<div class='myChating'>");
					    				$div = $("<div>");
					    				$p = $("<p id='myChatt'>").text(value.cContent);
					    				$inputId = $("<input type='hidden' class='1'>").val(value.gNo);
					    				$inputType = $("<input type='hidden' class='2'>").val("groupChatting");
					    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
					    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
					    				
					    				$div.append($p);
					    				$div1.append($div);
					    				
					    				$("#chatArea").prepend($div1);
					    				$("#chatArea").prepend($inputId);
					        			$("#chatArea").prepend($inputType);
					        			$("#chatArea").prepend($inputCrNo);
					        			$("#chatArea").prepend($inputcNo);
					    			} else {
					    				$div3 = $("<div class='chating'>");
					    				$inputId = $("<input type='hidden' class='1'>").val(value.gNo);
					    				$inputType = $("<input type='hidden' class='2'>").val("groupChatting");
					    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
					    				$inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
					    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
					    				$div = $("<div>");
					        			$img = $('<img src="resources/'+value.chatImage+'">');
					        			$p = $("<p id='chatId'>").text(value.fromId);
					        			$div1 = $("<div>");
					        			$a = $("<a id='chatText'>").text(value.cContent);
					        			
					        			$div.append($img);
					        			$div.append($p);
					        			$div1.append($a);
					        			$div.append($div1);
					        			$div3.append($div);
					        			
					        			$("#chatArea").prepend($div3);
					        			$("#chatArea").prepend($inputId);
					        			$("#chatArea").prepend($inputType);
					        			$("#chatArea").prepend($inputCrNo);
					        			$("#chatArea").prepend($inputChatImage);
					        			$("#chatArea").prepend($inputcNo);
					    			}
			    				}
			    			});
						},
						error:function(){
							console.log("에러");
						}
					});
				}
			});
     }
     
     
     /* 채팅방 채팅내용 불러오기 */
     $(document).on("click",".chRoom",function(){
    	$("#inputArea").keydown(function(key){
    		if(key.keyCode == 13) {
   	 			sendMessage();
    		} 
    	});
		var crNo = $(this).children(".crNo").val();
		var d = $(this).children(".crNo").data("tt");
		var readId = $(this).children(".readId").val();
		$("#plusChatUser").remove();
		$.ajax({
			url:"oneChatContentList.do",
			data:{crNo:crNo, readId:readId},
         	type:"post",
    		dataType:"json",
    		success:function(data){
    			console.log("ok");
    			var userId = '<c:out value="${loginUser.userId}"/>';
    			$("#chatArea").children().remove();
    			$(".chatDeleteBtn").remove();
    			$btnImg = $("<img src='/spring/resources/icons/feed_menu.png'>");
    			$btn = $("<button class='chatDeleteBtn'>");
    			$btn.append($btnImg);
    			$("#chat_top").append($btn);
    			$.each(data,function(index,value){
	    			if(value.fromId == userId) {
	    				$div1 = $("<div class='myChating'>");
	    				$div = $("<div>");
	    				$p = $("<p id='myChatt'>").text(value.cContent);
	    				$inputId = $("<input type='hidden' class='1'>").val(value.toId);
	    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
	    				
	    				$div.append($p);
	    				$div1.append($div);
	    				
	    				$("#chatArea").append($div1);
	    				$("#chatArea").append($inputId);
	        			$("#chatArea").append($inputType);
	        			$("#chatArea").append($inputCrNo);
	        			$("#chatArea").append($inputcNo);
	    				
	    			} else {
	    				$div3 = $("<div class='chating'>");
	    				$inputId = $("<input type='hidden' class='1'>").val(value.fromId);
	    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
	    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
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
	        			$("#chatArea").append($inputcNo);
	    			}
    			});
    			$(".chat_room").show();
    			$("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
    			countChatRead();
    			chatContentLoad();
    		},
    		error:function(){
    			console.log('채팅 내용 불러오기에러');
    		}
		});
	 });
     /* 그룹 채팅방 채팅내용 불러오기 */
     $(document).on("click",".chRoom2",function(){
        
        $("#inputArea").keydown(function(key){
          if(key.keyCode == 13) {
                sendMessage();
          } 
        });
        
      var crNo = $(this).children(".crNo").val();
      var readId = $(this).children(".readId").val();
      console.log(crNo +":"+readId);
      $.ajax({
			url:"GroupChatContentList.do",
			data:{crNo:crNo, readId:readId},
	       	type:"post",
	  		dataType:"json",
	  		success:function(data){
  			console.log("ok");
  			var userId = '<c:out value="${loginUser.userId}"/>';
  			$("#chatArea").children().remove();
  			$(".chatDeleteBtn").remove();
  			$(".groupChatBtn").remove();
  			$btnImg = $("<img src='/spring/resources/icons/feed_menu.png'>");
			$btn = $("<button class='groupChatBtn'>");
			$btn.append($btnImg);
			$("#chat_top").append($btn);
  			$.each(data,function(index,value){
  				var str = value.cContent;
  				if(str.slice(-8) == "입장하셨습니다.") {
  						$inputId = $("<input type='hidden' class='1'>").val(value.gNo);
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputType = $("<input type='hidden' class='2'>").val("groupChatting");
	    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
	  					$("#chatArea").append($("<p class='closeServer'>"+value.cContent+"<p/>"));
	  					$("#chatArea").append($inputId);
	        			$("#chatArea").append($inputCrNo);
	        			$("#chatArea").append($inputcNo);
	        			$("#chatArea").append($inputType);
  				} else {
	    			if(value.fromId == userId) {
	    				$div1 = $("<div class='myChating'>");
	    				$div = $("<div>");
	    				$p = $("<p id='myChatt'>").text(value.cContent);
	    				$inputId = $("<input type='hidden' class='1'>").val(value.gNo);
	    				$inputType = $("<input type='hidden' class='2'>").val("groupChatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
	    				
	    				$div.append($p);
	    				$div1.append($div);
	    				
	    				$("#chatArea").append($div1);
	    				$("#chatArea").append($inputId);
	        			$("#chatArea").append($inputType);
	        			$("#chatArea").append($inputCrNo);
	        			$("#chatArea").append($inputcNo);
	    			} else {
	    				$div3 = $("<div class='chating'>");
	    				$inputId = $("<input type='hidden' class='1'>").val(value.gNo);
	    				$inputType = $("<input type='hidden' class='2'>").val("groupChatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
	    				$inputcNo = $("<input type='hidden' class='5'>").val(value.cNo);
	    				$div = $("<div>");
	        			$img = $('<img src="resources/'+value.chatImage+'">');
	        			$p = $("<p id='chatId'>").text(value.fromId);
	        			$div1 = $("<div>");
	        			$a = $("<a id='chatText'>").text(value.cContent);
	        			
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
	        			$("#chatArea").append($inputcNo);
	    			}
  				}
	    			$("#chatUser").text(value.gName);
  			});
  			$(".chat_room").show();
  			$("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
  			countChatRead();
  			groupChatContentLoad();
  		},
  		error:function(){
  			console.log('에러');
  		}
		});
	 });
    
     /* 페이지 로딩 시 실행되는 것들 */
     $(function(){
        countChatRead();
        $('#menu li:nth-child(2)').on("click",function(){
           var state = $(".chat").css('display');
           var state2 = $(".chat_room").css("display");
           if(state2 == 'none') {
              if(state =='none'){
                    openChat();
                    $('.chat').show();
                 } else {
                    $(".chat").hide();
                 }
           } else {
              $(".chat_room").hide();
              $(".chat").hide();
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
                if(data.crNo == -1) {
                   alert("이미 채팅방이 존재합니다.");
                } else {
                   $('.myFeed_popup_others').hide();
                   $("#chatUser").text(nId2);
                   $div3 = $("<div class='chating'>");
                   $inputId = $("<input type='hidden' class='1'>").val(nId2);
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
                }
             },
             error:function(){
                console.log("에러");
             }
          });
        });
        /* 그룹 채팅방 만들기 */
        $("#isnertGroupChat").on("click",function(){
          var createId = '${loginUser.userId}';
          var gNo = '${param.gNo}';
          var gName = $("#groupName").children("b").text();
          console.log(createId +":"+gNo + ":" + gName);
          $.ajax({
             url:'insertGroupChatRoom.do',
             data:{createId:createId,gNo:gNo},
             success:function(data){
                $('.pop_menu_master').hide();
                if(data.crNo == -1) {
                   alert("이미 채팅방이 존재합니다.");
                } else {
                   $("#chatUser").text(gName);
                   $div3 = $("<div class='chating'>");
                   $inputgNo = $("<input type='hidden' class='1'>").val(gNo);
                   $inputType = $("<input type='hidden' class='2'>").val("groupChatting");
                   $inputCrNo = $("<input type='hidden' class='3'>").val(data.crNo);
                   console.log(data.gNo +":" + data.crNo);
                   $("#chatArea").append($div3);
                    $("#chatArea").append($inputgNo);
                    $("#chatArea").append($inputType);
                    $("#chatArea").append($inputCrNo);
                    
                    $("#inputArea").keydown(function(key){
                        if(key.keyCode == 13) {
                              sendMessage();
                              $('#inputArea').val('');
                        } 
                      });
                   
                   $(".chat_room").show();
                }
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
             openChat();
         });

         $('.tab_menu_btn2').on('click',function(){
             $('.tab_box').hide();
             $('.tab_box2').show();
             openGruopChat();
         });

         $("#list").on("click",function(){
             $(".chat_room").show();
         });

         $('#goList').on("click",function(){
             $(".chat_room").hide();
             openChat();
         });
 		 $(".close").on("click",function(){
 			$(".chat_menu").hide(); 
 			$(".group_chat_menu").hide(); 
 		 });
     });
     $(document).on("click",".chatDeleteBtn",function(){
     		$(".chat_menu").show(); 
     })
     $(document).on("click",".groupChatBtn",function(){
     		$(".group_chat_menu").show(); 
     })
     
     /**************알림창 열기 ****************/
     $('#alarmIcon').on("click",function(){
    	 $("#alarmIcon").attr('src',"resources/icons/alarm.png")
       /*  $.ajax({
           url: "getNotification.do",
           success: function(data){
              
           },error: function(error){
              
           }
        })
        */ 
        
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
        if(sendType == 'chatting' || sendType == 'groupChatting') {
           sock.send($("#inputArea").val() +"|"+toId+"|"+sendType+"|"+crNo);
           $('#inputArea').val('');
        }
     }
     // 서버로부터 메시지를 받았을 때
     function onMessage(msg) {
        var data = msg.data;
        var dArr = data.split('|');
        console.log(data);
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
          $("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
        } else if(dArr.length == 3) {
         if(dArr[0] == null || dArr[0] == ' ') {
             
          } else {
             if(dArr[1] == 'sender') {
                $("#chatArea").append($("<p class='closeServer'>"+dArr[0]+"님이 입장하셨습니다.<p/>"));
             } else {
                 var toId = $("#chatArea").children(".1").val();
                 var inputChatImage = $("#chatArea").children(".4").val();
                 var sendType = $("#chatArea").children(".2").val();
                 console.log(toId+","+inputChatImage+","+sendType);
                 $div3 = $("<div class='chating'>");
                 $div = $("<div>");
                 $img = $('<img src="resources/'+dArr[2]+'">');
                 $p = $("<p id='chatId'>").text(dArr[1]);
                    
                 $div1 = $("<div>");
                 $a = $("<a id='chatText'>").text(dArr[0]);
                 
                 $div.append($img);
                 $div.append($p);
                 $div1.append($a);
                 $div.append($div1);
                 $div3.append($div);
                 
                 $("#chatArea").append($div3);
                 messageSound();
             }
             $("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
          }
        } else if(dArr.length < 2){
         
        	if(data == null || data == ' ') {
            
          } else {
             console.log("여기까진옴");
             var toId = $("#chatArea").children(".1").val();
             var inputChatImage = $("#chatArea").children(".4").val();
             var sendType = $("#chatArea").children(".2").val();
             console.log(toId+","+inputChatImage+","+sendType);
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
          };
           
        $("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
        countChatRead();
        openChat();
     }else{
			$("#alarmIcon").attr('src',"resources/icons/alarm_new.png");
			 // 팔로우 알림기능
				if(dArr[1] == 'follow'){
		 			$("#alarmIcon").attr('src',"resources/icons/alarm_new.png")
		 	 		$('#alarmList').prepend('<div id="list"><img src="resources/images/mp_profile_sample.jpg"><p><b><a href="goUserpage.do?userId='+dArr[2]+'&mNo='+ ${loginUser.mNo} + '">'+dArr[2]+'</a></b>님이 회원님을 팔로우합니다.</p></div>'); 					
				}else if(dArr[1] == 'groupjoin'){
					$('#alarmList').prepend('<div id="list"><img src="resources/images/mp_profile_sample.jpg"><p><b><a href="goUserpage.do?userId='+dArr[2]+'&mNo=' + ${loginUser.mNo} + '">'+dArr[2]+'</a></b>님이 그룹 가입을 신청했습니다.</p></div>');
				}else if(dArr[1] == 'groupAccept'){
					$('#alarmList').prepend('<div id="list"><img src="resources/images/mp_profile_sample.jpg"><p><b><a href="goUserpage.do?userId='+dArr[2]+'&mNo=' + ${loginUser.mNo} + '">'+dArr[2]+'</a></b>에서 그룹 가입을 승인했습니다.</p></div>');
				}else if(dArr[1] == 'like'){
					$('#alarmList').prepend('<div id="list"><img src="resources/images/mp_profile_sample.jpg"><p><b><a href="goUserpage.do?userId='+dArr[2]+'&mNo=' + ${loginUser.mNo} + '">'+dArr[2]+'</a></b>가 회원님의 게시물을 좋아합니다.</p></div>');
				};
				 
		 };
     };
		 
     // 서버와 연결을 끊었을 때
     function onClose(evt) {
        $("#chatArea").append($("<p class='closeServer'>연결끊김<p/>"));
     }
     
     
     
    /************* 내계정 자세히보기 script **************/

     $(document).ready(function(){
        $('.MyTab_tab').on("click",function(){
             $('.MyTab_tab').removeClass('on');
             $(this).addClass('on')
         });
        
        
         $("#detailInfo").on("click",function(){
            getFollowerList();
            $(".myAccount").animate({width:"toggle"},250);
         });

        $('.MyTab_tab1').on('click', function(){
           getFollowerList();
           $('.MyTab_box').hide();
            $('.MyTab_box1').show();
        });
        
        $('.MyTab_tab2').on('click', function(){
           getFollowList();
           $('.MyTab_box').hide();
            $('.MyTab_box2').show();
        });
     
        $('.MyTab_tab3').on("click", function(){
            getGroupList();
              $('.MyTab_box').hide();
             $('.MyTab_box3').show();
        });

        
        $(document).on("click","#goDetail",function(){
           var gNo =$(this).parents().children('input').val();
           console.log(gNo);
           location.href="gdetail.do?gNo="+ gNo;
        });
        
        $(document).on("click","#goUserPage",function(){
           var userId = $(this).parents().children('a').text();
           var mNo = $(this).parents().children('input').val();
           location.href="goUserpage.do?userId=" + userId + "&mNo=" + mNo;
        });
        
        
        $(document).on("click","#follower", function(){
           var mNo = ${ loginUser.mNo };
           var follower = $(this).parents().children('input').val();
           console.log(follower);
           $.ajax({
             url:"delFollower.do",
             data:{mNo:mNo, foNo:follower},
             type:"post",
             success:function(data){
                if(data>0){
                   alert("삭제하였습니다.");
                   getFollowerList();
                }else{
                   alert("삭제 실패하였습니다.");
                }
             },error:function(){
                alert("삭제오류");
             }
           });
           
        });
     
        
        $(document).on("click","#following", function(){
           var mNo = ${ loginUser.mNo };
           var follows = $(this).parents().children('input').val();
           console.log(follows);
           $.ajax({
              url:"delFollow.do",
              data:{ mNo:mNo, foNo:follows},
              type:"post",
              success:function(data){
                 console.log(data);
                    if(data> 0){
                       alert("팔로우를 취소하였습니다.");
                       getFollowList();
                    }else{
                       alert("실패했습니다.");
                    }
                    
                 },error:function(){
                    alert("불러오기 실패..");
                 }
           });
        });
     });
       
       function getFollowerList(){
          var mNo = ${ loginUser.mNo };
           $.ajax({
              url:"getFollowerList.do",
              data:{mNo:mNo},
              dataType:"json",
              success:function(data){
                 console.log(data);
                 $div=$("#My_follower_list");
                  $div.html("");
                  
                  var $ul;
                  var $img;
                  var $userId;
                  var $btn;
                  var $mNo;
                  var $p;
                  
                  if(data.length > 0 ){
                     for(var i in data){
                        console.log(data[i].mImage);
                        $ul = $("<ul id='follower_info'>").html('<input type="hidden" id="mNo" value="'+ data[i].mNo+'">');
                        $img = $("<li>").html('<img src="resources/'+ data[i].mImage + '" id="follower_list_img">');
                        $userId = $("<li id='id'>").html('<a id="goUserPage">'+data[i].userId);
                        $btn = $("<li>").html('<button id="follower" name="follower">삭제</button>');
                        $mNo = $("<li>").html('<input type="hidden" id="mNo" name="mNo" value="'+ data[i].mNo+'">');
                        
                        $ul.append($img);
                        $ul.append($userId);
                        $ul.append($btn);
                        $ul.append($mNo);
                        $div.append($ul);
                     }
                  }else{
                     $p = $('<p id="textP">').text("나를 팔로우한 회원이 없습니다.");
                     
                     $div.append($p);
                  }
              },error:function(){
                 alert("불러오기 실패..");
              }
           }); 
       };
       
       function getFollowList(){
          var mNo = ${ loginUser.mNo };
           $.ajax({
              url:"getFollowList.do",
              data:{mNo:mNo},
              dataType:"json",
              success:function(data){
                 console.log(data);
                 $div=$("#My_following_list");
                  $div.html("");
                  
                  var $ul;
                  var $img;
                  var $userId;
                  var $btn;
                  var $p;
                  
                  if(data.length > 0){
                     $.each(data, function(index,value){
                        console.log(value.mImage);
                        $ul = $("<ul id='following_info'>").html('<input type="hidden" id="mNo" name="mNo" value="'+ value.mNo+'">');
                        $img = $("<li>").html('<img src="resources/'+ value.mImage + '" id="following_list_img">');
                        $userId = $("<li id='id'>").html('<a id="goUserPage">'+value.userId);
                        $btn = $("<li>").html('<button id="following" name="following">팔로우 취소</button>');
                        
                        $ul.append($img);
                        $ul.append($userId);
                        $ul.append($btn);
                        $div.append($ul);
                     });
                 }else{
                     $p = $('<p id="textP">').text("팔로우한 회원이 없습니다.");
                     
                     $div.append($p);
                  }
              },error:function(){
                 alert("불러오기 실패..");
              }
           }); 
       };
    
       function getGroupList(){
          $.ajax({
              url:"getGroupList.do",
              data:{mId:"${ loginUser.userId }"},
              async:false,
              dataType:"json",
              success:function(data){
                 console.log(data);
                 $div=$("#My_fgroup_list");
                  $div.html("");
                  
                  var $ul;
                  var $gNo;
                  var $img;
                  var $gName;
                  var $btn;
                  var $p;
                  
                  if(data.length > 0 ){
                     for(var i in data){
                        $ul = $("<ul id='fgroup_info'>").html('<input type="hidden" id="gNo" name="gNo" value="' + data[i].gNo + '">');
                        $img = $("<li>").html('<img src="resources/'+ data[i].gImage + '" id="fgroup_list_img"">');
                        $gName = $("<li>").html('<a id="goDetail">'+data[i].gName);
                        
                        
                        $ul.append($img);
                        $ul.append($gName);
                        $div.append($ul);
                     }
                  }else{
                     $p = $('<p id="textP">').text("가입한 그룹이 없습니다.");
                     
                     $div.append($p);
                  }
                  $('.MyTab_box').hide();
                    $('.MyTab_box3').show();
                    
              },error:function(){
                 alert("불러오기 실패..");
              }
           }); 
       };
       

          function search() {
         var allSearch = $('#allSearch').val();  //검색어
             var sign = allSearch.charAt(0);         //검색어 첫글자 - 기호
         var slength = allSearch.length;         //검색어 길이
         var keyword = allSearch.substr(1);      //키워드

         if(sign == " "){
            alert('검색어 첫글자를 띄어 쓸 수 없습니다');      
         }else if(slength < 1){
            location.href="search.do?type=recommend&key="+${ loginUser.mNo };
         }else if(sign =='#'){
            location.href="search.do?type=tag&key="+keyword;
         }else if(sign =='@'){
            location.href="search.do?type=user&key="+keyword;
         }else{
            location.href="search.do?type=all&key="+allSearch;
         }
      };

     </script>
</body>
</html>