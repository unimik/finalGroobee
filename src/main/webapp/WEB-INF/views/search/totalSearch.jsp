<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>totalSearch</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/totalSearch.css">
    <link rel="stylesheet" href="resources/css/home.css">
    <link rel="stylesheet" href="resources/css/chat.css">
    <link rel="stylesheet" href="resources/css/myAccount.css">
    <style>
    .post{height: 200px;}
    </style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	 <div id="searchArea">
                <!--계정/그룹 검색 결과-->
                <div id="search_account">
                    <!--계정-->
                    <div id="user">
                        <div id="title_user">
                            <p id="title"><b>계정</b></p>
                        </div>
                        <div id="con_user">
                        <c:choose>
	                        <c:when test="${empty mList}">
	         					<div id="nouser">계정이 존재하지 않습니다</div>
	         				</c:when>
	         				<c:otherwise>
	                        	<c:forEach var="m" items="${ mList }">
	                            <c:choose>
	                            <c:when test="${ empty m.mImage }">
		                            <div id="search_user" style=" cursor: pointer;" onclick="location.href='goUserpage.do?userId=${ m.userId }&mNo=${ loginUser.mNo }'">
		                                <img src="resources/images/IMG_7502.JPG" alt="" id="user_profile_img">
		                                <p id="search_id">${ m.userId }</p>
		                                <input type="hidden" id="mNo" name="mNo" value="${m.mNo} }"/>
		                                <input type="hidden" id="mStatus" name="mStatus" value="${m.mStatus} }"/>
		                            </div>
	                            </c:when>
	                            <c:otherwise>
	                            <div id="search_user" style=" cursor: pointer;" onclick="location.href='goUserpage.do?userId=${ m.userId }&mNo=${ loginUser.mNo }'">
	                                <img src="resources/memberProfileFiles/${ m.mRenameImage }" alt="" id="user_profile_img">
	                                <p id="search_id">${ m.userId }</p>
	                            </div>                            
	                            </c:otherwise>
	                            </c:choose>                            
	                            </c:forEach>
	                         </c:otherwise>
                         </c:choose>   
                        </div>
                    </div>
                     <script type="text/javascript">
                     function ClickUser(obj) {
                     	console.log("눌렀다")
	
						}
                     </script>
                    <!--그룹-->
                    <div id="group">
                        <div id="title_group">
                            <p id="title"><b>그룹</b> </p>
                        </div>
                        <div id="con_group">
                        <c:choose>
	                        <c:when test="${empty gList}">
	         					<div id="nouser">그룹이 존재하지 않습니다</div>
	         				</c:when>
	         				<c:otherwise>
	                        	<c:forEach var="g" items="${ gList }">
		                            <div id="search_group" style=" cursor: pointer;" onclick="location.href='gdetail.do?gNo=${ g.gNo }';">
		                                <img src="resources/gUploadFiles/${g.gRenameProfile} " alt="" id="group_profile_img">
		                                <p id="search_id_group">${ g.gName} </p>
		                            </div>                      
		                       </c:forEach>
	                       </c:otherwise>                        
                       </c:choose>
                        </div>
                    </div>
                </div>

                <!--연관 태그-->
                <div id="search_tag">
                    <div id="title_tag">
                        <p id="title"><b>연관 태그</b> </p>
                    </div>
                    <div id="con_tag">
                        <ul id="tag">
                        <c:choose>
	                        <c:when test="${empty rsList}">
	         					<li style="">연관검색어가 존재하지 않습니다</li>
             				</c:when>
	         				<c:otherwise>
	                        	<c:forEach var="rs" items="${ rsList }">
		                            <li style=" cursor: pointer;"><a href="tagSearch.do?search=${searchKey}+${rs}">#${rs}</a></li>	                                                  
		                       </c:forEach>
	                       </c:otherwise>                        
                        </c:choose>
                        </ul>
                    </div>
                </div>
                <!--검색된 피드-->
                <div id="search_feed">
                    <div id="title_feed">
                        <p id="title"><b>게시물</b> </p>
                    </div>
                    <div id="con_feed">
                    <table>
                    <c:choose>
	                    <c:when test="${empty fList}">
	                    <tr>
	                    	<td>
		       					<div id="nouser">게시글이 존재하지 않습니다</div>	                    	
	                    	</td>
	                    </tr>
	       				</c:when>
	       				<c:otherwise>
		       				 <% int  j = 0; %>
	                    	<c:forEach var="f" items="${ fList }">
		       				 <% if (j%3 == 0){ %>
	                    	<tr>
	                    	 <%} %>
	                    	<c:choose>
	                   			<c:when test="${ empty f.thumbnail }">
		                    		<td>
		                   			<div class="post" id="${ f.fNo }" style=" cursor: pointer;">
			                             <p>${f.fContent} </p>
			                        </div>
			                        </td>
	                   			</c:when>
	                   		
	                   			<c:otherwise>
		                   			<td>
		                   			<div class="post" id="${ f.fNo }" style=" cursor: pointer;">
			                            <img src="resources/pUploadFiles/${f.thumbnail}" alt="" id="post_con">
			                        </div>
			                        <td>
	                   			</c:otherwise>
	                   		</c:choose>							                 		
	                   		 <% if (j%3==2){ %>
	                   		<tr>
	                   		 <%} j++;%>
	                   		</c:forEach>
		                </c:otherwise>
					</c:choose>
                   	</table>	
                    </div>
                </div>
                
                <div id="popup_wrap">
                    <div id="close_popup">
                        <img src="resources/icons/close_white.png" type="button" id="close_btn" style=" cursor: pointer;">
                    </div>
                    <div id="feed_detail">
                        <div id="feed">
                            <div id="writer_submenu">
                               
                            </div>
                            <!-- 다른 회원 글 볼 때 피드메뉴 -->
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
                            <!-- 내가 쓴 글 볼 때 피드메뉴
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
                                    <p>신고사유</p>
                                    <select style=>
                                        <option>부적절한 게시글</option>
                                        <option>욕설</option>
                                        <option>광구</option>
                                        <option>도배</option>
                                    </select>
                                    <br>
                                    <input type="button" id="submit" name="submit" value="확인">
                                    <button id="cancel">취소</button>
                                </div>
                            </div>
                            <div id="con">
                                <div id="feed_content">
                                   
                                    <ul id="tag">
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                    </ul>
                                </div>
                                <div id="replyArea">
                                    <div id="replyList">
                                        <ul id="re_list">
                                            <li><img src="resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
                                            <li><p id="replyCon">맛있겠다...여기 어디인가요?? 대박 정보 좀....</p></li>
                                            <li><p id="time">1시간전</p></li>
                                            <li><img src="resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
                                        </ul>
                                    </div>
                                    <!-- 남이 단 댓글 볼 때 댓글 메뉴-->
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
                                        <input type="button" id="replyBtn" name="replyBtn" value="등륵">
                                    </div>
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		</div>
		
