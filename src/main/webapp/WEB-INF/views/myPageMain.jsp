<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_Main.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/chat.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myAccount.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pop_menu.css">
   <style>
    .sbNameBox{
    border:none;
    background: #fcfcfc;
    font-size:16px;
    color: #555555;
    readonly="readonly";
    }
    .fstorageBox_folder,.sbBoxCheck{
     display:none;
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
    margin:30px 40px 30px 30px;
    }
   	.follow_wrap{ display: none; width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 1; background-color: rgb(0,0,0); 
   		background-color: rgba(0,0,0,0.5);}
   	.following_wrap{ display: none; width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 1; background-color: rgb(0,0,0); 
   		background-color: rgba(0,0,0,0.5);}
   	.follow_detail{ background: white; border-radius: 15px;  width: 400px; height: 400px; position: fixed; top: 20%; left: 42%;}
   	.follow_title{ height: 60px; border-bottom: 1px solid #e5e5e5; text-align: center; }
   	.follow_title>p{ padding:20px; color:#555555; font-weight:600; }
   	.follow_list{ height: 320px; overflow-y: scroll; -ms-overflow-style: none; }
   	.follow_list>ul{ 
   		margin-left:130px;
   		width:100%;
   		height:40px;
	    list-style: none;
	    padding: unset;
   	 }
   	.follow_list>ul>li{ 
	    height: 40px;
	    margin:0;
	    margin-bottom: 10px;
	    float:left; 
   	 }
   	.follow_list img{ width:40px; height:40px; border-radius:10px; float:left; margin-right:20px;}
	.follow_list::-webkit-scrollbar{display: none;}
	.close_popup>img{ width:20px; height: 20px; margin: 10px; float: right; }
	#groupName{ font-weight: 600; }
	.groupInfo h5{ font-weight: 300; }
	#imgList{position:relative; margin:0; padding:0; height:633px; list-style:none; overflow:hidden;}
	#imgList li{display:none; float:left; position: absolute; top:0; left:0;}
	#imgList li:nth-child(1){display:block;}
	#imgList img{ width: 633px; height:633px; }
	.imgbtn{  z-index:10;border: 0; background: none; cursor: pointer; outline:none;}
	button[name=nextBtn]{display:none; position: absolute; margin: 300px 570px; }
	button[name=prevBtn]{display:none; position: absolute; margin: 300px 20px; }
	.setN{ margin-left: 25px; font-size: 10pt; color: #a9a9a9; line-height: 2.7em; }
	#replyIcon{ margin: 9px 0 0 60px;}
	#likeIcon { margin: 7px 0 0 25px; }
	.postbox{float: left; cursor: pointer; margin: 10px 5px 0 5px;}
	.post .img_wrap:before{margin: 10px 5px 0 5px;}
	.usertag{ color: #47c6a3;}
	#user_time h6{margin-bottom:0;margin-top:3px;}
   </style>
   <script>
  
	function getParameterByName(name) {
       name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
       var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
               results = regex.exec(location.search);
       return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
   }
	
   $(function(){
	 	var getType = getParameterByName("type");
		//alert(getType);	 
		if( getType == 1 ){
		$('.storageBox_subBtn3').show();
		$('.storageBox_subBtn4').hide();
		$('.storageBox_subBtn5').hide();
	    $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #47c6a3'});  
		$('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
		$('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
		$('.post').hide();
		$('.storagebox').show();
		$('.group').hide();
        $('.fstorageBox_folder').show();
		
		}
   });
   </script>
   
   
   
</head>
<body>
   <c:import url="common/menubar.jsp"/>
            
        <!-- 피드 부분 -->
            <div id="feedArea">
                <div id="feed">

                <!-- 프로필 시작 -->
                    <div id="myPage_profile">
                        <div id="mp_profile_img">
                           <c:if test="${ !empty loginUser.mRenameImage }">
                           	<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                            <c:if test="${ empty loginUser.mRenameImage }">
                            <img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                        </div>
                        <div id="mp_profile_info">
                            <h3>${ loginUser.userId }</h3>
                            <h5>${ loginUser.userName }</h5>
                        </div>
                        <div id="mp_profile_edit">
                            <input type="button" id="profile_edit_btn" name="profile_edit_btn" value="프로필 편집">
                            <%-- <input type="button" id="follow_btn" name="follow_btn" value="팔로우">
                            <input type="button" id="followCancle_btn" name="followCancle_btn" value="팔로우 취소">
                            <img src="<%=request.getContextPath()%>/resources/images/dot.png" type="button" id="details_btn"> --%>
                        </div>

                    <!-- 다른 사람이 내 피드를 방문했을 때 -->
                       <div class="myFeed_popup_others">
                            <div id="myFeed_others_list">
                                <ul>
                                <li><a id="myFeed_report_btn">신고</a></li> 
                                <li><a id="myFeed_block_btn">차단하기</a></li> 
                                <li><a id="myFeed_message_btn">메세지</a></li> 
                                <li><a id="close">취소</a></li>
                                </ul>
                            </div>
                        </div>

                    <!-- 내 피드에서 프로필 편집을 누를 경우 -->
                        <div class="myFeed_popup_myEdit">
                            <div id="myFeed_myEdit_list">
                        <c:url var="mupdateView" value="mupdateView.do"/>
                        <c:url var="updatePwd" value="updatePwdView.do"/>
                                <ul>
                                <li><a href="${ mupdateView }" id="edit_profile">기본 정보 수정</a></li> 
                                <li><a href="${ updatePwd }" id="edit_password">비밀번호 변경</a></li> 
                                <li><a id="close_btn">취소</a></li>
                                </ul>
                            </div>
                        </div> 

                    <!-- 신고했을 경우 -->
                        <div class="feed_report">
                            <div id="feed_report_con">
                                <p>신고 사유</p>
                                <select>
                                    <option>부적절한 게시글</option>
                                    <option>욕설</option>
                                    <option>광고</option>
                                    <option>도배</option>
                                </select>
                                <br>
                                <input type="button" id="submit" name="submit" value="확인">
                                <button id="cancel">취소</button>
                            </div>
                        </div>

                    <!-- 차단했을 경우 -->
                        <div class="feed_block">
                            <div id="feed_block_pop">
                                <input type="button" id="block_pop" value="user01 님을 차단하였습니다.">
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
	                    		   <c:url var="goMypage" value="goMypage.do">
	                               		<c:param name="mNo" value="${ followerList.mNo }"/>
	                               </c:url>
                                   <c:if test="${ !empty followerList.mNo }">
                                   		<c:if test="${ !empty followerList.mRenameProfile }">
                                   			<li><a href="goUserpage.do?userId=${ followerList.userId }&mNo=${ loginUser.mNo }"><img id="f_img" src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ followerList.mRenameProfile }"></a></li>
	                    		   		</c:if>
	                    		   		<c:if test="${ empty followerList.mRenameProfile }">
	                    		   			<li><a href="goUserpage.do?userId=${ followerList.userId }&mNo=${ loginUser.mNo }"><img id="f_img" src="<%=request.getContextPath()%>/resources/icons/pro_default.png"></a></li>
	                    		   		</c:if>
	                    		   		<li><a href="goUserpage.do?userId=${ followerList.userId }&mNo=${ loginUser.mNo }">${ followerList.userId }</a></li>
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
	                    		   <c:url var="goMypage" value="goMypage.do">
	                               		<c:param name="mNo" value="${ followingList.mNo }"/>
	                               </c:url>
                                   <c:if test="${ !empty followingList.mNo }">
                                   		<c:if test="${ !empty followingList.mRenameProfile }">
                                   			<li><a href="goUserpage.do?userId=${ followingList.userId }&mNo=${ loginUser.mNo }"><img id="f_img" src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ followingList.mRenameProfile }"></a></li>
	                    		   		</c:if>
	                    		   		<c:if test="${ empty followingList.mRenameProfile }">
	                    		   			<li><a href="goUserpage.do?userId=${ followingList.userId }&mNo=${ loginUser.mNo }"><img id="f_img" src="<%=request.getContextPath()%>/resources/icons/pro_default.png"></a></li>
	                    		   		</c:if>
	                    		   		<li><a href="goUserpage.do?userId=${ followingList.userId }&mNo=${ loginUser.mNo }">${ followingList.userId }</a></li>
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
                            ${ loginUser.mIntro }
                        </div>
                        <div id="interests" style="font-size:smaller; color:grey;">
                             ${ loginUser.interestes }
                        </div>
                    </div>
                    
            <!-- 내가 올린 피드 목록 -->
                <div id="myPage_feedList">
                    <div id="myPage_feed">
                        <ul id="myPageAllBtn">
                            <li><div type="button" class="feedPost_btn">게시글</div></li>
                            <li><div type="button" class="feedStorageBox_btn">보관함</div></li>
                            <li><div type="button" class="feedMyGroup_btn">내 그룹</div></li>
                        </ul>

                    <!-- 게시글 -->
                        <div class="post_all">
                        <c:forEach var="feedlist" items="${ feedList }">
                        <div class="post">
                            <c:choose>
                                 <c:when test="${!empty feedlist.thumbnail }">
                                 	<div class="img_wrap" onclick="goDetail(${ feedlist.fNo },${ feedlist.mNo },0)">
                                    	<img class="postbox" name="postbox" src="<%=request.getContextPath()%>/resources/pUploadFiles/${ feedlist.thumbnail }" type="button" class="pb1">                                 	
                                 	</div>
                                 </c:when>
                                 <c:otherwise>
                                     <div class="postbox" name="postbox" onclick="goDetail(${ feedlist.fNo },${ feedlist.mNo },0)">
                                         <div type="button" class="pb2">
                                             <text>${ feedlist.fContent }</text>
                                         </div>
                                     </div>
                                 </c:otherwise>
                              </c:choose>
                          </div>    
                          </c:forEach>
                          </div>

                    <!-- 포스트박스 클릭 시 -->
                        <div class="pop_feed">
                        </div>

                    <!-- 보관함 -->
                      <div class="storagebox" id="storagebox">
                      	<ul id="storageIconBox">
                            <input type="hidden" id="mNo" value="${ loginUser.mNo }"/>
                            <li id="storageBox" colspan="3">
                                <div id="sb_menu">
                                    <div type="button" class="storageBox_subBtn1"><img src="<%=request.getContextPath()%>/resources/icons/add.png"></div>
                                    <div type="button" class="storageBox_subBtn2"><img src="<%=request.getContextPath()%>/resources/icons/correct_folder.png"></div>
                                    <div type="button" class="storageBox_subBtn3"><img src="<%=request.getContextPath()%>/resources/icons/delete.png"></div>
                                    <div type="button" class="storageBox_subBtn4"><img src="<%=request.getContextPath()%>/resources/icons/check.png"></div>
                                    <div type="button" class="storageBox_subBtn5"><img src="<%=request.getContextPath()%>/resources/icons/check.png"></div>
                                </div>
                            </li>
                        </ul>
	                        <div id="storageboxArea">
		                        <c:forEach var="sb" items="${ storageBoxList }">
		                    	<div class="storagebox">
		                            <!-- <div id="box">보관함새폴더생성</div>-->
		                            <div class="fstorageBox_folder">
		                            	<img src="<%=request.getContextPath()%>/resources/icons/folder.png" class="sbButton" id="${ sb.sbNo }" type="button">
			                            <label>
			                            <input type="checkbox" class="sbBoxCheck" value="${ sb.sbNo }">
			                            <input type="hidden" class="sbNo" value="${ sb.sbNo }">
			                            <input type="text" class="sbNameBox"  value="${ sb.sbName }">
			                            </label>                            
		                            </div>
		                        </div>
		                        </c:forEach>
	                        </div>
						</div>
                        <!-- empty-space -->
                         <!--    <tr class="group">
                                <td class="empty-space" colspan="3"></td>
                            </tr>
                             
                        <!-- 내 그룹 목록 -->
                       <div id="allGroupList">
                       <c:forEach var="groupList" items="${ groupList }">
                       <c:if test="${ !empty groupList }">
                       <div id="groupList" class="group">
                       		<div class="gOne">
                              <div class="groupImg">
                                   <c:url var="gdetail" value="gdetail.do">
                              			<c:param name="gNo" value="${ groupList.gNo }"/>
                            	   </c:url>
	                              <c:if test="${ !empty groupList.gImage }">
									<a href="${ gdetail }">
									    <div id="group_img"><img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ groupList.gRenameProfile }"></div>
									</a>
	                              </c:if>
	                              <c:if test="${ empty groupList.gImage }">
	                                 <a href="${ gdetail }">
	                                    <div id="group_img"><img src="<%=request.getContextPath()%>/resources/images/group_logo1.png"></div>
	                                 </a>
	                              </c:if>
                              </div>
                                <div class="groupInfo">
                                	<div class="g_in">
                                   		<a id="groupName" href="${ gdetail }">${ groupList.gName }</a>
										<h5 class="group_interests">${ groupList.gCategory }</h5>
										<h5 class="group_subDate">가입일 ${ groupList.gJoinDate }</h5>
									</div>
									<c:url var="myGmDelete" value="myGmDelete.do">
										<c:param name="gNo" value="${ groupList.gNo }"/>
										<c:param name="gmId" value="${ loginUser.userId }"/>
										<c:param name="mNo" value="${ loginUser.mNo }"/>
									</c:url>
									<input type="button" class="leaveBtn" value="탈퇴" onclick="location.href='${ myGmDelete }'">
                                </div>
                                </div>
                                </c:if>
                                </c:forEach>
                           </div>
                         </div>

                    </div>
                </div>
        </div>



    <script>
    
    /************ 포스트 박스 클릭 시 script ************/
    function goDetail(fNo,smNo,type){
    	var mNo = $('#mNo').val();
    
           $.ajax({
              url:"goDetail.do", 
              dataType:"json",
		    	// smNo : 공유한 글작성자
              data:{mNo: mNo, fNo : fNo, smNo : smNo, type: type},
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
	              input += "<img src='${ contextPath }/resources/icons/feed_menu.png' alt='' id='feed_menu' class='test'>";
	              input += "</div>";
	              <!-- 내가 쓴 글 볼 때 피드 메뉴 -->
	              input +="<div class='pop_menu'>";
				 if(data.type == 0){
		              if(data.shareYN == 'N'){
			              input +="<div id='feed_Mymenu_list'>";
			              input +="<ul>";
			              input +="<li><a href='pUpdateView.do?fNo="+fNo+"&like="+data.fLikeSet+"&share="+data.fShareSet+"&reply="+data.fReplySet+"' id='feed_menu1_btn'>수정</a></li>";
			              input +="<li><a href='pDelete.do?fNo="+fNo+"' class='deleteMyPost'>삭제</a></li>";
			              input +="<li><a id='close' class='close'>취소</a></li>";
			              input +="</ul>";
			              input +="</div>";
		             } else{
			              input +="<div id='share_Mymenu_list'>";
			              input +="<ul>";
		            	  input +="<li><a href='shareFeedCancle.do?sfNo="+fNo+"&smNo="+mNo+"' class='deleteMyPost'>공유 취소</a></li>";
			              input +="<li><a id='close' class='close'>취소</a></li>";
			              input +="</ul>";
			              input +="</div>";
		              }	 
				 }else{
					 /*보관함 메뉴*/
					  input +="<div id='share_Mymenu_list'>";
		              input +="<ul>";
	            	  input +="<li><a  href='#' onclick='deleteStorageFeed("+fNo+","+type+")' class='deleteMyPost'>보관함에서 삭제</a></li>";
		              input +="<li><a id='close' class='close'>취소</a></li>";
		              input +="</ul>";
		             input +="</div>";
				 }
	              input +="</div>";
	              input +="<div id='con'>";
	              input +="<div id='feed_content'>";
 	        	  if(data.photoList[0] != null){
	      	  	 	input +="<button id='nextBtn${ i }' name='nextBtn' class='imgbtn nextBtn'><img src='${ contextPath }/resources/icons/nextbtn.png'></button>";
				 	input +="<button id='prevBtn${ i }' name='prevBtn' class='imgbtn prevBtn'><img src='${ contextPath }/resources/icons/prevbtn.png'></button>";
            	 	input +="<ul id='imgList' style='height:633px'>";
	              	for(var i=0; i < data.photoList.length; i++){
					  if(data.photoList[i].changeName != null){
						  input +="<li><img src='${ contextPath }/resources/pUploadFiles/"+data.photoList[i].changeName+"' alt='' id='input_img'></li>";
		              }
	              } 
	              input +="</ul>";
  	        	  }
	              input +="<p id='text'>"+data.fcontent+"</p>";
	              if(data.shareYN == 'N'){
	              input +="<div id='heart_reply'>";
				  <!-- 좋아요 금지가 되어 있지 않을 경우 -->
 				  if(data.fLikeSet == 'Y' ||  data.fLikeSet == null){
					<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
	             	if(data.likeChk == null){
		             	input +="<img src='${ contextPath }/resources/icons/heart.png' alt='' name='"+fNo+"'class='likeIcon' id='likeIcon' onclick='likeClick(this);'>";
		             	input +="<label class='likeCnt' id='"+fNo+"'>"+data.fLikeCnt+"개</label>";
	             	} else {
		             	input +="<img src='${ contextPath }/resources/icons/heart_red.png' alt='' name='"+fNo+"' class='liked' id='liked' onclick='likeClick(this);'>";	             	
		             	input +="<label class='likeCnt' id='"+fNo+"'>"+data.fLikeCnt+"개</label>";
	             	}
				  }
 				 input +="<input type='hidden'  class='fLikeCnt' value='"+data.fLikeCnt+"'>";
				  input +="<input type='hidden' class='toNo' value='"+fNo+"'>";
				  input +="<input type='hidden' class='toId' value='"+data.fWriter+"'>";
              	  	<!-- 댓글이 전체 허용일 경우 -->
				  if(data.fReplySet == 'Y' || data.fReplySet == null){
				  	 if(data.fLikeSet == 'N'){
				  	 <!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
				  	 input +="<img src='${ contextPath }/resources/icons/bubble.png' alt='' id='replyIcon' style='margin: 9px 0 0 25px;'>";
				  	 	if(data.replyListSize > 0){
				  	 	 if(data.replyList[0].rStatus == 'Y'){
				  	 	 input +="<label class='replycnt_p'>"+data.replyListSize+"개</label>";
				  	 	 }
				  	 	 else if(data.replyList[0].rStatus == 'N' || data.replyList[0].rStatus == null){
				  	 	 input +="<label class='replycnt_p'>0개</label>";
				  	 	 }
				  	 	} else {
				  	 	 input +="<label class='replycnt_p'>0개</label>";
				  	 	}
				  	 } else {
				  	 <!-- 댓글과 좋아요 모두 허용될 때 -->
				  	 input +="<img src='${ contextPath }/resources/icons/bubble.png' alt='' id='replyIcon'>";
				  		if(data.replyListSize > 0){
				  	 	 if(data.replyList[0].rStatus == 'Y'){
				  	 	 input +="<label class='replycnt_p'>"+data.replyListSize+"개</label>";
				  	 	 }
				  	 	 else if(data.replyList[0].rStatus == 'N' || data.replyList[0].rStatus == null){
				  	 	 input +="<label class='replycnt_p'>0개</label>";
				  	 	 }
				  		} else {
					  	 	 input +="<label class='replycnt_p'>0개</label>";
					  	 	}
				  	 }
				  }
				  if(data.fReplySet == 'N' && data.fLikeSet == 'N'){
				  input +="<label class='setN'>댓글과 좋아요가 금지된 포스트입니다.</label>";
				  } 
 	              input +="</div>";
	              input +="</div>";
                  input +="<div id='replyArea'>";
	              input +="<div id='replyEditCont'>";
                  if(data.replyList[0] != null){
	              input +="<div id='replySub'>";
	              for(var i=0;i<data.replyList.length;i++){
		              input +="<div id='selectOne'>";	
		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
	                  input +="<div id='replyList'>";
	                  input +="<ul id='re_list' class='list'>";
	                  if(data.replyList[i].mNo == mNo){
	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	                  } else {
	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	                  }
	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
		              if(data.replyList[i].mNo == mNo){
						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
		               }
					  input +="</ul>";
		              input +="</div>";
		              input +="<div class='reply_menu'>";

		              if(data.replyList[i].mNo == mNo){
			              input +="<div id='re_menu_list'>";
			              input +="<ul>";
			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
			              input +="</ul>";
			          	  input +="</div>";
		              } else{
			              input +="<div id='user_menu_list'>";
			              input +="<ul>";
		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
			              input +="</ul>";
			          	  input +="</div>";
			    		  <!-- 댓글을 신고해보자! -->
			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
			    		  input +="<div id='reply_report_con'>";
				    	  input +="<p>신고사유</p>";
				    	  input +="<select id='reply_reportType' class='selectRtype'>";
				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
					      input +="<option value='insult'>욕설</option>";
					      input +="<option value='ad'>광고</option>";
					      input +="<option value='spam'>도배</option>";
					      input +="</select>";   
					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
					      input +="</div>";
					      input +="</div>";
		              }
                  	  input +="</div>";
	                  input +="</div>";       
	              }
                  input +="</div>";       
                  }
                  input +="</div>"; 
                  if(data.fReplySet == 'Y' || data.fReplySet == null){
	              input +="<div id='reply'>";
	              input +="<input type='hidden' class='replyFeedNo' name='replyFeedNo' value="+fNo+">";
	              input +="<input type='text' id='textArea'class='rContent'  name='textArea'>";
	              input +="<input type='button' id='replyBtn'  class='replyUpBtn' name='replyBtn' value='등록' onClick='applyReply("+fNo+");'>";
	              input +="</div>";
                  }
	              input +="</div>";
	              }
	              input +="</div>";

                    
                  $(".pop_feed").html(input);
      	 		  $(".pop_feed").show();

      	        $('.feed_delete').click(function() {
      	            $(".pop_feed").hide();
      	        });
      	        
	      	      $('#feed_menu').click(function() {
	                  $('.pop_menu').show();
		          }); 
		      	
		          $('.close').on('click', function(){
		              $('.pop_menu').hide();
		          });
		          
 		          $('.rUpBtn').on("click", function(e){
 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
		              $(replyMenu).show();
		          }); 
		          $('.rClose').on("click", function(){
		              $('.reply_menu').hide();
		          });
		          
		          $('.cancel').on("click", function(){
		              $('.feed_report').hide();
		          });
		          
		          $('.cancel').on("click", function(){
		              $('.reply_report').hide();
		          });
		          $('#re_close').on("click", function(){
		              $('.reply_menu').hide();
		          });
		          
		          $('.cancel').on("click", function(){
		              $('.feed_report').hide();
		          });
		          
		          $('.cancel').on("click", function(){
		              $('.reply_report').hide();
		          });
		          
		          
		        var size;
		        var idx = idx1 = 0;
		        var count = $(".pop_feed").children('div#con').children('div#feed_content').children("ul#imgList").children('li').length;
		        console.log(count);
		        var liCount;
		          
		  		for (var i = 1; i <= count; i++){
		  			
		  			if( count > 1){
		          		$('#nextBtn').css("display","block");
		          		$('#prevBtn').css({"display":"block"});
		          	}
		  			
		  		}
		  			$(document).on("click",'#prevBtn',function(){
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
		  			
		  			$(document).on("click",'#nextBtn',function(){
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
		     	  			}
		     	  		});	
		  			
		          
		  		 	/* 댓글 신고하기*/
		  		 	// 1. 신고하기 버튼 이벤트
		  		 	$(document).on("click","#rReport",function(){
		  		 		$(".reply_report").css("display","block");
		  		 		// 2.리플 번호 불러오기
		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
		  		 		
		  			 	// 3. 댓글 신고하기
		  			 	$(document).on("click",'.reply_submit',function(){
		  			 		var text =$(this).prev().prev().prev().val();
		  			 		
		  			 		console.log(text);
		  		 			console.log(targetrNo);
		  			 		console.log($("#reply_reportType").val());
		  			 		
		  			 		if(text == ""){
		  						alert('신고 사유를 입력해 주세요.')
		  					}else{
		  						
		  						$.ajax({
		  							url:'reportRInsert.do',
		  							data:{
		  								reportType : $("#reply_reportType").val(),
		  								replyType : "reply",
		  								content : text,
		  								targetrNo:targetrNo
		  							},
		  							success: function(){
		  								alert('신고 완료');
		  								$('.reply_menu').hide();
		  					      		$('.reply_report').hide();
		  							},error:function(){
		  								alert('신고 실패!');
		  							}
		  						});
		  						
		  					};	
		  			 	});
		  		 	});
		         	 
		      	   	$(".cancel2").on("click",function(e){
		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
		      	   		$(feedReport).css('display', 'none');
		      			$(".selectRtype").css("display", "inline-block");
		      	   		$(".sendreport").css("display", "none");
		      	   	});
		      	   	
		      	   	$(".Rtype").on("click",function(e){
		      	   		$(".selectRtype").css("display", "none");
		      	   		$(".sendreport").css("display", "block");
		      	   	});
		          
		          /* 댓글 수정시 텍스트창 변경 */
		          $('.rEdit').on("click", function(e) {
		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

		      			repCon.css('border', '1px solid #555555');
		        	  	repCon.removeAttr('disabled');
		        	  	repCon.removeAttr('readonly');
		        	  	repBtn.css('display', 'block');
		        	  	rupBtn.css('display', 'none');
		        	 
		        	  	$('.reply_menu').hide();
		          });
		          
		      	/* 댓글 수정 시 완료 버튼 누르면 */
		       	$('.rConfirm').on("click", function(e) {
		      		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
		      		var rWriter = '${loginUser.userId}';
		      		var replyContent = $(this).parent().children()[1].children[0].value;
		      		
		      			$.ajax({
		      				url: "editReply.do",
		      				data: {
		      					rContent: replyContent,
		      					rNo: rNo,
		      					rWriter: rWriter,
		      					fNo : fNo
		      				},
		      				type: "post",
		      				async:false,
		      				success: function(data) {	// 성공 시: success, 실패 시: fail
		      					console.log(data);
		       				
//		      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
		       						//location.href="goMypage.do?mNo="+mNo;
		       						$('#replySub').remove();
		       						
		       						var input = "";
		       					 input +="<div id='replySub'>";
		       	              for(var i=0;i<data.replyList.length;i++){
		       		              input +="<div id='selectOne'>";	
		       		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
		       		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
		       	                  input +="<div id='replyList'>";
		       	                  input +="<ul id='re_list' class='list'>";
		       	                  if(data.replyList[i].mNo == mNo){
		       	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		       	                  } else {
		       	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		       	                  }
		       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
		       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
		       		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
		       		              if(data.replyList[i].mNo == mNo){
		       						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
		       		               }
		       					  input +="</ul>";
		       		              input +="</div>";
		       		              input +="<div class='reply_menu'>";

		       		              if(data.replyList[i].mNo == mNo){
		       			              input +="<div id='re_menu_list'>";
		       			              input +="<ul>";
		       			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
		       			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
		       			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
		       			              input +="</ul>";
		       			          	  input +="</div>";
		       		              } else{
		    			              input +="<div id='user_menu_list'>";
		    			              input +="<ul>";
		    		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
		    		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
		    			              input +="</ul>";
		    			          	  input +="</div>";
		    			    		  <!-- 댓글을 신고해보자! -->
		    			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
		    			    		  input +="<div id='reply_report_con'>";
		    				    	  input +="<p>신고사유</p>";
		    				    	  input +="<select id='reply_reportType' class='selectRtype'>";
		    				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
		    					      input +="<option value='insult'>욕설</option>";
		    					      input +="<option value='ad'>광고</option>";
		    					      input +="<option value='spam'>도배</option>";
		    					      input +="</select>";   
		    					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
		    					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
		    					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
		    					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
		    					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
		    					      input +="</div>";
		    					      input +="</div>";
		       		              }
		                          input +="</div>";
		                          input +="</div>";
		       	              }
		       	                  input +="</div>"; 
		       	                  
		       	                  $('#replyEditCont').append(input);
		       	                  
		       	                  
		       	      	        $('.feed_delete').click(function() {
		       	      	            $(".pop_feed").hide();
		       	      	        });
		       	      	        
		       		      	      $('#feed_menu').click(function() {
		       		                  $('.pop_menu').show();
		       			          }); 
		       			      	
		       			          $('.close').on('click', function(){
		       			              $('.pop_menu').hide();
		       			          });
		       			          
		       	 		          $('.rUpBtn').on("click", function(e){
		       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
		       			              $(replyMenu).show();
		       			          }); 
		       			          $('.rClose').on("click", function(){
		       			              $('.reply_menu').hide();
		       			          });
		       			          
		       			          $('.cancel').on("click", function(){
		       			              $('.feed_report').hide();
		       			          });
		       			          
		       			          $('.cancel').on("click", function(){
		       			              $('.reply_report').hide();
		       			          });
		       			          
		       			  		// 댓글 삭제 시
		       			  		$('.rDelete').on("click", function(e) {
		       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
		       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
		       						var rWriter = '${loginUser.userId}';
		       						var none = $(this.parentElement).parents("div#replySub").children.length;
		       						
		       						$.ajax({
		       							url: "deleteReply.do",
		       							data: {rNo: rNo},
		       							type: "post",
		       							success: function(data) {	// 성공 시: success, 실패 시: fail
		       				  				if(data == "success") {
//		       									$(ul).css('display', 'none');
		       									$('.rNum').css('display', 'none');
		       									location.href="goMypage.do?mNo="+mNo;
		       								}
		       							}, error: function() {
		       								console.log("전송 실패");
		       							}
		       						});
		       						
		       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
		       						if(none == 0) {
		       							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
		       						}
		       						
		       						confirm("댓글을 삭제하시겠습니까?");
		       			  		});
		       			          
		       			          // text-area resize
		       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
		       			      		var offset = this.offsetHeight - this.clientHeight;
		       			      		var resizeTextarea = function(el) {
		       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
		       			      		};
		       			      		$(this).on('keyup input', function() {
		       			      		 resizeTextarea(this);
		       			      		}).removeAttr('data-autoresize');
		       			      	});
		       			          
		    		  		 	/* 댓글 신고하기*/
		    		  		 	// 1. 신고하기 버튼 이벤트
		    		  		 	$(document).on("click","#rReport",function(){
		    		  		 		$(".reply_report").css("display","block");
		    		  		 		// 2.리플 번호 불러오기
		    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
		    		  		 		
		    		  			 	// 3. 댓글 신고하기
		    		  			 	$(document).on("click",'.reply_submit',function(){
		    		  			 		var text =$(this).prev().prev().prev().val();
		    		  			 		
		    		  			 		console.log(text);
		    		  		 			console.log(targetrNo);
		    		  			 		console.log($("#reply_reportType").val());
		    		  			 		
		    		  			 		if(text == ""){
		    		  						alert('신고 사유를 입력해 주세요.')
		    		  					}else{
		    		  						
		    		  						$.ajax({
		    		  							url:'reportRInsert.do',
		    		  							data:{
		    		  								reportType : $("#reply_reportType").val(),
		    		  								replyType : "reply",
		    		  								content : text,
		    		  								targetrNo:targetrNo
		    		  							},
		    		  							success: function(){
		    		  								alert('신고 완료');
		    		  								$('.reply_menu').hide();
		    		  					      		$('.reply_report').hide();
		    		  							},error:function(){
		    		  								alert('신고 실패!');
		    		  							}
		    		  						});
		    		  						
		    		  					};	
		    		  			 	});
		    		  		 	});
		    		         	 
		    		      	   	$(".cancel2").on("click",function(e){
		    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
		    		      	   		$(feedReport).css('display', 'none');
		    		      			$(".selectRtype").css("display", "inline-block");
		    		      	   		$(".sendreport").css("display", "none");
		    		      	   	});
		    		      	   	
		    		      	   	$(".Rtype").on("click",function(e){
		    		      	   		$(".selectRtype").css("display", "none");
		    		      	   		$(".sendreport").css("display", "block");
		    		      	   	});
		    		          
		    		          /* 댓글 수정시 텍스트창 변경 */
		    		          $('.rEdit').on("click", function(e) {
		    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
		    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
		    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

		    		      			repCon.css('border', '1px solid #555555');
		    		        	  	repCon.removeAttr('disabled');
		    		        	  	repCon.removeAttr('readonly');
		    		        	  	repBtn.css('display', 'block');
		    		        	  	rupBtn.css('display', 'none');
		    		        	 
		    		        	  	$('.reply_menu').hide();
		    		          });
		    		          
		    			      	/* 두번째 댓글 수정 시 완료 버튼 누르면 */
		    			       	$('.rConfirm').on("click", function(e) {
		    			      		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
		    			      		var rWriter = '${loginUser.userId}';
		    			      		var replyContent = $(this).parent().children()[1].children[0].value;
		    			      		
		    			      			$.ajax({
		    			      				url: "editReply.do",
		    			      				data: {
		    			      					rContent: replyContent,
		    			      					rNo: rNo,
		    			      					rWriter: rWriter,
		    			      					fNo : fNo
		    			      				},
		    			      				type: "post",
		    			      				async:false,
		    			      				success: function(data) {	// 성공 시: success, 실패 시: fail
		    			      					console.log(data);
		    			       				
//		    			      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
		    			       						//location.href="goMypage.do?mNo="+mNo;
		    			       						$('#replySub').remove();
		    			       						
		    			       						var input = "";
		    			       					 input +="<div id='replySub'>";
		    			       	              for(var i=0;i<data.replyList.length;i++){
		    			       		              input +="<div id='selectOne'>";	
		    			       		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
		    			       		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
		    			       	                  input +="<div id='replyList'>";
		    			       	                  input +="<ul id='re_list' class='list'>";
		    			       	                  if(data.replyList[i].mNo == mNo){
		    			       	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		    			       	                  } else {
		    			       	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		    			       	                  }
		    			       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
		    			       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
		    			       		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
		    			       		              if(data.replyList[i].mNo == mNo){
		    			       						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
		    			       		               }
		    			       					  input +="</ul>";
		    			       		              input +="</div>";
		    			       		              input +="<div class='reply_menu'>";

		    			       		              if(data.replyList[i].mNo == mNo){
		    			       			              input +="<div id='re_menu_list'>";
		    			       			              input +="<ul>";
		    			       			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
		    			       			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
		    			       			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
		    			       			              input +="</ul>";
		    			       			          	  input +="</div>";
		    			       		              } else{
		    			    			              input +="<div id='user_menu_list'>";
		    			    			              input +="<ul>";
		    			    		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
		    			    		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
		    			    			              input +="</ul>";
		    			    			          	  input +="</div>";
		    			    			    		  <!-- 댓글을 신고해보자! -->
		    			    			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
		    			    			    		  input +="<div id='reply_report_con'>";
		    			    				    	  input +="<p>신고사유</p>";
		    			    				    	  input +="<select id='reply_reportType' class='selectRtype'>";
		    			    				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
		    			    					      input +="<option value='insult'>욕설</option>";
		    			    					      input +="<option value='ad'>광고</option>";
		    			    					      input +="<option value='spam'>도배</option>";
		    			    					      input +="</select>";   
		    			    					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
		    			    					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
		    			    					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
		    			    					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
		    			    					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
		    			    					      input +="</div>";
		    			    					      input +="</div>";
		    			       		              }
		    			                          input +="</div>";
		    			                          input +="</div>";
		    			       	              }
		    			       	                  input +="</div>"; 
		    			       	                  
		    			       	                  $('#replyEditCont').append(input);
		    			       	                  
		    			       	                  
		    			       	      	        $('.feed_delete').click(function() {
		    			       	      	            $(".pop_feed").hide();
		    			       	      	        });
		    			       	      	        
		    			       		      	      $('#feed_menu').click(function() {
		    			       		                  $('.pop_menu').show();
		    			       			          }); 
		    			       			      	
		    			       			          $('.close').on('click', function(){
		    			       			              $('.pop_menu').hide();
		    			       			          });
		    			       			          
		    			       	 		          $('.rUpBtn').on("click", function(e){
		    			       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
		    			       			              $(replyMenu).show();
		    			       			          }); 
		    			       			          $('.rClose').on("click", function(){
		    			       			              $('.reply_menu').hide();
		    			       			          });
		    			       			          
		    			       			          $('.cancel').on("click", function(){
		    			       			              $('.feed_report').hide();
		    			       			          });
		    			       			          
		    			       			          $('.cancel').on("click", function(){
		    			       			              $('.reply_report').hide();
		    			       			          });
		    			       			          
		    			       			  		// 댓글 삭제 시
		    			       			  		$('.rDelete').on("click", function(e) {
		    			       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
		    			       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
		    			       						var rWriter = '${loginUser.userId}';
		    			       						var none = $(this.parentElement).parents("div#replySub").children.length;
		    			       						
		    			       						$.ajax({
		    			       							url: "deleteReply.do",
		    			       							data: {rNo: rNo},
		    			       							type: "post",
		    			       							success: function(data) {	// 성공 시: success, 실패 시: fail
		    			       				  				if(data == "success") {
//		    			       									$(ul).css('display', 'none');
		    			       									$('.rNum').css('display', 'none');
		    			       									location.href="goMypage.do?mNo="+mNo;
		    			       								}
		    			       							}, error: function() {
		    			       								console.log("전송 실패");
		    			       							}
		    			       						});
		    			       						
		    			       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
		    			       						if(none == 0) {
		    			       							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
		    			       						}
		    			       						
		    			       						confirm("댓글을 삭제하시겠습니까?");
		    			       			  		});
		    			       			          
		    			       			          // text-area resize
		    			       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
		    			       			      		var offset = this.offsetHeight - this.clientHeight;
		    			       			      		var resizeTextarea = function(el) {
		    			       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
		    			       			      		};
		    			       			      		$(this).on('keyup input', function() {
		    			       			      		 resizeTextarea(this);
		    			       			      		}).removeAttr('data-autoresize');
		    			       			      	});
		    			       			          
		    			    		  		 	/* 댓글 신고하기*/
		    			    		  		 	// 1. 신고하기 버튼 이벤트
		    			    		  		 	$(document).on("click","#rReport",function(){
		    			    		  		 		$(".reply_report").css("display","block");
		    			    		  		 		// 2.리플 번호 불러오기
		    			    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
		    			    		  		 		
		    			    		  			 	// 3. 댓글 신고하기
		    			    		  			 	$(document).on("click",'.reply_submit',function(){
		    			    		  			 		var text =$(this).prev().prev().prev().val();
		    			    		  			 		
		    			    		  			 		console.log(text);
		    			    		  		 			console.log(targetrNo);
		    			    		  			 		console.log($("#reply_reportType").val());
		    			    		  			 		
		    			    		  			 		if(text == ""){
		    			    		  						alert('신고 사유를 입력해 주세요.')
		    			    		  					}else{
		    			    		  						
		    			    		  						$.ajax({
		    			    		  							url:'reportRInsert.do',
		    			    		  							data:{
		    			    		  								reportType : $("#reply_reportType").val(),
		    			    		  								replyType : "reply",
		    			    		  								content : text,
		    			    		  								targetrNo:targetrNo
		    			    		  							},
		    			    		  							success: function(){
		    			    		  								alert('신고 완료');
		    			    		  								$('.reply_menu').hide();
		    			    		  					      		$('.reply_report').hide();
		    			    		  							},error:function(){
		    			    		  								alert('신고 실패!');
		    			    		  							}
		    			    		  						});
		    			    		  						
		    			    		  					};	
		    			    		  			 	});
		    			    		  		 	});
		    			    		         	 
		    			    		      	   	$(".cancel2").on("click",function(e){
		    			    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
		    			    		      	   		$(feedReport).css('display', 'none');
		    			    		      			$(".selectRtype").css("display", "inline-block");
		    			    		      	   		$(".sendreport").css("display", "none");
		    			    		      	   	});
		    			    		      	   	
		    			    		      	   	$(".Rtype").on("click",function(e){
		    			    		      	   		$(".selectRtype").css("display", "none");
		    			    		      	   		$(".sendreport").css("display", "block");
		    			    		      	   	});
		    			    		          
		    			    		          /* 댓글 수정시 텍스트창 변경 */
		    			    		          $('.rEdit').on("click", function(e) {
		    			    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
		    			    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
		    			    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

		    			    		      			repCon.css('border', '1px solid #555555');
		    			    		        	  	repCon.removeAttr('disabled');
		    			    		        	  	repCon.removeAttr('readonly');
		    			    		        	  	repBtn.css('display', 'block');
		    			    		        	  	rupBtn.css('display', 'none');
		    			    		        	 
		    			    		        	  	$('.reply_menu').hide();
		    			    		          });
		    			    		          
		    			      				}, error: function() {
		    			      					console.log("전송 실패");
		    			      				}
		    			      			});
		    			      			
		    			      		confirm("댓글을 수정하시겠습니까?");
		    			      	});
		    			      	/*두번째끝*/
		      					
		      				}, error: function() {
		      					console.log("전송 실패");
		      				}
		      			});
		      			
		      		confirm("댓글을 수정하시겠습니까?");
		      	});
		          
		  		// 댓글 삭제 시
		  		$('.rDelete').on("click", function(e) {
		  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
					var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
					var rWriter = '${loginUser.userId}';
					var none = $(this.parentElement).parents("div#replySub").children.length;
					
					$.ajax({
						url: "deleteReply.do",
						data: {rNo: rNo},
						type: "post",
						success: function(data) {	// 성공 시: success, 실패 시: fail
			  				if(data == "success") {
//								$(ul).css('display', 'none');
								$('.rNum').css('display', 'none');
								location.href="goMypage.do?mNo="+mNo;
							}
						}, error: function() {
							console.log("전송 실패");
						}
					});
					
					// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
					if(none == 0) {
						$(this.parentElement).parents("div#replySub").css('display', 'none');
					}
					
					confirm("댓글을 삭제하시겠습니까?");
		  		});
		          
		          // text-area resize
		      	$.each(jQuery('textarea[data-autoresize]'), function() {
		      		var offset = this.offsetHeight - this.clientHeight;
		      		var resizeTextarea = function(el) {
		      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
		      		};
		      		$(this).on('keyup input', function() {
		      		 resizeTextarea(this);
		      		}).removeAttr('data-autoresize');
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
    function nextBtn(index){
    	
	  			//size = $(this).nextAll().children('li').length;
	  			console.log(index);
	  			
	  			if( size > 1){
	  				idx1 = (idx + 1) % size;
	  				$(this).nextAll().children('li:hidden').css("left","633px");
	  				$(this).nextAll().children('li:eq('+idx+')').animate({left:"-=633px"},500, function(){
	  					$(this).css("display","none").css("left","633px");
	  				});
	  				$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"-=633px"},500);
	  				idx = idx1;
	  			}
    }

    $('.pb2').mouseover(function() {
        $(this).css({'background' : '#daf4eda1'});
    }).mouseleave(function() {
        $(this).css({'background' : 'none'});
    }).click(function() {
        $(".pop_feed").show();
    });
    

    
    /*댓글 등록*/
    function applyReply(fNo){
    	console.log(fNo);
    	var rContent = $('.rContent').val();
		var rfNo = fNo;
		var rWriter = '${loginUser.userId}';
		var mNo = $('#mNo').val();
		
		var ok = confirm("댓글을 등록하시겠습니까?");
     	console.log(ok);
     	if(ok){
 		
     	$.ajax({
			url: "addReply.do",
			data: {
				rContent: rContent,
				rfNo: rfNo,
				rWriter: rWriter,
				mNo: mNo,
				fNo : fNo
			},
			type: "post",
			async:false,
			success: function(data) {	// 성공 시: success, 실패 시: fail
					var refNo = fNo;
					var reWriter = '${loginUser.userId}';
					var mNo = $('#mNo').val();
			    	sendAlram("상관없음",reWriter,"reply",refNo);
					$('.rContent').val("");	// 등록 시에 사용한 댓글 내용 초기화
					//location.href="goMypage.do?mNo="+mNo;
					$('#replySub').remove();
					
						var input = "";
      					 input +="<div id='replySub'>";
      	              for(var i=0;i<data.replyList.length;i++){
      		              input +="<div id='selectOne'>";	
      		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
      		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
      	                  input +="<div id='replyList'>";
      	                  input +="<ul id='re_list' class='list'>";
      	                  if(data.replyList[i].mNo == mNo){
      	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
      	                  } else {
      	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
      	                  }
      	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
      		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
      		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
      		              if(data.replyList[i].mNo == mNo){
      						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
      		               }
      					  input +="</ul>";
      		              input +="</div>";
      		              input +="<div class='reply_menu'>";

      		              if(data.replyList[i].mNo == mNo){
      			              input +="<div id='re_menu_list'>";
      			              input +="<ul>";
      			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
      			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
      			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
      			              input +="</ul>";
      			          	  input +="</div>";
      		              } else{
   			              input +="<div id='user_menu_list'>";
   			              input +="<ul>";
   		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
   		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
   			              input +="</ul>";
   			          	  input +="</div>";
   			    		  <!-- 댓글을 신고해보자! -->
   			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
   			    		  input +="<div id='reply_report_con'>";
   				    	  input +="<p>신고사유</p>";
   				    	  input +="<select id='reply_reportType' class='selectRtype'>";
   				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
   					      input +="<option value='insult'>욕설</option>";
   					      input +="<option value='ad'>광고</option>";
   					      input +="<option value='spam'>도배</option>";
   					      input +="</select>";   
   					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
   					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
   					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
   					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
   					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
   					      input +="</div>";
   					      input +="</div>";
      		              }
                         input +="</div>";
                         input +="</div>";
      	              }
      	                  input +="</div>"; 
      	                  
      	                  $('#replyEditCont').append(input);
      	                  
	       	      	        $('.feed_delete').click(function() {
	       	      	            $(".pop_feed").hide();
	       	      	        });
	       	      	        
	       		      	      $('#feed_menu').click(function() {
	       		                  $('.pop_menu').show();
	       			          }); 
	       			      	
	       			          $('.close').on('click', function(){
	       			              $('.pop_menu').hide();
	       			          });
	       			          
	       	 		          $('.rUpBtn').on("click", function(e){
	       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
	       			              $(replyMenu).show();
	       			          }); 
	       			          $('.rClose').on("click", function(){
	       			              $('.reply_menu').hide();
	       			          });
	       			          
	       			          $('.cancel').on("click", function(){
	       			              $('.feed_report').hide();
	       			          });
	       			          
	       			          $('.cancel').on("click", function(){
	       			              $('.reply_report').hide();
	       			          });
	       			          
	       			  		// 댓글 삭제 시
	       			  		$('.rDelete').on("click", function(e) {
	       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
	       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
	       						var rWriter = '${loginUser.userId}';
	       						var none = $(this.parentElement).parents("div#replySub").children.length;
	       						
	       						$.ajax({
	       							url: "deleteReply.do",
	       							data: {rNo: rNo},
	       							type: "post",
	       							success: function(data) {	// 성공 시: success, 실패 시: fail
	       				  				if(data == "success") {
//	       									$(ul).css('display', 'none');
	       									$('.rNum').css('display', 'none');
	       									location.href="goMypage.do?mNo="+mNo;
	       								}
	       							}, error: function() {
	       								console.log("전송 실패");
	       							}
	       						});
	       						
	       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
	       						if(none == 0) {
	       							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
	       						}
	       						
	       						confirm("댓글을 삭제하시겠습니까?");
	       			  		});
	       			          
	       			          // text-area resize
	       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
	       			      		var offset = this.offsetHeight - this.clientHeight;
	       			      		var resizeTextarea = function(el) {
	       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
	       			      		};
	       			      		$(this).on('keyup input', function() {
	       			      		 resizeTextarea(this);
	       			      		}).removeAttr('data-autoresize');
	       			      	});
	       			          
	    		  		 	/* 댓글 신고하기*/
	    		  		 	// 1. 신고하기 버튼 이벤트
	    		  		 	$(document).on("click","#rReport",function(){
	    		  		 		$(".reply_report").css("display","block");
	    		  		 		// 2.리플 번호 불러오기
	    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
	    		  		 		
	    		  			 	// 3. 댓글 신고하기
	    		  			 	$(document).on("click",'.reply_submit',function(){
	    		  			 		var text =$(this).prev().prev().prev().val();
	    		  			 		
	    		  			 		console.log(text);
	    		  		 			console.log(targetrNo);
	    		  			 		console.log($("#reply_reportType").val());
	    		  			 		
	    		  			 		if(text == ""){
	    		  						alert('신고 사유를 입력해 주세요.')
	    		  					}else{
	    		  						
	    		  						$.ajax({
	    		  							url:'reportRInsert.do',
	    		  							data:{
	    		  								reportType : $("#reply_reportType").val(),
	    		  								replyType : "reply",
	    		  								content : text,
	    		  								targetrNo:targetrNo
	    		  							},
	    		  							success: function(){
	    		  								alert('신고 완료');
	    		  								$('.reply_menu').hide();
	    		  					      		$('.reply_report').hide();
	    		  							},error:function(){
	    		  								alert('신고 실패!');
	    		  							}
	    		  						});
	    		  						
	    		  					};	
	    		  			 	});
	    		  		 	});
	    		         	 
	    		      	   	$(".cancel2").on("click",function(e){
	    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
	    		      	   		$(feedReport).css('display', 'none');
	    		      			$(".selectRtype").css("display", "inline-block");
	    		      	   		$(".sendreport").css("display", "none");
	    		      	   	});
	    		      	   	
	    		      	   	$(".Rtype").on("click",function(e){
	    		      	   		$(".selectRtype").css("display", "none");
	    		      	   		$(".sendreport").css("display", "block");
	    		      	   	});
	    		          
	    		          /* 댓글 수정시 텍스트창 변경 */
	    		          $('.rEdit').on("click", function(e) {
	    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
	    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
	    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

	    		      			repCon.css('border', '1px solid #555555');
	    		        	  	repCon.removeAttr('disabled');
	    		        	  	repCon.removeAttr('readonly');
	    		        	  	repBtn.css('display', 'block');
	    		        	  	rupBtn.css('display', 'none');
	    		        	 
	    		        	  	$('.reply_menu').hide();
	    		          });
	    		          
	    			      	/* 두번째 댓글 수정 시 완료 버튼 누르면 */
	    			       	$('.rConfirm').on("click", function(e) {
	    			      		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
	    			      		var rWriter = '${loginUser.userId}';
	    			      		var replyContent = $(this).parent().children()[1].children[0].value;
	    			      		
	    			      			$.ajax({
	    			      				url: "editReply.do",
	    			      				data: {
	    			      					rContent: replyContent,
	    			      					rNo: rNo,
	    			      					rWriter: rWriter,
	    			      					fNo : fNo
	    			      				},
	    			      				type: "post",
	    			      				async:false,
	    			      				success: function(data) {	// 성공 시: success, 실패 시: fail
	    			      					console.log(data);
	    			       				
//	    			      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
	    			       						//location.href="goMypage.do?mNo="+mNo;
	    			       						$('#replySub').remove();
	    			       						
	    			       						var input = "";
	    			       					 input +="<div id='replySub'>";
	    			       	              for(var i=0;i<data.replyList.length;i++){
	    			       		              input +="<div id='selectOne'>";	
	    			       		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
	    			       		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
	    			       	                  input +="<div id='replyList'>";
	    			       	                  input +="<ul id='re_list' class='list'>";
	    			       	                  if(data.replyList[i].mNo == mNo){
	    			       	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	    			       	                  } else {
	    			       	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	    			       	                  }
	    			       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
	    			       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
	    			       		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
	    			       		              if(data.replyList[i].mNo == mNo){
	    			       						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
	    			       		               }
	    			       					  input +="</ul>";
	    			       		              input +="</div>";
	    			       		              input +="<div class='reply_menu'>";

	    			       		              if(data.replyList[i].mNo == mNo){
	    			       			              input +="<div id='re_menu_list'>";
	    			       			              input +="<ul>";
	    			       			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
	    			       			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
	    			       			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
	    			       			              input +="</ul>";
	    			       			          	  input +="</div>";
	    			       		              } else{
	    			    			              input +="<div id='user_menu_list'>";
	    			    			              input +="<ul>";
	    			    		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
	    			    		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
	    			    			              input +="</ul>";
	    			    			          	  input +="</div>";
	    			    			    		  <!-- 댓글을 신고해보자! -->
	    			    			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
	    			    			    		  input +="<div id='reply_report_con'>";
	    			    				    	  input +="<p>신고사유</p>";
	    			    				    	  input +="<select id='reply_reportType' class='selectRtype'>";
	    			    				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
	    			    					      input +="<option value='insult'>욕설</option>";
	    			    					      input +="<option value='ad'>광고</option>";
	    			    					      input +="<option value='spam'>도배</option>";
	    			    					      input +="</select>";   
	    			    					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
	    			    					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
	    			    					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
	    			    					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
	    			    					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
	    			    					      input +="</div>";
	    			    					      input +="</div>";
	    			       		              }
	    			                          input +="</div>";
	    			                          input +="</div>";
	    			       	              }
	    			       	                  input +="</div>"; 
	    			       	                  
	    			       	                  $('#replyEditCont').append(input);
	    			       	                  
	    			       	                  
	    			       	      	        $('.feed_delete').click(function() {
	    			       	      	            $(".pop_feed").hide();
	    			       	      	        });
	    			       	      	        
	    			       		      	      $('#feed_menu').click(function() {
	    			       		                  $('.pop_menu').show();
	    			       			          }); 
	    			       			      	
	    			       			          $('.close').on('click', function(){
	    			       			              $('.pop_menu').hide();
	    			       			          });
	    			       			          
	    			       	 		          $('.rUpBtn').on("click", function(e){
	    			       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
	    			       			              $(replyMenu).show();
	    			       			          }); 
	    			       			          $('.rClose').on("click", function(){
	    			       			              $('.reply_menu').hide();
	    			       			          });
	    			       			          
	    			       			          $('.cancel').on("click", function(){
	    			       			              $('.feed_report').hide();
	    			       			          });
	    			       			          
	    			       			          $('.cancel').on("click", function(){
	    			       			              $('.reply_report').hide();
	    			       			          });
	    			       			          
	    			       			  		// 댓글 삭제 시
	    			       			  		$('.rDelete').on("click", function(e) {
	    			       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
	    			       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
	    			       						var rWriter = '${loginUser.userId}';
	    			       						var none = $(this.parentElement).parents("div#replySub").children.length;
	    			       						
	    			       						$.ajax({
	    			       							url: "deleteReply.do",
	    			       							data: {rNo: rNo},
	    			       							type: "post",
	    			       							success: function(data) {	// 성공 시: success, 실패 시: fail
	    			       				  				if(data == "success") {
//	    			       									$(ul).css('display', 'none');
	    			       									$('.rNum').css('display', 'none');
	    			       									location.href="goMypage.do?mNo="+mNo;
	    			       								}
	    			       							}, error: function() {
	    			       								console.log("전송 실패");
	    			       							}
	    			       						});
	    			       						
	    			       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
	    			       						if(none == 0) {
	    			       							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
	    			       						}
	    			       						
	    			       						confirm("댓글을 삭제하시겠습니까?");
	    			       			  		});
	    			       			          
	    			       			          // text-area resize
	    			       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
	    			       			      		var offset = this.offsetHeight - this.clientHeight;
	    			       			      		var resizeTextarea = function(el) {
	    			       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
	    			       			      		};
	    			       			      		$(this).on('keyup input', function() {
	    			       			      		 resizeTextarea(this);
	    			       			      		}).removeAttr('data-autoresize');
	    			       			      	});
	    			       			          
	    			    		  		 	/* 댓글 신고하기*/
	    			    		  		 	// 1. 신고하기 버튼 이벤트
	    			    		  		 	$(document).on("click","#rReport",function(){
	    			    		  		 		$(".reply_report").css("display","block");
	    			    		  		 		// 2.리플 번호 불러오기
	    			    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
	    			    		  		 		
	    			    		  			 	// 3. 댓글 신고하기
	    			    		  			 	$(document).on("click",'.reply_submit',function(){
	    			    		  			 		var text =$(this).prev().prev().prev().val();
	    			    		  			 		
	    			    		  			 		console.log(text);
	    			    		  		 			console.log(targetrNo);
	    			    		  			 		console.log($("#reply_reportType").val());
	    			    		  			 		
	    			    		  			 		if(text == ""){
	    			    		  						alert('신고 사유를 입력해 주세요.')
	    			    		  					}else{
	    			    		  						
	    			    		  						$.ajax({
	    			    		  							url:'reportRInsert.do',
	    			    		  							data:{
	    			    		  								reportType : $("#reply_reportType").val(),
	    			    		  								replyType : "reply",
	    			    		  								content : text,
	    			    		  								targetrNo:targetrNo
	    			    		  							},
	    			    		  							success: function(){
	    			    		  								alert('신고 완료');
	    			    		  								$('.reply_menu').hide();
	    			    		  					      		$('.reply_report').hide();
	    			    		  							},error:function(){
	    			    		  								alert('신고 실패!');
	    			    		  							}
	    			    		  						});
	    			    		  						
	    			    		  					};	
	    			    		  			 	});
	    			    		  		 	});
	    			    		         	 
	    			    		      	   	$(".cancel2").on("click",function(e){
	    			    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
	    			    		      	   		$(feedReport).css('display', 'none');
	    			    		      			$(".selectRtype").css("display", "inline-block");
	    			    		      	   		$(".sendreport").css("display", "none");
	    			    		      	   	});
	    			    		      	   	
	    			    		      	   	$(".Rtype").on("click",function(e){
	    			    		      	   		$(".selectRtype").css("display", "none");
	    			    		      	   		$(".sendreport").css("display", "block");
	    			    		      	   	});
	    			    		          
	    			    		          /* 댓글 수정시 텍스트창 변경 */
	    			    		          $('.rEdit').on("click", function(e) {
	    			    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
	    			    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
	    			    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

	    			    		      			repCon.css('border', '1px solid #555555');
	    			    		        	  	repCon.removeAttr('disabled');
	    			    		        	  	repCon.removeAttr('readonly');
	    			    		        	  	repBtn.css('display', 'block');
	    			    		        	  	rupBtn.css('display', 'none');
	    			    		        	 
	    			    		        	  	$('.reply_menu').hide();
	    			    		          });
	    			    		          
	    			      				}, error: function() {
	    			      					console.log("전송 실패");
	    			      				}
	    			      			});
	    			      			
	    			      		confirm("댓글을 수정하시겠습니까?");
	    			      	});
	    			      	/*두번째끝*/
			}, error: function() {
				console.log("전송 실패");
			}
		}); 
     	
     	} else {
     		
     		$('.rContent').val("");	// 등록 시에 사용한 댓글 내용 초기화
     	}
    }
    
	  $('.rClose').on("click", function(){
	      $('.reply_menu').hide();
	  });
	  $('.deleteMyPost').on('click', function () {
	  	confirm('이 포스트를 정말 삭제하시겠습니까?');
	  });
	  
    
    function likeClick(likeStatu){
    	var likeid = likeStatu.getAttribute('id');

    	console.log(likeStatu);
    	
		// 좋아요 알람
			console.log("likeicon 클릭");
			var toId = $('.toId').val();
			var toNo = $('.toNo').val();   
			var fromId = '${loginUser.userId}';
			
			if(likeid == 'likeIcon'){
				
				$.ajax({
					url: "likeCount2.do",
					data : {fNo : toNo,
							type : 'up',
							userId : 'null'},
					success : function(data){
					//	console.log(data + "좋아요 카운트 up 성공");
						
						
						$('#likeIcon').attr('src','/spring/resources/icons/heart_red.png');
						$('#likeIcon').attr('id','liked');				
						sendAlram("상관없음",toId,"like",toNo);
						var test = $('.fLikeCnt').val();
						test *= 1;
						test = test + 1;
						$('.likeCnt').text(test+"개");
						$('.fLikeCnt').val(test);
						
					},
		             error:function(){
		                 alert('좋아요 실패!');
		            } 
				});
			}else{
				$.ajax({
					url: "likeCount2.do",
					data : {fNo : toNo,
							type : 'down',
							userId : fromId},
					success : function(data){
					//	console.log(data + "좋아요 카운트 down 성공");
						$('#liked').attr('src','/spring/resources/icons/heart.png');
						$('#liked').attr('id','likeIcon');
						var test = $('.fLikeCnt').val();
						test *= 1;
						test = test - 1;
						$('.likeCnt').text(test+"개");
						$('.fLikeCnt').val(test);
					},
		             error:function(){
		                 alert('좋아요 실패!');
		            } 
				});
			}
		
    }
    
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
    
    /************ 팔로우 언팔로우 script ************/
    $('#follow_btn').click(function() {
        $(this).hide();
        $('#followCancle_btn').show();
    });
    $('#followCancle_btn').click(function() {
        $(this).hide();
        $('#follow_btn').show();
    });
    /************ 게시글, 보관함, 내 그룹 전환 시 script ************/
	//게시글 클릭시
    $('.feedPost_btn').click(function() {
        $(this).css({'border-bottom' : '2px solid #47c6a3'});
        $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
        $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
        $('.post').show();
        $('.storagebox').hide();
        $('.fstorageBox_folder').hide();
        $('.group').hide();
        $('.sbpost').hide();
    });
    //보관함 클릭시
    $('.feedStorageBox_btn').click(function() {
        $(this).css({'border-bottom' : '2px solid #47c6a3'});
        $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
        $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
        $('.post').hide();
        $('.storagebox').show();
        $('.group').hide();
        $('.storageBox_subBtn4').hide();
		$('.storageBox_subBtn5').hide();
        $('.fstorageBox_folder').show();
        $('.sbpost').hide();
        
    });
	//그룹
    $('.feedMyGroup_btn').click(function() {
        $(this).css({'border-bottom' : '2px solid #47c6a3'});
        $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
        $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
        $('.post').hide();
        $('.storagebox').hide();
        $('.group').show();
        $('.fstorageBox_folder').hide();
        $('.sbpost').hide();
    }); 
    /********* 보관함 수정 및 삭제 script ************/
    /*보관함 만들기*/
     $('.storageBox_subBtn1').click(function() {
        var mNo = $('#mNo').val();
     $.ajax({
        url:"insertBox.do",
        dataType:"json",
        data:{mNo: mNo},
        type:"post",
        success:function(data){
           location.href ='goMypage.do?mNo=${ loginUser.mNo }&type=1';
           alert("보관함을 생성하였습니다");
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
    /*그룹 탈퇴 이동*/
    $('.leaveBtn').click(function(){
    });
    
    /*보관함 이름 수정*/
    $('.storageBox_subBtn2').click(function() {
        $('.folder_default').hide();
        $('.folder_correct').show();
        $('.folder_delete').hide();
        $('.storageBox_subBtn3').hide();
        $('.storageBox_subBtn4').show();
 		
        $('.sbNameBox').css('border','1px solid #555555');
		$('.sbNameBox').removeAttr('readonly');
    });
    
	/*수정 완료 */
	$('.storageBox_subBtn4').click(function() {
	
	    $('.folder_default').show();
	    $('.folder_correct').hide();
	    $('.folder_delete').hide();
	
	    $('.storageBox_subBtn4').hide();
	    $('.storageBox_subBtn2').show();
	    $('.storageBox_subBtn3').show();
	    
		$('.sbNameBox').css('border','none');
		$('.sbNameBox').attr('readonly', 'readonly');
		//맵객체로 만들것
		var sbBoxMap = new Map();
		for(var i =0; i < $('.sbNo').length; i++ ){
			sbBoxMap.set($('.sbNo')[i].value,$('.sbNameBox')[i].value);
		}
		
		sbBoxMap.set('mno', ${ loginUser.mNo });
		//맵 만들어졌는지 확인용
		console.log(sbBoxMap);
		
		//수정완료 에이작스
		$.ajax({
			url:'updateBox.do',
			dataType:'json',
			type:'post',
			data:JSON.stringify(Object.fromEntries(sbBoxMap)),
			contentType :'application/json; charset=UTF-8',
	        success: function(data) {
	            alert('수정 완료되었습니다');
	        },
	        error: function(request) {
	        	 alert('에러');
	        }
		});
		
	});
    /* 보관함 삭제 */
    $('.storageBox_subBtn3').click(function() {  	
    	$('.storageBox_subBtn3').hide();
    	$('.storageBox_subBtn4').hide();
    	$('.storageBox_subBtn5').show();
    	$('.sbBoxCheck').css('display','block');
    });
   
    /*보관함 삭제 완료..*/
    $('.storageBox_subBtn5').click(function(){
    	$('.sbBoxCheck').css('display','none');
    	$('.storageBox_subBtn3').show();
    	$('.storageBox_subBtn4').show();
        var sbBoxMap = new Map();
        var j = 0;		
        for(var i =0; i < $('.sbBoxCheck').length; i++ ){
			if($('.sbBoxCheck')[i].checked == true){
				sbBoxMap.set(j,$('.sbBoxCheck')[i].value);
				j++;
			}
		}
		if(j > 0 ){	
		sbBoxMap.set('mno',${ loginUser.mNo });
		//맵 만들어졌는지 확인용
		//console.log(sbBoxMap);
         $.ajax({
            url:"deleteBox.do",
        	dataType:'json',
			type:'post',
			data:JSON.stringify(Object.fromEntries(sbBoxMap)),
			contentType :'application/json; charset=UTF-8',
	        success:function(data){
        		location.href ='goMypage.do?mNo=${ loginUser.mNo }&type=1';
                alert('보관함이 '+j+'개 삭제되었습니다');
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
		}
		
    });

	//보관함 눌러서 내가 보관한 피드 볼 때
	$('.sbButton').click(function() {
		var sbNo = $(this).attr("id");
		var mNo = $('#mNo').val();
		if(sbNo > 0){
			$.ajax({
				url:"goStorageBox",
	        	dataType:'json',
				type:'post',
				data:{mno: mNo,
					sbno:sbNo},
		        success:function(data){
					if(data.fList != null){
						var input="";

						for(var i=0; i < data.fList.length; i++){
							if(data.fList[i].thumbnail != null){	
								input += "<div class='postbox sbpost' id='"+data.fList[i].fno+"'  name='postbox'>";	
								input += "<img src='/spring/resources/pUploadFiles/"+data.fList[i].thumbnail+"' onclick='goDetail("+data.fList[i].fno+","+data.fList[i].mno+","+sbNo+")' class='postbox'>";	
								input += "</div>";		
							}else{	
								input += "<div class='postbox sbpost' onclick='goDetail("+data.fList[i].fno+","+data.fList[i].mno+","+sbNo+")'>";
								input += "<text>"+data.fList[i].fcontent+"</text>";	
								input += "</div>";
							}
						}

	                    $("#myPage_feed").append(input);
	                    $(".fstorageBox_folder").hide();
	                    $("#storagebox").hide();
					}else{
						alert(data.msg);
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
		}else{
			alert('보관함을 불러올 수 없습니다');
		}
	});

	 function deleteStorageFeed(fno,type) {
		 //alert(type);
		 $.ajax({
			 url:"deleteStorageFeed",
        	dataType:'json',
			type:'post',
			data:{fno: fno
				,sbno:type
				,mno: ${ loginUser.mNo }}
			,success:function(data){
				 alert(data.msg);
				 $(".pop_feed").hide();
				location.href ='goMypage.do?mNo=${ loginUser.mNo }&type=1';
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
	}
    /************* 팝업 메뉴 script *************/
    $('#details_btn').on("click", function(){
        $('.myFeed_popup_others').show();
    });
    $('#close').on('click', function(){
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
	/*@태그 이벤트*/
    function goUser(){
    	var id = $(event.target).attr('id')
    	var mno = ${ loginUser.mNo };
    	location.href ='goUserpage.do?userId='+id+'&mNo='+mno;
    }
    /*#태그 이벤트*/
    function goTag(htag) {
    	var tag = $(htag).text();
    	location.href="search.do?type=tag&key="+tag.substr(1)+"&mNo="+${ loginUser.mNo };
	}
    </script>
</body>
</html>