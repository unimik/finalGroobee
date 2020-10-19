<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="<%=request.getContextPath()%>/resources/css/groupDetail.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/groupJoinPop.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/pop_menu.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	<div id="feedArea">
                <div id="infofeed">
                    <!--그룹 정보 나오는 칸-->
                    <div id="groupInfoArea" > 
                        <!--그룹 이미지 넣는 장소?-->
                        <c:if test="${ !empty g.gImage }">
	                        <div id="groupImage" >
	                            <img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameImage }" alt="" >
	                        </div>
                        </c:if>
                        <c:if test="${ empty g.gImage }">
                        	<div id="groupImage" >
                            	<img src="<%=request.getContextPath()%>/resources/images/g_back.png" alt="" >
                        	</div>
                        </c:if>
                        <!--그룹명, 관심사, 소개 등등-->
                        <div id="groupInfo">
                            <!-- 그룹명 관심사-->
                            <div id="groupNameAndInterest">
                                <p id="groupName"><b>${ g.gName }</b> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</p>
                                <p id="groupInterest">${ g.gCategory }</p>
                            </div>
                            <!-- ... 버튼 -->
                            <button id="groupdotbtn">
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" id="group_menuBtn" name="group_menuBtn">
                            </button>
							<c:if test="${ loginUser.userId ne g.gCreator }">
                            <div class="pop_menu">
                                <div id="feed_menu_list">
                                    <ul>
                                        <li><a id="groupJoin_btn">그룹가입</a></li>
                                        <li><a>그룹탈퇴</a></li>
                                        <li><a id="feed_report_btn">신고</a></li> 
                                        <li><a id="close">취소</a></li>
                                    </ul>
                                </div>
                            </div>
							</c:if>
							<c:if test="${ loginUser.userId eq g.gCreator }">
                            <div class="pop_menu">
                                <div id="feed_groupmenu_list">
                                	<c:url var="gUpdateView" value="gUpdateView.do"/>
                                    <c:url var="gdelete" value="gdelete.do"/>
                                    <ul>
                                        <li><a href="${ gUpdateView }">그룹관리</a></li> 
                                        <li><a>그룹탈퇴</a></li> 
                                        <li><a href="${ gdelete }">그룹삭제</a></li>
                                        <li><a>채팅방생성</a></li>
                                        <li><a id="close">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            </c:if>
                            <div class="feed_report">
                                <div id="feed_report_con">
                                    <p>신고사유</p>
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

                            <!-- 그룹 가입 팝업 -->
                            <div class="joinPop_back">
                                <div class="join">
                                    <div id="group_info">
                                        <p id="title">그룹가입</p>
                                        <div id="group_top">
                                        	<c:if test="${ !empty g.gProfile }">
                                            	<img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameProfile }">
                                            </c:if>
                                            <c:if test="${ empty g.gProfile }">
												<img src="<%=request.getContextPath()%>/resources/icons/g_pro.png">
                                            </c:if>
                                            <p id="join_groupName">${ g.gName }</p>
                                            <ul>
						                      <c:forTokens var="gTag" items="${ g.gTag }" delims=" ">
								              		<li>${ gTag }&nbsp;</li>
							                  </c:forTokens>
                                            </ul>
                                        </div>
	                                        <form action="gmWaiting.do" method="post">
	                                            <div id="join_questionCon">
	                                            <c:set var="q_status" value="${ g.gQset }"/>
                                        		<c:choose>
		                                            <c:when test="${ 'Y' eq q_status }">
		            									<c:if test="${ !empty g.q1 }">
			                                                <div id="questionBox">
			                                                    <p>질문 : ${ g.q1 }</p>
			                                                    <textarea cols="70" rows="5" name="a1"></textarea>
			                                                </div>
		                                                </c:if>
		                                                <c:if test="${ !empty g.q2 }">
		                                                	<div id="questionBox">
		                                                    	<p>질문 : ${ g.q2 }</p>
		                                                    	<textarea cols="70" rows="5" name="a2"></textarea>
		                                                	</div>
		                                                </c:if>
		                                                <c:if test="${ !empty g.q3 }">
		                                                	<div id="questionBox">
		                                                    	<p>질문 : ${ g.q3 }</p>
		                                                    	<textarea cols="70" rows="5" name="a3"></textarea>
		                                                	</div>
		                                                </c:if>
		                                            </c:when>
		                                            <c:otherwise>
		                                        		<p id="p1"><b>${ g.gName }</b>에 가입신청을 하시겠습니까?</p>
		                                        	</c:otherwise>
	                                        	</c:choose>
	                                            </div>
	                                            <div id="btnBox">
	                                                <input type="submit" id="joinBtn" name="joinBtn" value="가입하기">
	                                                <input type="button" id="close_joinPop" name="close_joinPop" value="취소">
	                                            </div>
	                                        </form>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 그룹 소개글-->
                            <div id="groupintroduction">
                                <b>그룹소개</b><br>
                                <p id="groupInfo">${ g.gIntro }</p><br>
                                <ul id="tag">
                                <c:forTokens var="gTag" items="${ g.gTag }" delims=" ">
	               					<li>${ gTag }&nbsp;</li>
                                </c:forTokens>
            					</ul>
                            </div> 
                        </div>
                    </div>
                    <div id="groupSearchbar">
                        <input type="search" id="groupSearch" name="groupSearch" placeholder="그룹 내 검색">
                        <input type="button" id="groupSearchBtn" name="groupSearchBtn" value="검색">
                    </div>
                    <div id="groupFeedArea">
                        <div id="btnsbox">
                            <button class="newFeedBtn feedbtns on" id="newFeedBtn" >최근 게시글</button>
                            <button class="hotFeedBtn feedbtns" id="hotFeedBtn" >인기 게시글</button>
                        </div>
                        <div class="feedContainar">
                            <div class="newConBox conBox on">
                                바보똥개
                            </div>
                            <div class="hotConBox conBox">
                                멍청이
                            </div>
                        </div>
                    </div>
                </div>               
            </div>
        </div>
        
        <script>

        /************** 채팅 팝업 *****************/

        $(document).ready(function(){
            $('#chat_icon').click(function(){
                var state = $(".chat").css('display');
                if(state=='none'){
                    $('.chat').show();
                }else{
                    $('.chat').hide();
                }

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


            });


            /************  팝업 메뉴 script *********** */

            $('#group_menuBtn').on("click",function(){
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

            $('#groupJoin_btn').on("click",function(){
                $('.joinPop_back').show();
            });

            $("#close_joinPop").on("click",function(){
                $('.joinPop_back').hide();
            });
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


         /*********** 뉴피드 / 핫피드 *************/

         $('.feedbtns').on('click', function(){
                $('.feedbtns').removeClass('on');
                $(this).addClass('on');
            });

            $("#newFeedBtn").on('click',function(){
                $('.conBox').hide();
                $('.newConBox').show();
            });

            $("#hotFeedBtn").on('click',function(){
                $('.conBox').hide();
                $('.hotConBox').show();
            });


    </script>
</body>
</html>