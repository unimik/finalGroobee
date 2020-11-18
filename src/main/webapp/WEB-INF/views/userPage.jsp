<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_Main.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pop_menu.css">
   <style>
   		#myPage_feed{
   			width:640px;
   		}
   		.feedPost{
   			border-bottom:2px solid #47c6a3;
   			transition:0.5s all;
   			padding-bottom:10px;
   		}
   		#interests{
	    font-size:smaller;
	    color:grey;
	    }
	    #myPage_introduction{
	    padding-top: 20px;
	    }
	    #mp_profile_info>h5{
	    color:#555555;
		margin: 0px;
		height:15px;
		margin-left:20px;
		font-weight:500;
	    }
	    #mp_profile_info>h3{
	    margin-bottom:5px;
	    }
	    #mp_profile_follow{
	    margin-top:10px;
	    }
	    #self-introduction{
	    margin:0 40px 30px 30px;
	    }
	    .follow_wrap{ display: none; width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 1; background-color: rgb(0,0,0); 
    	background-color: rgba(0,0,0,0.5);}
    	.following_wrap{ display: none; width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 1; background-color: rgb(0,0,0); 
   		background-color: rgba(0,0,0,0.5);}
    	.follow_detail{ background: white; border-radius: 15px; -ms-overflow-style: none; width: 400px; height: 500px; position: fixed; top: 20%; left: 42%;}
    	.follow_title{ height: 60px; border-bottom: 1px solid #e5e5e5; text-align: center; }
    	.follow_title>p{ padding:20px; color:#555555; font-weight:600; }
    	.follow_list{ height: 440px; overflow-y: scroll; }
    	.follow_list>ul{ 
		    margin: 30px;
		    text-align: center;
		    list-style: none;
		    padding: unset;
    	 }
    	.follow_list>ul>li{ 
		    height: 40px;
		    margin-bottom: 10px;
    	 }
		.follow_list::-webkit-scrollbar{display: none;}
		.close_popup>img{ width:20px; height: 20px; margin: 10px; float: right; }
		#blockedCancle_btn{ width: 120px; height: 40px; margin-top: 40px; background: #daf4ed; border: none; border-radius: 10px; color: #555555;
                    position: relative; right: 30px; /* display: none; */ }
        .postbox_text{padding:30px 50px; font-weight: 600; width: 500px; text-align:center; }
        #showfeed{ margin:0;padding:0; text-align:center; height:40px;}
        #showfeed{ list-style:none;}
        #selectRtype{ width: 100px; height: 35px; border: 0; background: #daf4ed; border-radius: 10px; margin-left: 55px; }
  		#reportContent{margin-top:14px; margin-left:50px; background:#daf4ed; resize:none;display:none; border:none;}
  		#cancel2{margin-left: 16px; margin-top:-4px;cursor: pointer;display: block;width: 100px; background:#e5e5e5;border: none;border-radius: 10px;width:100px;height: 35px;float: left;}	
		#report-submit{ width: 100px; height: 35px; border: 0; background: #daf4ed; border-radius: 10px; margin-left: 55px; }
		#imgList{position:relative; margin:0; padding:0; height:633px; list-style:none; overflow:hidden;}
		#imgList li{display:none; float:left; position: absolute; top:0; left:0;}
		#imgList li:nth-child(1){display:block;}
		#imgList img{ width: 633px; height:633px; }
		.imgbtn{  z-index:10;border: 0; background: none; cursor: pointer;outline:none;}
		button[name=nextBtn]{display:none; position: absolute; margin: 300px 570px; }
		button[name=prevBtn]{display:none; position: absolute; margin: 300px 20px; }
   </style>
</head>
<body>
   <c:import url="common/menubar.jsp"/>
            
        <!-- 피드 부분 -->
            <div id="feedArea">
                <div id="feed">

                <!-- 프로필 시작 -->
                    <div id="myPage_profile">
                        <div id="mp_profile_img">
                           <c:if test="${ !empty memberInfo.mRenameImage }">
                           	<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ memberInfo.mRenameImage }" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                            <c:if test="${ empty memberInfo.mRenameImage }">
                            <img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                        </div>
                        <div id="mp_profile_info">
                            <h3>${ memberInfo.userId }</h3>
                            <h5>${ memberInfo.userName }</h5>
                        </div>
                        <div id="mp_profile_edit">
                        <input type="hidden" id="mNo" value="${ loginUser.mNo }"/>
                        <input type="hidden" id="follow" value="${ memberInfo.mNo }"/>
                        <input type="hidden" id="followYN" value="${followYN}"/>
                        <input type="hidden" id="openStatus" value="${userPs.openStatus}"/>
                        
                      
                        	<c:if test="${followYN eq 'Y' && blockedYN eq 'N'}">
                        		<input type="button" id="followCancle_btn" name="followCancle_btn" value="팔로우 취소">
                        	</c:if>
                        	<c:if test="${blockedYN ne 'N'}">
                        		<c:url var="myDisableBlock" value="myDisableBlock.do">
                                	<c:param name="disblockId" value="${ memberInfo.mNo }"/>
                                	<c:param name="userId" value="${ memberInfo.userId }"/>
                                </c:url>
                        		<input type="button" id="blockedCancle_btn" name="blockedCancle_btn" onclick="location.href='${ myDisableBlock }'" value="차단 해제">
                        	</c:if>
                        	<c:if test="${followYN eq 'N' && blockedYN eq 'N'}">
                        		<input type="button" id="follow_btn" name="follow_btn" value="팔로우">                        	
                        	</c:if>       
                            <img src="<%=request.getContextPath()%>/resources/images/dot.png" type="button" id="details_btn">
                        </div>

                    <!-- 다른 사람이 내 피드를 방문했을 때 -->
                       <div class="myFeed_popup_others">
                            <div id="myFeed_others_list">
                                <ul>
                                <li><a id="myFeed_report_btn">신고</a></li> 
                                <c:choose>
                                	<c:when test="${blockedYN ne 'N'}">
	                                	<c:url var="myDisableBlock" value="myDisableBlock.do">
		                                	<c:param name="disblockId" value="${ memberInfo.mNo }"/>
		                                	<c:param name="userId" value="${ memberInfo.userId }"/>
	                                	</c:url>
                                		<li><a id="myFeed_block_btn" href="${ myDisableBlock }">차단해제</a></li> 
                                	</c:when>
                                	<c:otherwise>
	                                	<c:url var="myBlockAccount" value="myBlockAccount.do">
		                                	<c:param name="newblock" value="${ memberInfo.mNo }"/>
		                                	<c:param name="userId" value="${ memberInfo.userId }"/>
                                			<c:param name="follow" value="${ memberInfo.mNo }"/>
	                                	</c:url>
		                                <li><a id="myFeed_block_btn" href="${ myBlockAccount }">차단하기</a></li>                             	
                                	</c:otherwise>
                                </c:choose>
                                <li><a id="myFeed_message_btn">메세지</a></li> 
                                <li><a id="pop_close">취소</a></li>
                                </ul>
                            </div>
                        </div>

                        <!-- 신고했을 경우(진선 작성) -->
						<div class="feed_report">
				                <div id="feed_report_con">
				                    <p>신고사유</p>
				                    <select id="reportType" class="selectRtype">
				                        <option value="unacceptfeed" selected>부적절한 게시글</option>
				                        <option value="insult">욕설</option>
				                        <option value="ad">광고</option>
				                        <option value="spam">도배</option>
				                    </select>
				                    	<textarea class="sendreport" id="reportContent" cols="28" rows="4" style="display:none;"></textarea>
				                    <br>
				                    <input class="selectRtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
				                    <input class="sendreport" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
				                    <button class="selectRtype" id="cancel" style="cursor:pointer;">취소</button>
				                    <button class="sendreport" id="cancel2" style="cursor:pointer; display:none;">취소</button>
				                </div>
				         </div>

                    <!-- 차단했을 경우 -->
                        <div class="feed_block">
                            <div id="feed_block_pop">
                                <input type="button" id="block_pop" value="${ memberInfo.userId } 님을 차단하였습니다.">
                            </div>
                        </div>
                        <div id="mp_profile_follow">
                            <ul id="follow_post">
                                <li>게시물</li>
                                <li class="post_num">${ feedCnt }</li>
                            </ul>
                            <a style="cursor:pointer;">
                            	<ul id="follow_follower">
                                <li>팔로워</li>
                                <li class="follower_num">${ followInfo.followers }</li>
                            </ul>
                            </a>
                            <a style="cursor:pointer;">
                            <ul id="follow_following">
                                <li>팔로잉</li>
                                <li class="following_num">${ followInfo.follows }</li>
                            </ul>
                            </a>
                        </div>
                    </div>
                    
                    <!-- 팔로워,팔로우 리스트 -->
                     <div class="follow_wrap">
                    	<div class="close_popup">
                            <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                    	</div>
                    	<div class="follow_detail">
	                    	<div class="follow_title">
	                    		<p>팔로워</p>
	                    	</div>
	                    	<div class="follow_list">
		                    	<c:forEach var="followerList" items="${ followerList }">
	                    		<ul>
	                    		   <c:url var="goUserPage" value="goUserpage.do">
	                               		<c:param name="mNo" value="${ followerList.mNo }"/>
	                               </c:url>
                                   <c:if test="${ !empty followerList.mNo }">
                                   		<c:if test="${ loginUser.userId eq followerList.userId }">
                                   			<li><a href="goMypage.do?mNo=${ loginUser.mNo }">${ loginUser.userId }</a></li>
                                   		</c:if>
                                   		<c:if test="${ loginUser.userId ne followerList.userId }">
	                    		   		<li><a href="goUserpage.do?userId=${ followerList.userId }&mNo=${ loginUser.mNo }">${ followerList.userId }</a></li>
                                   		</c:if>
                                   </c:if>
                                   <c:if test="${ empty followerList.mNo }">
	                    		   		<li>팔로워가 없습니다. </li>
                                   </c:if>
	                    		</ul>
		                    	</c:forEach>
	                    	</div>
                    	</div>
                    </div>
                    <div class="following_wrap">
                    	<div class="close_popup">
                            <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                    	</div>
                    	<div class="follow_detail">
	                    	<div class="follow_title">
	                    		<p>팔로우</p>
	                    	</div>
	                    	<div class="follow_list">
		                    	<c:forEach var="followingList" items="${ followingList }">
	                    		<ul>
	                    		   <c:url var="goUserPage" value="goUserpage.do">
	                               		<c:param name="mNo" value="${ followingList.mNo }"/>
	                               </c:url>
                                   <c:if test="${ !empty followingList.mNo }">
	                    		   		<c:if test="${ loginUser.userId eq followingList.userId }">
                                   			<li><a href="goMypage.do?mNo=${ loginUser.mNo }">${ loginUser.userId }</a></li>
                                   		</c:if>
                                   		<c:if test="${ loginUser.userId ne followingList.userId }">
	                    		   		<li><a href="goUserpage.do?userId=${ followingList.userId }&mNo=${ loginUser.mNo }">${ followingList.userId }</a></li>
                                   		</c:if>
                                   </c:if>
                                   <c:if test="${ empty followingList.mNo }">
	                    		   		<li>팔로우가 없습니다. </li>
                                   </c:if>
	                    		</ul>
		                    	</c:forEach>
	                    	</div>
                    	</div>
                    </div>

                <!-- 소개 부분 -->
                    <div id="myPage_introduction">
                        <div id="self-introduction">
                            ${ memberInfo.mIntro }
                        </div>
                        <div id="interests">
                             ${ memberInfo.interestes }
                        </div>
                    </div>
                    
            <!-- 내가 올린 피드 목록 -->
                <div id="myPage_feedList">
                    <div id="myPage_feed">
                        <ul id="showfeed">
                            <li colspan="3"><div class="feedPost">게시글</div></li>
                        </ul>

                    <!--게시글-->
                    	<c:if test="${blockedYN eq 'N'}">
                    		<c:choose>
	                    		<c:when test="${ userPs.openStatus eq 'F' && followYN eq 'N'}">
		                    		<div class="post">
			                    		<p class="postbox_text" name="postbox">비공개 계정입니다. 게시물을 보려면 팔로우 신청을 해주세요. </p>
		                    		</div>
	                    		</c:when>
	                    		<c:otherwise>
			                        <c:forEach var="feedlist" items="${ feedList }">
			                        <input type="hidden" id="fNo" name="fNo" value="${ feedlist.fNo }">
			                        <div class="post">
			                            <c:choose>
			                                 <c:when test="${!empty feedlist.thumbnail }">
			                                     <img class="postbox" name="postbox" src="<%=request.getContextPath()%>/resources/pUploadFiles/${ feedlist.thumbnail }" type="button" onclick="goDetail(${ feedlist.fNo })">
			                                 </c:when>
			                                 <c:otherwise>
			                                     <div class="postbox" name="postbox" onclick="goDetail(${ feedlist.fNo })">
			                                         <div type="button" id="pb2">
			                                             <text>${ feedlist.fContent }</text>
			                                         </div>
			                                     </div>
			                                 </c:otherwise>
			                              </c:choose>
				                      </div>
			                          </c:forEach>
	                    		</c:otherwise>
                    		</c:choose>
                    	</c:if>
                    <!-- 포스트박스 클릭 시 -->
                        <div class="pop_feed">
                            
                        </div>

                   
                </div>
            </div>
        </div>


    <script>
    
    	/* 차단하기 */
    	
		/* 팔로우,팔로워 클릭 시 */
	    $('#follow_following').click(function() {
	        $('.following_wrap').show();
	    });
	    $('#follow_follower').click(function() {
	        $('.follow_wrap').show();
	    });
	
	    $('.close_popup').click(function() {
	        $('.follow_wrap').hide();
	        $('.following_wrap').hide();
	    });

        $('div[type = button]').css({'cursor' : 'pointer'});
        $('input[type = button]').css({'cursor' : 'pointer'});
        $('img[type = button]').css({'cursor' : 'pointer'});


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

        
        /************ 팔로우 언팔로우 script ************/

        $('#follow_btn').click(function() {
            
            var mNo = $('#mNo').val();
            var follow = $('#follow').val();
            
            console.log("follow 클릭됨");
            sendAlram('${loginUser.userId}','${ memberInfo.userId }','follow','1');
            
            $.ajax({
 	       		 url: 'insertFollow.do',
 	      		  	 type: 'post',
 	      		   	 data: {follow:follow,mNo:mNo},
 	      		   	 datatype:"text",
 	      		   	 success: function(data){
 		      		   	if(data == 'success'){
 		      		 	  	window.location.reload();
 		  		   		 }else{
 		  		   			alert("팔로우 실패했습니다.");
 		  		   		 }
 	      		   	 },error: function(error){
 	      		   		 alert(error+"팔로우 에러");
 	      		   	 }
 	       	 });
        });

        $('#followCancle_btn').click(function() {
           
            var mNo = $('#mNo').val();
            var follow = $('#follow').val();
            
            $.ajax({
 	       		 url: 'deleteFollow.do',
 	      		  	 type: 'post',
 	      		   	 data: {follow:follow,mNo:mNo},
 	      		   	 datatype:"text",
 	      		   	 success: function(data){
 		      		   	if(data == 'success'){
 		      		   		window.location.reload();
 		  		   		 }else{
 		  		   			alert("팔로우 취소 실패했습니다.");
 		  		   		 }
 	      		   	 },error: function(error){
 	      		   		 alert(error+"팔로우 에러");
 	      		   	 }
 	       	 });
        });


        /************ 게시글, 보관함, 내 그룹 전환 시 script ************/

        $('.feedPost_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.post').show();
            $('.storagebox').hide();
            $('.group').hide();
        });

        $('.feedStorageBox_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.post').hide();
            $('.storagebox').show();
            $('.group').hide();
        });

        $('.feedMyGroup_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.post').hide();
            $('.storagebox').hide();
            $('.group').show();
        });



        /********* 보관함 수정 및 삭제 script ************/
        
         $('.storageBox_subBtn1').click(function() {
            var mNo = $('#mNo').val();
         $.ajax({
            url:"insertBox.do",
            dataType:"json",
            data:{mNo: mNo},
            type:"post",
            success:function(data){
               if(data.storageBoxList != null && data.storageBoxList != 'undefined'){
               alert("되냐");
                  /* $('.folder_default').show();
                     $('.folder_correct').hide();
                     $('.folder_delete').hide();

                     $('.storageBox_subBtn3').hide();
                     $('.storageBox_subBtn4').show(); */
                     
                     var input="";
                     input += "<td class='storageBox_folder'>";<%-- <img src="../resources/icons/folder.png" type='button'>"; --%>
                     input += "<table>";
                     input += "<tr class='storagebox'>";
                        input += "<td class='folder_default' align='center'>";
                      input += "<label class='current_folder'>"+data.storageBoxList.sbName+"</label>";
                      input += "</td>";
                      input += "<td class='folder_correct' align='center'>";
                      input += "<input type='text' id='rename_folder' class='rename_folder' value='"+data.storageBoxList.sbName+"' maxlength='10'>";
                      input += "</td>";
                      input += "<td class='folder_delete' align='center' id='folder_delete'>";
                      input += "<input type='checkbox' id='delete_folder'>";
                      input += "<label for='delete_folder1' class='dltfolder'>"+data.storageBoxList.sbName+"</label>";
                      input += "</td>";
                      input += "</tr>";
                      input += "</table>";
                     input += "</td>";
                     
                     $("#box").append(input);
                    /*  $("#box").html(input); */

               }else if(data.msg != null && data.msg != 'undefined'){
                  alert(data.msg);
               }else{
                  alert("시스템 오류입니다.");
               }

            },
             error:function(request,jqXHR,exception){
               var msg="";
               if(request.status == 0){
                  msg = 'Not Connect. \n Verify Network.';
               } else if(request.status == 404){
                  msg = 'Requested page not fount [404]';
               } else if(request.status == 500){
                  msg = 'Internal Server Error [500]';
               } else if(request.status == 'parsererror'){
                  msg = 'Requested JSON parse failed';
               } else if(exception == 'timeout'){
                  msg = 'Time out error';
               } else if(exception == 'abort'){
                  msg = 'Ajax request aborted';
               } else {
                  msg = 'Error. \n' + jqXHR.responseText;
               }
               alert(msg);
            } 
         });
         
           
        });
        
        $('#close_btn').on('click',function(){
           $('.myFeed_popup_myEdit').hide();
         });

        $('.storageBox_subBtn2').click(function() {
            $('.folder_default').hide();
            $('.folder_correct').show();
            $('.folder_delete').hide();

            $('.storageBox_subBtn3').hide();
            $('.storageBox_subBtn4').show();
        });

        $('.storageBox_subBtn3').click(function() {
               var rename_folderId = 
               $.ajax({
                  url:"updateBox.do",
                  data:{
                     id: rename_folder0   
                  },
                  type:"post",
                  success:function(data){
                     console.log(data);
                        $('.folder_default').hide();
                        $('.folder_correct').hide();
                        $('.folder_delete').show();

                        $('.storageBox_subBtn2').hide();
                        $('.storageBox_subBtn4').show();
                  },
                   error:function(request,jqXHR,exception){
                     var msg="";
                     if(request.status == 0){
                        msg = 'Not Connect. \n Verify Network.';
                     } else if(request.status == 404){
                        msg = 'Requested page not fount [404]';
                     } else if(request.status == 500){
                        msg = 'Internal Server Error [500]';
                     } else if(request.status == 'parsererror'){
                        msg = 'Requested JSON parse failed';
                     } else if(exception == 'timeout'){
                        msg = 'Time out error';
                     } else if(exception == 'abort'){
                        msg = 'Ajax request aborted';
                     } else {
                        msg = 'Error. \n' + jqXHR.responseText;
                     }
                     alert(msg);
                  } 
               });
            
            
        });

        $('.storageBox_subBtn4').click(function() {
            $('.folder_default').show();
            $('.folder_correct').hide();
            $('.folder_delete').hide();

            $('.storageBox_subBtn4').hide();
            $('.storageBox_subBtn2').show();
            $('.storageBox_subBtn3').show();
        });


        /************ 포스트 박스 클릭 시 script ************/

        function goDetail(fNo){
        	   var mNo = $('#follow').val();
               $.ajax({
                  url:"goDetail.do",
                  dataType:"json",
                  data:{mNo: mNo,fNo : fNo},
                  type:"post",
                  success:function(data){
                    
                	  var input="";
                      input += "<div class='feed_delete'>";
                      input += "<img src='${ contextPath }/resources/icons/close_white.png' type='button'>";
                      input += "</div>";
	                  input += "<div id='writer_submenu'>";
	                  if(data.mImage != null){
	                    input += "<img src='${ contextPath }/resources/memberProfileFiles/"+data.mImage+"' alt='' id='feed_profile_img'>";
	                  } else {
	                    input += "<img src='${ contextPath }/resources/icons/pro_default.png' alt='' id='feed_profile_img'>";
	                  }
		              input += "<div id='user_time'>";
		              input += "<p id='feed_id'>"+data.fWriter+"</p>";
		              input += "<h6>"+data.fCreateDate+"</h6>";
		              input += "</div>";
		              input += "<img src='${ contextPath }/resources/icons/feed_menu.png' alt='' id='feed_menu'>";
		              input += "</div>";
		              <!-- 다른 회원 글 볼 때 피드 메뉴 -->
		              input +="<div class='pop_menu'>";
		              input +="<div id='feed_menu_list'>";
		              input +="<ul>";
		              input +="<li><a id='feed_report_btn'>신고</a></li>"; 
		              input +="<li><a>공유하기</a></li>"; 
		              input +="<li><a>보관함</a></li>";
		              input +="<li><a id='close'>취소</a></li>";
		              input +="</ul>";
		              input +="</div>";
		              input +="</div>";
		              input +="<div class='feed_report'>";
		              input +="<div id='feed_report_con'>";
		              input +="<p>신고 사유</p>";
		              input +="<select>";
		              input +="<option>부적절한 게시글</option>";
		              input +="<option>욕설</option>";
		              input +="<option>광고</option>";
		              input +="<option>도배</option>";
		              input +="</select>";
		              input +="<br>";
		              input +="<input type='button' id='submit' name='submit' value='확인'>";
		              input +="<button id='cancel'>취소</button>";
		              input +="</div>";
		              input +="</div>";
		              input +="<div id='con'>";
		              input +="<div id='feed_content'>";
		              
		         	var size;
		  	        var idx = idx1 = 0;
		  	       // var count = $(".feed").children('div#con').children('div#feed_content').children("ul#imgList").length;
		  	        var ul;
		  	        //console.log(count);
		  	        var liCount;
		  	        
	  				if( data.photoList.length > 1){
	  	        		$('#nextBtn'+i).css("display","block");
	  	        		$('#prevBtn'+i).css({"display":"block"});
	  	        	}
 		            	// ul = $("#feed"+i).children('div#con').children('div#feed_content').children("ul#imgList").children("li").length;
 		  				
 		  				//console.log(ul);
 		  				
 		  				
 		  			/* 	
 		  				$('#prevBtn'+i).on("click",function(){
 		      	  			size = $(this).nextAll().children('li').length;
 		      	  			console.log(size);
 		      	  			
 		      	  			if(size > 1){
 		      	  				idx1 = (idx-1) % size;
 		      	  				if(idx1 < 0)
 		      	  					idx1 = size - 1;
 		      	  					
 		      	  					$(this).nextAll().children('li:hidden').css("left","-633px");
 		      	  					$(this).nextAll().children('li:eq('+idx+')').animate({left:"+=633px"},500,function(){
 		      	  						$(this).css("display","none").css("left","-633px");
 		      	  					});
 		      	  					$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"+=633px"},500);
 		      	  					idx = idx1;
 		      	  			}
 		      	  		});
 		  				
 		  				$('#nextBtn'+i).on("click",function(){
 		      	  			size = $(this).nextAll().children('li').length;
 		      	  			console.log(size);
 		      	  			
 		      	  			if( size > 1){
 		      	  				idx1 = (idx + 1) % size;
 		      	  				$(this).nextAll().children('li:hidden').css("left","633px");
 		      	  				$(this).nextAll().children('li:eq('+idx+')').animate({left:"-=633px"},500, function(){
 		      	  					$(this).css("display","none").css("left","633px");
 		      	  				});
 		      	  				$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"-=633px"},500);
 		      	  				idx = idx1;
 		      	  			} */
		            	
		              for(var i=0; i<data.photoList.length; i++){
						  if(data.photoList[i].changeName != null){
							  input +="<ul id='imgList'>";
						      input +="<button id='nextBtn${ i }' name='nextBtn' class='imgbtn nextBtn'><img src='${ contextPath }/resources/icons/nextbtn.png'></button>";
							  input +="<button id='prevBtn${ i }' name='prevBtn' class='imgbtn prevBtn'><img src='${ contextPath }/resources/icons/prevbtn.png'></button>";
							  input +="<img src='${ contextPath }/resources/pUploadFiles/"+data.photoList[i].changeName+"' alt='' id='input_img'>";
							  input +="</ul>";
			            	  }
		              }
		              input +="<p id='text'>"+data.fcontent+"</p>";
		              input +="<ul id='tag'>";
		              input +="<li>#피자</li>";
		              input +="</ul>";
		              input +="<div id='heart_reply'>";
		              input +="<img src='${ contextPath }/resources/icons/heart.png' type='button' alt='' id='likeIcon'>";
		              input +="<img src='${ contextPath }/resources/icons/bubble.png' type='button' alt='' id='replyIcon'>";
		              input +="</div>";
		              input +="</div>";
		              for(var i=0;i<data.replyList.length;i++){
		                  input +="<div id='replyArea'>";
		                  input +="<div id='replyList'>";
		                  input +="<ul id='re_list'>";
		            	  input +="<li><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></li>";
			              input +="<li><p id='replyCon'>"+data.replyList[i].rContent+"</p></li>";
			              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
			              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn'></li>";
			              input +="</ul>";
			              input +="</div>";
			              input +="<div class='reply_menu'>";
			              input +="<div id='re_menu_list'>";
			              input +="<ul>";
			              input +="<li><a>댓글 수정</a></li>";
			              input +="<li><a>댓글 삭제</a></li>";
			              input +="<li><a id='re_close'>취소</a></li>";
			              input +="</ul>";
			          	  input +="</div>";
		                  input +="</div>";
		              }
		              input +="<div id='reply'>";
		              input +="<input type='text' id='textArea' name='textArea'>";
		              input +="<input type='button' id='replyBtn' name='replyBtn' value='등록'>";
		              input +="</div>";
		              input +="</div>";
		              input +="</div>";

                        
                      $(".pop_feed").html(input);
          	 		  $(".pop_feed").show();

          	        $('.feed_delete').click(function() {
          	            $(".pop_feed").hide();
          	        });

                  	}, error:function(request,jqXHR,exception){
	                     var msg="";
	                     if(request.status == 0){
	                        msg = 'Not Connect. \n Verify Network.';
	                     } else if(request.status == 404){
	                        msg = 'Requested page not fount [404]';
	                     } else if(request.status == 500){
	                        msg = 'Internal Server Error [500]';
	                     } else if(request.status == 'parsererror'){
	                        msg = 'Requested JSON parse failed';
	                     } else if(exception == 'timeout'){
	                        msg = 'Time out error';
	                     } else if(exception == 'abort'){
	                        msg = 'Ajax request aborted';
	                     } else {
	                        msg = 'Error. \n' + jqXHR.responseText;
	                     }
	                     alert(msg);
	                  } 
               	});
        }
        
        $('#pb1').click(function() {
            $(".pop_feed").show();
        });

        $('#pb2').mouseover(function() {
            $(this).css({'background' : '#daf4eda1'});
        }).mouseleave(function() {
            $(this).css({'background' : 'none'});
        }).click(function() {
            $(".pop_feed").show();
        });
	 		  





        /************* 팝업 메뉴 script *************/

        $('#details_btn').on("click", function(){
            $('.myFeed_popup_others').show();
        });
        
        
        $('#pop_close').on('click', function(){
            $('.myFeed_popup_others').hide();
        });



        $('#myFeed_report_btn').on("click", function(){
            $('.feed_report').show();
        });

        $('#cancel').on("click", function(){
            $('.feed_report').hide();
        });

        $('#myFeed_block_btn').on('click', function(){
            $('.feed_block').show();
        });

        $('#block_pop').on("click", function(){
            $('.feed_block').hide();
            $('.myFeed_popup_others').hide();
        });

        $('#profile_edit_btn').on("click", function(){
            $('.myFeed_popup_myEdit').show();
        });

        $('#close').on("click", function(){
            $('.myFeed_popup_myEdit').hide();
        });

        $('#updateBtn').on("click", function(){
            $('.reply_menu').show();
        });

        $('#re_close').on("click", function(){
            $('.reply_menu').hide();
        });
		
        /**************** 회원 신고 관련*******************/ 
     	$(document).on('click',"#report-submit",function(){
     		
     		if($("#reportContent").val() == ""){
     			alert('신고 사유를 입력해 주세요.')
     		}else{
     			
     			$.ajax({
     				url:'reportMInsert.do',
     				data:{
     					reportType : $("#reportType").val(),
     					feedType : "member",
     					content : $("#reportContent").val(),
     					targetmNo:${ memberInfo.mNo }
     				},
     				success: function(){
     					$(".feed_report").css('display','none');
     					$(".selectRtype").css("display","inline-block");
     		      		$(".sendreport").css("display","none");
     		      		$("#reportContent").val('')
     		      		$(".myFeed_popup_others").css("display",'none');
     					alert('신고완료');
     				},error:function(){
     					alert('신고 실패!');
     				}
     			});
     			
     		};
     	});
     	
         $("#cancel2").on('click',function(){ 		
     		$(".selectRtype").css("display","inline-block");
     		$("#cancel").css('display',"inline-block");
     		$("#reportContent").val("");
     		
     		$("#reportContent").css("display","none"); // 세부 항목
       		$("#report-submit").css("display","none"); // 세부 항목 확인버튼 
       		$("#selectRtype").css("display","inline-block"); // 셀렉트 확인버튼
       		$("#reportType").css("display","inline-block"); // 셀렉트
       		
       	})
       	
       	 $("#cancel").on('click',function(){
       		$("#reportContent").val("");

       		$(".feed_report").css('display','none'); // 전체창 끄기
       	})
       	
       	
       	$("#selectRtype").on('click',function(){
       		$("#reportContent").css("display","inline-block");  // 세부 항목
       		$("#report-submit").css("display","inline-block"); // 세부 항목 확인버튼
       		$("#selectRtype").css("display","none"); // 셀렉트 확인버튼
       		$("#reportType").css("display","none"); // 셀렉트
       		
       		$("#feed_report").css("display","none"); // 전송 후 전체창 끄기
       	}); 
    </script>
</body>
</html>