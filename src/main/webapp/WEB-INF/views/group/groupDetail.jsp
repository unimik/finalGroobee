<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="<%=request.getContextPath()%>/resources/css/groupDetail.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/groupJoinPop.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/pop_menu.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="resources/js/Alarm.js"></script>
	<style>
		#cancel2{margin-left: 16px; margin-top:-4px;cursor: pointer;display: block;width: 100px; background:#e5e5e5;border: none;border-radius: 10px;width:100px;height: 35px;float: left;}	
		#report-submit{margin-left:50px; margin-top:-4px; float:left; width:100px; background:#daf4ed;}
		#selectRtype{ width:100px; margin-left:50px; background:#daf4ed;}
		#reportContent{margin-top:14px; margin-left:50px; background:#daf4ed; resize:none;display:none; border:none;}
		#searchTable {display: none; width: 100%; margin-bottom: 100px;}
		.postbox{ width: 200px; height: 200px; display: inline-block;}
		.postbox > img {width: 200px; height: 200px;}
	</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	<div id="feedArea">
		<div id="section1">
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
                            <button id="groupdotbtn" style="cursor:pointer;">
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" id="group_menuBtn" name="group_menuBtn">
                            </button>
                            <div class="pop_menu">
                                <div id="feed_menu_list">
                                    <ul>
                                        <li><a id="groupJoin_btn" class="gmSelet">그룹가입</a></li>
                                        <li><a id="feed_report_btn">신고</a></li> 
                                        <li><a id="close">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pop_menu_gm">
                                <div id="feed_menu_list">
                                <c:url var="gmDelete" value="gmDelete.do">
                                	<c:param name="gNo" value="${ g.gNo }"/>
                                	<c:param name="gmId" value="${ loginUser.userId }"/>
                                </c:url>
                                    <ul>
                                        <li><a href="${ gmDelete }">그룹탈퇴</a></li>
                                        <li><a id="feed_report_btn">신고</a></li> 
                                        <li><a id="close_gm">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pop_menu_master">
                                <div id="feed_groupmenu_list">
                                	<c:url var="gUpdateView" value="gUpdateView.do">
                                		<c:param name="gNo" value="${ g.gNo }"/>
                                		<c:param name="gmId" value="${ loginUser.userId }"/>
                                	</c:url>
                                    <c:url var="gdelete" value="gdelete.do"/>
                                    <ul>
                                        <li><a href="${ gUpdateView }">그룹관리</a></li>
                                        <li><a href="${ gdelete }">그룹삭제</a></li>
                                        <li><a id="isnertGroupChat">채팅방생성</a></li>
                                        <li><a id="close_master">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                           <div class="feed_report">
                                <div id="feed_report_con">
                                    <p>신고사유</p>
                                    <select id="reportType" class="selectRtype">
                                        <option value="unacceptfeed" selected>부적절한 게시글</option>
                                        <option value="insult">욕설</option>
                                        <option value="ad">광고</option>
                                        <option value="spam">도배</option>
                                    </select>
                                    	<textarea class="sendreport" id="reportContent" cols="28" rows="4"></textarea>
                                    <br>
                                    <input class="selectRtype" id="selectRtype"type="button" value="확인" style="cursor:pointer;">
                                    <input class="sendreport" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
                                    <button class="selectRtype" id="cancel" style="cursor:pointer;">취소</button>
                                    <button class="sendreport" id="cancel2" style="cursor:pointer; display:none;">취소</button>
                                </div>
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
	                                    <form action="gmInsert.do" method="post">
	                                    	<input type="hidden" name="mId" value="${ loginUser.userId }">
	                                    	<input type="hidden" name="gNo" value="${ g.gNo }">
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
	                                                <input type="submit"  id="joinBtn" name="joinBtn" value="가입하기">
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
                 </div>
                 <c:set var="gOpenScope" value="${ g.gOpenScope }"/>
                 <c:set var="gmId" value="${gmId }"/>
                 <c:choose>
                 	<c:when test="${ 'N' eq gOpenScope }">
                		<c:if test="${ not fn:contains(gmId, loginUser.userId) }">
		                 	<div id="nOpen" style="display:block">
	                			<p>비공개 그룹입니다. 가입신청을 하신 후 이용해주세요.</p>
	                		</div>
                		</c:if>
                		<c:if test="${ fn:contains(gmId, loginUser.userId) }">
		                 	<div id="nOpen" style="display:none">
	                			<p>비공개 그룹입니다. 가입신청을 하신 후 이용해주세요.</p>
	                		</div>
                		<!-- 그룹 내 검색 -->
                       	<div id="section2">
		                    <div id="groupSearchbar">
		                        <input type="search" id="groupSearch" name="groupSearch" placeholder="그룹 내 검색">
		                        <input type="button" id="groupSearchBtn" name="groupSearchBtn" value="검색" onclick="gsearch()"/>
		                    </div>
		                    <div id="groupFeedArea">
		                        <div id="btnsbox">
		                            <button class="newFeedBtn feedbtns on" id="newFeedBtn" >최근 게시글</button>
		                            <button class="hotFeedBtn feedbtns" id="hotFeedBtn" >인기 게시글</button>
		                        </div>
		                    </div>
	                 	</div>        
	                        <div class="feedContainar">
	                            <div class="newConBox conBox on">
	                            <div id="newfeedArea">
								<c:if test="${ !empty ngflist }">
								<c:forEach var="f" items="${ ngflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a href="pDelete.do?fNo=${ f.fNo }">삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    
								    </div>
							            <div id="con">
							                <div id="feed_content">
												<c:if test="${ !empty f.photoList }">
													<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
													<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
													<ul id="imgList">
														<c:forEach var="p" items="${ f.photoList }">
															<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
														</c:forEach>
													</ul>
												</c:if>
							                    <div id="heart_reply">
													<img src="${ contextPath }/resources/icons/heart.png" alt="" id="likeIcon">
													<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
												</div>
												<p id="text"><c:out value="${ f.fContent }" /></p>
							                    
							                </div>
							                <div id="replyArea">
							                    <div id="replyList">
							                        <ul id="re_list">
							                            <li><img src="../resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
							                            <li><p id="replyCon">맛있겠다...여기 어디인가요?? 대박 정보 좀....</p></li>
							                            <li><p id="time">1시간전</p></li>
							                            <li><img src="../resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
							                        </ul>
							                    </div>
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
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                            <div class="hotConBox conBox">
	                                <div id="newfeedArea">
								<c:if test="${ !empty hgflist }">
								<c:forEach var="f" items="${ hgflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a href="pDelete.do?fNo=${ f.fNo }">삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    </div>
							            <div id="con">
							                <div id="feed_content">
												<c:if test="${ !empty f.photoList }">
													<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
													<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
													<ul id="imgList">
														<c:forEach var="p" items="${ f.photoList }">
															<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
														</c:forEach>
													</ul>
												</c:if>
							                    <div id="heart_reply">
													<img src="${ contextPath }/resources/icons/heart.png" alt="" id="likeIcon">
													<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
												</div>
												<p id="text"><c:out value="${ f.fContent }" /></p>
							                    
							                </div>
							                <div id="replyArea">
							                    <div id="replyList">
							                        <ul id="re_list">
							                            <li><img src="../resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
							                            <li><p id="replyCon">맛있겠다...여기 어디인가요?? 대박 정보 좀....</p></li>
							                            <li><p id="time">1시간전</p></li>
							                            <li><img src="../resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
							                        </ul>
							                    </div>
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
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                        	<table id="searchTable"></table>
	                        </div>
	                   </c:if>	
	               </c:when>
                 	<c:otherwise>
                	<!-- 그룹 내 검색 -->
	                 	<div id="section2">
	                    <div id="groupSearchbar">
	                        <input type="search" id="groupSearch" name="groupSearch" placeholder="그룹 내 검색">
	                        <input type="button" id="groupSearchBtn" name="groupSearchBtn" value="검색"  onclick="gsearch()">
	                    </div>
	                    <div id="groupFeedArea">
	                        <div id="btnsbox">
	                            <button class="newFeedBtn feedbtns on" id="newFeedBtn" >최근 게시글</button>
	                            <button class="hotFeedBtn feedbtns" id="hotFeedBtn" >인기 게시글</button>
	                        </div>
	                    </div>
	                 </div>        
	                        <div class="feedContainar">
	                        	<table id="searchTable"></table>
	                            <div class="newConBox conBox on">
	                            <div id="newfeedArea">
								<c:if test="${ !empty ngflist }">
								<c:forEach var="f" items="${ ngflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a href="pDelete.do?fNo=${ f.fNo }">삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    
								    </div>
							            <div id="con">
							                <div id="feed_content">
												<c:if test="${ !empty f.photoList }">
													<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
													<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
													<ul id="imgList">
														<c:forEach var="p" items="${ f.photoList }">
															<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
														</c:forEach>
													</ul>
												</c:if>
							                    <div id="heart_reply">
													<img src="${ contextPath }/resources/icons/heart.png" alt="" id="likeIcon">
													<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
												</div>
												<p id="text"><c:out value="${ f.fContent }" /></p>
							                    
							                </div>
							                <div id="replyArea">
							                    <div id="replyList">
							                        <ul id="re_list">
							                            <li><img src="../resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
							                            <li><p id="replyCon">맛있겠다...여기 어디인가요?? 대박 정보 좀....</p></li>
							                            <li><p id="time">1시간전</p></li>
							                            <li><img src="../resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
							                        </ul>
							                    </div>
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
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                            <div class="hotConBox conBox">
	                                <div id="newfeedArea">
								<c:if test="${ !empty hgflist }">
								<c:forEach var="f" items="${ hgflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a href="pDelete.do?fNo=${ f.fNo }">삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    
								    </div>
							            <div id="con">
							                <div id="feed_content">
												<c:if test="${ !empty f.photoList }">
													<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
													<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
													<ul id="imgList">
														<c:forEach var="p" items="${ f.photoList }">
															<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
														</c:forEach>
													</ul>
												</c:if>
							                    <div id="heart_reply">
													<img src="${ contextPath }/resources/icons/heart.png" alt="" id="likeIcon">
													<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
												</div>
												<p id="text"><c:out value="${ f.fContent }" /></p>
							                    
							                </div>
							                <div id="replyArea">
							                    <div id="replyList">
							                        <ul id="re_list">
							                            <li><img src="../resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
							                            <li><p id="replyCon">맛있겠다...여기 어디인가요?? 대박 정보 좀....</p></li>
							                            <li><p id="time">1시간전</p></li>
							                            <li><img src="../resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
							                        </ul>
							                    </div>
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
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                        </div>
                 	</c:otherwise>
                 </c:choose>
                	</div>
            </div>
        </div>
        
        <script>

        /************** 채팅 팝업 *****************/

        $(document).ready(function(){
          
            /************  팝업 메뉴 script *********** */

            $('#group_menuBtn').on("click",function(){
            	$.ajax({
            		url:"gmSelect.do",
            		data:{ userId:"${loginUser.userId}", gNo:${g.gNo}},
            		type:"post",
            		success:function(data){
            			console.log(data);
            			if(data > 0){
            				if("${g.gManager}" == "${loginUser.userId}"){
            					$('.pop_menu_master').show();
            				} else if("${g.gCreator}" != "${loginUser.userId}"){
            					$('.pop_menu_gm').show();
            				} else {
            					$('.pop_menu_master').show();
            				}
            			} else {
           		            $('.pop_menu').show();
            			}
            		}, error:function(){
            			alert("오류");
            		}
            	});
            });
            

            $('#close').on('click',function(){
                $('.pop_menu').hide();
            });
            $('#close_gm').on('click',function(){
                $('.pop_menu_gm').hide();
            });
            $('#close_master').on('click',function(){
                $('.pop_menu_master').hide();
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
           		if ( "${ g.gJoinSet }" == "N"){
           			alert("멤버 가입이 불가능한 그룹입니다.");
           		} else{
           		
                  $.ajax({
                  	url:"gmCheckId.do",
                  	data:{ gNo:${g.gNo}, gmId:"${loginUser.userId}"},
              		success:function(data){
              			console.log(data);
              			if(data == 0){
              				$('.joinPop_back').show();
              			} else {
              				alert("이미 가입신청하셨습니다.");
              			}
              		},error:function(){
              			alert("오류");
              		}
                  });
           		}
              });	
           	
            $("#close_joinPop").on("click",function(){
                $('.joinPop_back').hide();
            });
        });

        $(document).ready(function(){
			
    		
			var count = $(".feed").length;
		
			for(var i = 1; i <= count; i++){
				console.log('.feed_menu'+i);
				 $('.feed_menu'+i).on("click",function(){
			         $(this).nextAll('div .g_pop_menu').show();
			         $(this).nextAll('div .g_pop_Mymenu').show();
			     });
				 
				  $('.close').on("click",function(){
			         $('.g_pop_menu').hide();
			         $('.g_pop_Mymenu').hide();
			     });
				  
				  
				  
			 	$('.feed_report_btn').on("click",function(){
			 		 $('.feed_report').show();
	            });
				 
			 	
			}
        });

         /*********** 뉴피드 / 핫피드 *************/

         $('.feedbtns').on('click', function(){
                $('.feedbtns').removeClass('on');
                $(this).addClass('on');
            });

            $("#newFeedBtn").on('click',function(){
                $('.conBox').hide();
                $('.newConBox').show();
                $('#searchTable').hide();
            });

            $("#hotFeedBtn").on('click',function(){
                $('.conBox').hide();
                $('.hotConBox').show();
                $('#searchTable').hide();
            });
            
            /**************** 그룹 신고 관련*******************/ 
    		$(document).on('click',"#report-submit",function(){
    			
    			if($("#reportContent").val() == ""){
    				alert('신고 사유를 입력해 주세요.')
    			}else{
    				
    				$.ajax({
    					url:'reportGInsert.do',
    					data:{
    						reportType : $("#reportType").val(),
    						feedType : "group",
    						content : $("#reportContent").val(),
    						gNo:${ g.gNo }
    					},
    					success: function(){
    						$(".feed_report").css('display','none');
    						$(".selectRtype").css("display","inline-block");
    			      		$(".sendreport").css("display","none");
    			      		$("#reportContent").val('')
    			      		$(".pop_menu").css("display",'none');
    						alert('신고완료');
    					},error:function(){
    						alert('신고 실패!');
    					}
    				});
    				
    			};
    		});
          	 
          	$("#cancel2").on('click',function(){
          		$(".feed_report").css('display','none');
    			$(".selectRtype").css("display","inline-block");
          		$(".sendreport").css("display","none");
          	})
          	
          	$("#selectRtype").on('click',function(){
          		$(".selectRtype").css("display","none");
          		$(".sendreport").css("display","block");
          	}); 
          	
          	 var size;
 	        var idx = idx1 = 0;
 	        var count = $(".feed").children('div#con').children('div#feed_content').children("ul#imgList").length;
 	        var ul;
 	        console.log(count);
 	        var liCount;
 	        
 			for (var i = 1; i <= count; i++){
 				ul = $("#feed"+i).children('div#con').children('div#feed_content').children("ul#imgList").children("li").length;
 				
 				console.log(ul);
 				
 				if( ul > 1){
 	        		$('#nextBtn'+i).css("display","block");
 	        		$('#prevBtn'+i).css({"display":"block"});
 	        	}
 				
 				
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
     	  			}
     	  				
     	  			
     	  		});
 			
 				
 				
 			}
 			
 			// 알림 기능
 			$("#joinBtn").on('click',function test(){
 				console.log('${loginUser.userId}','${g.gCreator}',"groupjoin",'${g.gNo}');
 	  			sendAlram('${loginUser.userId}','${g.gCreator}','groupjoin','${g.gNo}');   
 			});
 			
 			
 	/*그룸내 검색*/
	function gsearch() {
		var gsearch = $('#groupSearch').val();
   		var sign = gsearch.charAt(0);			//검색어 첫글자 - 기호
		var keyword = gsearch.substr(1);		//키워드
		var gNo = ${ g.gNo };					//그룹번호
		
		if(gsearch.length == 0){
			alert('검색어를 입력해주세요');			
		}else if(sign == " "){
			alert('검색어 첫글자를 띄어 쓸 수 없습니다');		
		}else{
			$.ajax({
				url:'/spring/gSearch.do',
				dataType:'json',
				type:'post',
				data:{gNo: gNo,
					  gsearch:gsearch
					  },
		        success:function(data){
					if(data.flist != null){
						$('.conBox').hide();

	    				var input="";
	    				var j = 0;
	    				for(var i=0; i < data.flist.length; i++){
	    				 		if (j%3==0){ 
	    				input +="<tr>";
	    						}
	    						if(data.flist[i].thumbnail != null){	
	    				input += "<td class='postbox' name='postbox'>";	
	    				input += "<img src='/spring/resources/pUploadFiles/"+data.flist[i].thumbnail+"'>";	
	    				input += "</td>";		
	    						}else{	
	    				input += "<td class='postbox' name='postbox'>";	
	    				input += "<div type='button' id='pb2'>";
	    				input += "<text>"+data.flist[i].fcontent+"</text>";	
	    				input += "</div>";
	    				input += "</td>";
	    						}	
		    				if (j%3==2){ 
		    					input +="</tr>"; 	
		    				}
	    				j++;
	    				}
	    				
	    				$("#searchTable").append(input);
	                    $("#searchTable").html(input);
						$('#searchTable').show();

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
			
			
		}
		
	}
    </script>
</body>
</html>