<script>
        /*$('.post').click(function(){
            $('#popup_wrap').show();
        });
        */
	
        $('#close_btn').click(function(){
            $('#popup_wrap').hide();
        });
	
        $(document).ready(function(){
            $('#chat_icon').click(function(){
                var state = $(".chat").css('display');
                if(state=='none'){
                    $('.chat').show();
                }else{
                    $('.chat').hide();
                }
            });


            /************  팝업 메뉴 script *********** */

            $('#feed_menu').on("click",function(){
                $('.pop_menu').show();
            });

            $('#close').on('click',function(){
                $('.pop_menu').hide();
            });

            $('#feed_report_btn').on("click",function(){
                $('.feed_report').show();
            });

            $('#cancel').on("click",function(){
                $('.feed_report').hide();
            });

            $('#updateBtn').on("click",function(){
                $('.reply_menu').show();
            });

            $('#re_close').on("click",function(){
                $('.reply_menu').hide();
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


        /************* 내계정 자세히보기 script **************/

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
        
        /*게시글 팝업*/
        $(document).on('click','.post',function(){
 		console.log($(this).attr("id") );
 		$.ajax({
 			url:'gFeedPop.do',
 			dataType:'json',
 			type:'post',
 		
 			data:{ fno : $(this).attr("id") },
 			async:false,
 	        success:function(data){
 				console.log(data);
 				if(data != null){
 	        	var input_writer ="";
                var feed_content ="";
 	        	input_writer += "<img src='/spring/resources/memberProfileFiles/"+data.mImage+"' id='feed_profile_img'>";
 	        	input_writer += "<div id='user_time'>";
 	        	input_writer += "<p id='feed_id'>"+data.fwriter+"</p>";
 	        	input_writer += "<h6>1시간 전</h6>";
 	        	input_writer += "</div>";	
 	        	input_writer +="<img src='/spring/resources/icons/feed_menu.png' id='feed_menu'>" ;
 	        	$("#writer_submenu").append(input_writer);
                $("#writer_submenu").html(input_writer);
                //나중에 for문으로 돌려서 여러장 볼 수 있어야 함
                if(data.plist == ""){
                }else{
                feed_content += "<img src='/spring/resources/pUploadFiles/"+data.plist[0]+"' alt='' id='input_img'>";                	
                }
                feed_content += "<div id='heart_reply'>";
                feed_content += "<img src='/spring/resources/icons/heart.png' type='button' id='likeIcon'>";
                feed_content += "<img src='/spring/resources/icons/bubble.png' type='button' id='replyIcon'>";
                feed_content += "</div>";  
                feed_content += "<p id='text'>"+data.fcontent+"</p>";

                $("#feed_content").append(feed_content);
                $("#feed_content").html(feed_content);
                
 	        	 $('#popup_wrap').show();
 				}
 	        	
 	        },error:function(request,jqXHR,exception){
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
 	
    $('.feed_delete').click(function() {
        $(".pop_feed").hide();
    });
    </script>
</body>
</html>