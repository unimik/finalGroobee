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
    };
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
                            <img src="resources/icons/pro_default.png" alt="" id="profile_img">${ empty loginUser.mRenameImage }&nbsp;&nbsp;&nbsp;
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
                                <select style=>
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
                        <div id="interests">
                             ${ loginUser.interestes }
                        </div>
                    </div>
                    
            <!-- 내가 올린 피드 목록 -->
                <div id="myPage_feedList">
                    <table id="myPage_feed">
                        <tr>
                            <th><div type="button" class="feedPost_btn">게시글</div></th>
                            <th><div type="button" class="feedStorageBox_btn">보관함</div></th>
                            <th><div type="button" class="feedMyGroup_btn">내 그룹</div></th>
                        </tr>

                    <!-- 게시글 -->
                        <%! int i = 0; %>
                        <c:forEach var="feedlist" items="${ feedList }">
                        <% if (i%3==0){ %>
                        <tr class="post">
                        <%} %>
                            <c:choose>
                                 <c:when test="${!empty feedlist.thumbnail }">
                                     <td class="postbox" name="postbox"><img src="<%=request.getContextPath()%>/resources/pUploadFiles/${ feedlist.thumbnail }" type="button" id="pb1"></td>
                                 </c:when>
                                 <c:otherwise>
                                     <td class="postbox" name="postbox">
                                         <div type="button" id="pb2">
                                             <text>${ feedlist.fContent }</text>
                                         </div>
                                     </td>
                                 </c:otherwise>
                              </c:choose>
                          <% if (i%3==2){ %>
	                      </tr>
	                      <%} i++; %>
                          </c:forEach>

                    <!-- 포스트박스 클릭 시 -->
                        <div class="pop_feed">
                            <div class="feed_delete">
                                <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                            </div>
                            <div id="writer_submenu">
                                <img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
                                <div id="user_time">
                                    <p id="feed_id">user01</p>
                                    <h6>1시간 전</h6>
                                </div>  
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" id="feed_menu">
                            </div>
                            <!-- 다른 회원 글 볼 때 피드 메뉴 -->
                            <div class="pop_menu">
                                <div id="feed_menu_list">
                                    <ul>
                                    <li><a id="feed_report_btn">신고</a></li> 
                                    <li><a>공유하기</a></li> 
                                    <li><a>보관함</a></li> 
                                    <li><a id="close">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- 내가 쓴 글 볼 때 피드 메뉴
                                <div class="pop_Mymenu">
                                    <div id="feed_Mymenu_list">
                                        <ul>
                                        <li><a id="feed_menu1_btn">수정</a></li> 
                                        <li><a>삭제</a></li> 
                                        <li><a id="close">취소</a></li>
                                        </ul>
                                    </div>
                                </div>
                            -->
                            <div class="feed_report">
                                <div id="feed_report_con">
                                    <p>신고 사유</p>
                                    <select style=>
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
                            <div id="con">
                                <div id="feed_content">
                                    <img src="<%=request.getContextPath()%>/resources/images/IMG_7572.JPG" alt="" id="input_img">
                                    <div id="heart_reply">
                                        <img src="<%=request.getContextPath()%>/resources/icons/heart.png" type="button" alt="" id="likeIcon">
                                        <img src="<%=request.getContextPath()%>/resources/icons/bubble.png" type="button" alt="" id="replyIcon">
                                    </div>
                                    <p id="text">맛있게 먹었던 피짜~~~!</p>
                                    <ul id="tag">
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                    </ul>
                                </div>
                                <div id="replyArea">
                                    <div id="replyList">
                                        <ul id="re_list">
                                            <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
                                            <li><p id="replyCon">맛있겠다... 여기 어디인가요?? 대박 정보 좀....</p></li>
                                            <li><p id="time">1시간 전</p></li>
                                            <li><img src="<%=request.getContextPath()%>/resources/icons/replyMenu.png" type="button" alt="" id="updateBtn"></li>
                                        </ul>
                                    </div>
                                    <!-- 남이 단 댓글 볼 때 댓글 메뉴 -->
                                    <div class="reply_menu">
                                        <div id="re_menu_list">
                                            <ul>
                                                <li><a>댓글 수정</a></li>
                                                <li><a>댓글 삭제</a></li>
                                                <li><a id="re_close">취소</a></li>
                                            </ul>
                                        </div>
                                    </div>
        
                                    <div id="reply">
                                        <input type="text" id="textArea" name="textArea">
                                        <input type="button" id="replyBtn" name="replyBtn" value="등록">
                                    </div>
                                </div> 
                            </div>
                        </div>

                    <!-- 포스트박스 클릭 시2 -->
                        <div class="pop_feed2">
                            <div class="feed_delete">
                                <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                            </div>
                            <div id="writer_submenu">
                                <img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
                                <div id="user_time">
                                    <p id="feed_id">user01</p>
                                    <h6>1시간 전</h6>
                                </div>  
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" id="feed_menu">
                            </div>
                            <!-- 다른 회원 글 볼 때 피드 메뉴 -->
                            <div class="pop_menu">
                                <div id="feed_menu_list">
                                    <ul>
                                    <li><a id="feed_report_btn">신고</a></li> 
                                    <li><a>공유하기</a></li> 
                                    <li><a>보관함</a></li> 
                                    <li><a id="close">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- 내가 쓴 글 볼 때 피드 메뉴
                                <div class="pop_Mymenu">
                                    <div id="feed_Mymenu_list">
                                        <ul>
                                        <li><a id="feed_menu1_btn">수정</a></li> 
                                        <li><a>삭제</a></li> 
                                        <li><a id="close">취소</a></li>
                                        </ul>
                                    </div>
                                </div>
                            -->
                            <div class="feed_report">
                                <div id="feed_report_con">
                                    <p>신고 사유</p>
                                    <select style=>
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
                            <div id="con">
                                <div id="feed_content">
                                    <!-- <img src="" alt="" id="input_img"> -->
                                    <div id="heart_reply">
                                        <img src="<%=request.getContextPath()%>/resources/icons/heart.png" type="button" alt="" id="likeIcon">
                                        <img src="<%=request.getContextPath()%>/resources/icons/bubble.png" type="button" alt="" id="replyIcon">
                                    </div>
                                    <p id="text">피자 먹고 싶당 치킨 먹고 싶당</p>
                                    <ul id="tag">
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                    </ul>
                                </div>
                                <div id="replyArea">
                                    <div id="replyList">
                                        <ul id="re_list">
                                            <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">pizza11</p></li>
                                            <li><p id="replyCon">당장 나와</p></li>
                                            <li><p id="time">1분 전</p></li>
                                            <li><img src="<%=request.getContextPath()%>/resources/icons/replyMenu.png" type="button" alt="" id="updateBtn"></li>
                                        </ul>
                                        <ul id="re_list">
                                            <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">honeybee</p></li>
                                            <li><p id="replyCon">다이어트 한다며......</p></li>
                                            <li><p id="time">39분 전</p></li>
                                            <li><img src="<%=request.getContextPath()%>/resources/icons/replyMenu.png" type="button" alt="" id="updateBtn"></li>
                                        </ul>
                                    </div>
                                    <!-- 남이 단 댓글 볼 때 댓글 메뉴 -->
                                    <div class="reply_menu">
                                        <div id="re_menu_list">
                                            <ul>
                                                <li><a>댓글 수정</a></li>
                                                <li><a>댓글 삭제</a></li>
                                                <li><a id="re_close">취소</a></li>
                                            </ul>
                                        </div>
                                    </div>
        
                                    <div id="reply">
                                        <input type="text" id="textArea" name="textArea">
                                        <input type="button" id="replyBtn" name="replyBtn" value="등록">
                                    </div>
                                </div> 
                            </div>
                        </div>
					<div class="pop_feed3">
					
					</div>
                    <!-- 보관함 -->
                      <tr class="storagebox" id="storagebox">
                            <td></td>
                            <td></td>
                            <input type="hidden" id="mNo" value="${ loginUser.mNo }"/>
                            <td id="storageBox" colspan="3">
                                <div id="sb_menu">
                                    <div type="button" class="storageBox_subBtn1"><img src="<%=request.getContextPath()%>/resources/icons/add.png"></div>
                                    <div type="button" class="storageBox_subBtn2"><img src="<%=request.getContextPath()%>/resources/icons/correct_folder.png"></div>
                                    <div type="button" class="storageBox_subBtn3"><img src="<%=request.getContextPath()%>/resources/icons/delete.png"></div>
                                    <div type="button" class="storageBox_subBtn4"><img src="<%=request.getContextPath()%>/resources/icons/check.png"></div>
                                    <div type="button" class="storageBox_subBtn5"><img src="<%=request.getContextPath()%>/resources/icons/check.png"></div>
                                </div>
                            </td>
                        </tr>
                        <%! int  j = 0; %>
                        <c:forEach var="sb" items="${ storageBoxList }">
                       	<% if (j%3 == 0){ %>
                    <tr class="storagebox">
                       	<%} %>
                            <!-- <div id="box">보관함새폴더생성</div>-->
                            <td class="fstorageBox_folder">
                            <img src="<%=request.getContextPath()%>/resources/icons/folder.png" class="sbButton" id="${ sb.sbNo }" type="button">
                            <label>
                            <input type="checkbox" class="sbBoxCheck" value="${ sb.sbNo }">
                            <input type="hidden" class="sbNo" value="${ sb.sbNo }">
                            <input type="text" class="sbNameBox"  value="${ sb.sbName }">
                            </label>                            
                            </td>
                   		 <% if (j%3==2){ %>
                        </tr>
                  		 <%} j++;%>
                         </c:forEach>

                        <!-- empty-space -->
                            <tr class="group">
                                <td class="empty-space" colspan="3"></td>
                            </tr>
                             
                        <!-- 내 그룹 목록 -->
                        <c:forEach var="groupList" items="${ groupList }">
                            <tr id="groupList" colspan="1" class="group">
                                <td class="groupImg" align="center">
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
                                </td>
                                <td class="groupInfo" colspan="3">
                                    <a href="${ gdetail }">
                                        <h3>${ groupList.gName }</h3>
                                    </a>
                                        <div>
                                            <div>
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
                                </td>
                            </tr>
                         </c:forEach>

                    </table>
                </div>
            </div>
        </div>
    </div>


    <script>
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
        $('#sbfeed').hide();
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
        $('#sbfeed').hide();
        
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
        $('#sbfeed').hide();
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
	    				var i = 0;
	    				var j = 0;
	    				for(var i=0; i < data.fList.length; i++){;	
	    					if(i == 0){
	    						input +="<tr>";
    							input +="<td><a><b>뒤로 </b></a></td>";
	    						input +="</tr>";
	    					}
	    				 		if (j%3==0){ 
	    				input +="<tr class='post' id='sbfeed'>";
	    						}
	    						if(data.fList[i].thumbnail != null){	
	    				input += "<td class='postbox' name='postbox'>";	
	    				input += "<img src='/spring/resources/pUploadFiles/"+data.fList[i].thumbnail+"' onclick='sbPop()'>";	
	    				input += "<input type='hidden' id='fNo' value="+data.fList[i].fno+"/>";	
	    				input += "</td>";		
	    						}else{	
	    				input += "<td class='postbox' name='postbox'>";	
	    				input += "<div type='button' id='pb2'>";
	    				input += "<text>"+data.fList[i].fcontent+"</text>";	
	    				input += "</div>";
	    				input += "</td>";
	    						}	
		    				if (j%3==2){ 
		    					input +="</tr>"; 	
		    				}
	    				j++; 
	    				}
	    				
	                    $("#myPage_feed").append(input);
	                    //$("#myPage_feed").html(input);
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
	//팝업창 띄울것....
	 function sbPop() {
		 alert('이제 팝업으로 게시글 불러와야하는데.. 이거 가능..?');
		 $('.pop_feed2').show();
	}
	/************ 포스트 박스 클릭 시 script ************/
	/* 이새끼 때문에 스크립트 안먹어서 일단 주석 처리..
    $('#pb1').click(function() {
        $(".pop_feed").show();
    });

    $('#pb2').mouseover(function() {
        $(this).css({'background' : '#daf4eda1'});
    }).mouseleave(function() {
        $(this).css({'background' : 'none'});
    }).click(function() {
        $(".pop_feed2").show();
    });

    $('.feed_delete').click(function() {
        $(".pop_feed2").hide();
        $(".pop_feed").hide();
    });

    $ajax.({
    	
    })
    */
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

    $('#updateBtn').on("click", function(){
        $('.reply_menu').show();
    });

    $('#re_close').on("click", function(){
        $('.reply_menu').hide();
    });
    </script>
</body>
</html>