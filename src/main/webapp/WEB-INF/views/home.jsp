<%@page import="com.kh.spring.feed.model.vo.Reply"%>
<%@page import="com.kh.spring.feed.model.vo.Photo"%>
<%@page import="com.kh.spring.feed.model.vo.Feed"%>
<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<title>G R O O B E E</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/home.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	.feed{ height: fit-content; margin-bottom: 50px; border: 1px solid #e5e5e5; width: 630px; }
	.feed h6{ color: #cccccc; margin: 0; padding:0; margin-top: 2px;}
	#footer{ height: 200px; text-align: center; }
	a{ color: black; }
	#imgList{position:relative; margin:0; padding:0; list-style:none; overflow:hidden;}
	#imgList li{ display:none; float:left; position: absolute; top:0; left:0;}
	#imgList li:nth-child(1){ display: block; }
	#imgList img{ width: 633px; height: 633px; }
	.imgbtn{ z-index:5;border: 0; background: none; cursor: pointer; outline: none; }
	button[name=nextBtn]{display: none; position: absolute; margin: 300px 570px; }
	button[name=prevBtn]{display: none; position: absolute; margin: 300px 20px; }
	#replyList{ width: 100%; height: 0px; }
	#replySub::-webkit-scrollbar{ width: 7px;}
	#replySub::-webkit-scrollbar-thumb{ border-radius: 10px; background-color: #47c6a3; }
	#replySub::-webkit-scrollbar-track{ background-color: #daf4ed;}
	#rCount{ width: fit-content; font-size: 10pt; position: absolute; left: 100px; top: 75px; }
	#re_list li:nth-child(2){ width: 55%; margin-bottom: 20px; height: fit-content; }
	#replyCon{ width: 55%; resize: none; line-height: 12pt; white-space: pre-line; background: white;
			   inline-size: fit-content; border: none; font-size: 9pt; float: left; overflow: hidden; }
	.replycnt_p, .likeCnt{ width: fit-content; display: inline; font-size: 10pt; color: #a9a9a9;
						   position: absolute; margin: 10px;}
	.likeCnt{ margin-left: 0px; }
	#userId{ margin: 9px 10px 0 10px; }
	#time{ width: 100%; }
	#rWriterInfo{ width: 25%; }
	#rUpdateMenu{ width: 10%; }
	#confirmR{ display: none; float: left; margin: 9px 0px 0px 5px; float: left;
			   border: none; border-radius: 5px; background: #daf4ed; }
	#liked{ width: 25px; height: 25px; opacity: 80%; margin: 6px 0 0 25px;}
    .replyUpBtn { width: 90px; height: 40px; border-radius: 10px; border: 0; background: #daf4ed; }
    #topScrollBox{ text-align:center; display:none; }
	#topScrollBox>img{ width: 45px; cursor: pointer; }
	#cancel2{outline:none; margin-left: 16px; margin-top:-4px;cursor: pointer;display: block;width: 100px; background:#e5e5e5;border: none;border-radius: 10px;width:100px;height: 35px;float: left;}	
	#report-submit{margin-left:50px; margin-top:-4px; float:left; width:100px; background:#daf4ed;border:0; border-radius: 10px;width:100px;height: 35px;}
	#selectRtype{ width:100px; margin-left:50px; background:#daf4ed; border:0; border-radius: 10px;width:100px;height: 35px;}
	#reportContent{margin-top:14px; margin-left:50px; background:#daf4ed; resize:none;display:none; border:none;}
	.setN{ margin-left: 25px; font-size: 10pt; color: #a9a9a9; line-height: 2.7em; }
	#replyIcon{ margin: 9px 0 0 60px;}
	#likeIcon { margin: 7px 0 0 25px; }
	button{ cursor: pointer; }
	.usertag {color: #47c6a3;}
	.hashtag{color:#88abda;}
</style>

</head>
<body>
	<c:import url="common/menubar.jsp" />
	<div id = "topScrollBox"><img src="${ contextPath }/resources/icons/topScroll.png" id="topScrollBtn"></div>
	<div id="feedArea">
	<c:forEach var="f" items="${ feed }" varStatus="status">
		<c:set var="i" value="${ i + 1 }"/>
		<!-- 공개 여부가 비공개가 아닐 때 (전체 공개, 친구 공개) -->
		<c:if test="${ f.fOpenScope ne 'G' }">
			<div id="feed${ i }" class="feed">
			<div id="writer_submenu">
				<c:choose>
					<c:when test="${ loginUser.userId ne f.fWriter }">
						<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
						<c:if test="${ f.mImage ne null }">
						<img src="${ contextPath }/resources/memberProfileFiles/${ f.mImage }" alt="" id="feed_profile_img">
						</c:if>
						<c:if test="${ f.mImage eq null }">
						<img src="${ contextPath }/resources/icons/pro_default.png" alt="" id="feed_profile_img">
						</c:if>
						<div id="user_time">
							<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
							<h6><c:out value="${ f.fModifyDate }" /></h6>
							<c:if test="${ f.gNo ne 0 }">
							<c:url var="godetail" value="gdetail.do">
							<c:param name="gNo" value="${ f.gNo }"/>
							</c:url>
							<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
							</c:if>
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feedMenu">
					</c:when>
					<c:otherwise>
						<a href="goMypage.do?mNo=${ loginUser.mNo }">
						<c:if test="${ !empty loginUser.mRenameImage }">
						<img src="${ contextPath }/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="" id="feed_profile_img">
						</c:if>
						<c:if test="${ empty loginUser.mRenameImage }">
						<img src="${ contextPath }/resources/icons/pro_default.png" alt="" id="feed_profile_img">
						</c:if>
						<div id="user_time">
							<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
							<h6><c:out value="${ f.fCreateDate }" /></h6>
							<c:if test="${ f.gNo ne 0 }">
							<c:url var="godetail" value="gdetail.do">
							<c:param name="gNo" value="${ f.gNo }"/>
							</c:url>
							<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
							</c:if>
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feedMenu">
					</c:otherwise>
				</c:choose>
				<c:if test="${ loginUser.userId ne f.fWriter }">
					<!-- 다른 회원 글 볼 때 피드 메뉴 -->
	 				<div class="pop_menu">
	 				<input type="hidden" id="fn" name="fn" class="fn" value="${ f.fNo }">
						<div id="feed_menu_list">
							<ul>
					            <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
					            <li><a id="share_feed" class="share_feed">공유하기</a></li>
					            <li><a id="goStorage" class="goStorage">보관함</a></li>
					            <li><a id="close" class="close">취소</a></li>
							</ul>
						</div>
					</div>
					<div class="storagePop">
					</div>
				</c:if>
				<c:if test="${ loginUser.userId eq f.fWriter }">
					<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
	                <div class="pop_Mymenu">
	                    <div id="feed_Mymenu_list">
	                        <ul>
	                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
	                        <li><a href="pDelete.do?fNo=${ f.fNo }" class="deleteMyPost">삭제</a></li> 
	                        <li><a id="close" class="close">취소</a></li>
	                        </ul>
	                    </div>
	                </div>
				</c:if>
			</div>
		<div class="feed_report">
			<input type="hidden" value=${f.fNo }>
			<div id="feed_report_con">
				<p>신고사유</p>
				<select id="reportType" class="selectRtype">
					<option value="unacceptfeed" selected>부적절한 게시글</option>
					<option value="insult">욕설</option>
					<option value="ad">광고</option>
					<option value="spam">도배</option>
				</select>
				<textarea class="sendreport Rcontent" id="reportContent" cols="28"
					rows="4"></textarea>
				<br> <input class="selectRtype Rtype" id="selectRtype"
					type="button" value="확인" style="cursor: pointer;"> <input
					class="sendreport report-submit" type="button" id="report-submit"
					value="확인" style="cursor: pointer; display: none;">
				<button class="selectRtype cancel" id="cancel"
					style="cursor: pointer;">취소</button>
				<button class="sendreport cancel2" id="cancel2"
					style="cursor: pointer; display: none;">취소</button>
			</div>
			</div>
			<!-- 댓글을 신고해보자! -->
			<div class="reply_report" id="reply_report" style="display:none">
				<div id="Reply_report_con">
					<p>신고사유</p>
					<select id="reply_reportType" class="selectRtype">
						<option value="unacceptfeed" selected>부적절한 게시글</option>
						<option value="insult">욕설</option>
						<option value="ad">광고</option>
						<option value="spam">도배</option>
					</select>
					<textarea class="sendreport Rcontent" id="reply_reportContent" cols="28"
						rows="4"></textarea>
					<br> <input class="selectRtype Rtype" id="selectRtype"
						type="button" value="확인" style="cursor: pointer;"> <input
						class="sendreport reply_submit" type="button" id="reply_report-submit"
						value="확인" style="cursor: pointer; display: none;">
					<button class="selectRtype cancel" id="cancel"
						style="cursor: pointer;">취소</button>
					<button class="sendreport cancel2" id="cancel2"
						style="cursor: pointer; display: none;">취소</button>
				</div>
			</div>
			<div id="con">
				<div id="feed_content">
					<c:if test="${ !empty f.photoList and f.photoList ne null }">
						<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
						<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
						<ul id="imgList" style="height:633px">
							<c:forEach var="p" items="${ f.photoList }">
							<c:if test="${ p.changeName ne null }">
								<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
							</c:if>
							</c:forEach>
						</ul>
					</c:if>
						<%-- 
						<p id="text">
						<c:out value="${ f.fContent }" />
						</p>
						--%>
						<div id="text">
						${ f.fContent }
						</div>
	
					<div id="heart_reply">
					<!-- 좋아요 금지가 되어 있지 않을 경우 -->
					<c:if test="${ f.fLikeSet eq 'Y' }">
					<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
	             	<c:choose>
		             	<c:when test="${ f.likeChk eq null }">
		             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
		             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }</label>
		             	</c:when>
		             	<c:otherwise>
		             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">
			               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }</label>
		             	</c:otherwise>
	             	</c:choose>
					</c:if>
	               		<input type="hidden" class="toNo" value="${ f.fNo }">
	               		<input type="hidden" class="toId" value="${ f.fWriter }">
	               		<!-- 댓글이 전체 허용일 경우 -->
						<c:if test="${ f.fReplySet eq 'Y' || f.fReplySet eq 'F' }">
						<c:choose>
							<c:when test="${ f.fLikeSet eq 'N' }">
							<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
							<label class="replycnt_p">${ f.fReplyCnt }</label>
							</c:when>
							<c:otherwise>
							<!-- 댓글과 좋아요 모두 허용될 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
							<label class="replycnt_p">${ f.fReplyCnt }</label>
							</c:otherwise>
						</c:choose>
						</c:if>
	
						<c:if test="${ f.fReplySet eq 'N' && f.fLikeSet eq 'N' }">
							<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
						</c:if>
	           		</div>
				</div>
				
				<div id="replyArea">
					<div id="replyList" style="display: block; height: fit-content;">
					<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
					<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
					<c:if test="${ f.fReplyCnt ne 0 }">
						<div id="replySub" style="display: block; height: 150px; overflow: auto;">
						<c:forEach var="r" items="${ f.replyList }">
							<c:if test="${ r.rStatus eq 'Y' }">
							<div id="selectOne">
							<!-- 댓글 번호 -->
							<input type="hidden" class="rNum" value="${ r.rNo }">
				  				<ul id="re_list" class="list">
				  				<c:if test="${ !empty r.rWriterImg }">
									<li><img src="${ contextPath }/resources/memberProfileFiles/${ r.rWriterImg }" alt=""
										id="reply_img">&nbsp;&nbsp;&nbsp;
										<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
								</c:if>
								<c:if test="${ empty r.rWriterImg }">
									<li><img src="${ contextPath }/resources/icons/pro_default.png" alt=""
										id="reply_img">&nbsp;&nbsp;&nbsp;
										<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
								</c:if>
									<li><textarea id="replyCon" class="rCon" data-autoresize readonly required="required" placeholder="댓글을 입력해 주세요." cols=40 rows=auto disabled><c:out value="${ r.rContent }" /></textarea>
									<input type="button" id="confirmR" class="rConfirm" value="완료"></li>
									<li><p id="time"><c:out value="${ r.rModifyDate }" /></p></li>
									<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn" class="rUpBtn"></li>
								</ul>
								<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
								<c:if test="${ loginUser.userId eq r.rWriter }">
								<div id="reply_menu" class="reply_menu">
									<div id="re_menu_list">
										<ul>
											<li><a id="rEdit" class="rEdit">댓글 수정</a></li>
											<li><a class="rDelete">댓글 삭제</a></li>
											<li><a id="re_close" class="rClose">취소</a></li>
										</ul>
									</div>
								</div>
								</c:if>
								<!-- 다른 사람이 단 댓글 볼 때 메뉴 -->
								<c:if test="${ loginUser.userId ne r.rWriter }">
								<div id="reply_menu" class="reply_menu">
									<div id="re_menu_list">
										<ul>
											<li><a href="goUserpage.do?userId=${ r.rWriter }&mNo=${ r.mNo }" class="rGoFeed">피드 가기</a></li>
											<li><a id="rReport" class="rReport">댓글 신고</a></li>
											<li><a id="re_close" class="rClose">취소</a></li>
										</ul>
									</div>
								</div>
								</c:if>
							</div>
							</c:if>
						</c:forEach>
						</div>
					</c:if>
					</div>
					<!-- 댓글 전체 허용일 경우 -->
					<c:if test="${ f.fReplySet eq 'Y' }">
					<div id="reply">
						<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
						<input type="text" id="textArea" class="rContent" name="textArea">
						<input type="button" id="${f.fWriter }" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
					</div>
					</c:if>
					<!-- 댓글 친구 허용일 경우 -->
					<c:forEach var="fl" items="followerList">
					<c:if test="${ f.fReplySet eq 'F' }">
					<div id="reply">
						<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
						<input type="text" id="textArea" class="rContent" name="textArea">
						<input type="button" id="${f.fWriter }" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
					</div>
					</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 공개 여부가 비공개일 때 -->
		<c:if test="${ f.fOpenScope eq 'G' and loginUser.userId eq f.fWriter }">
			<div id="feed${ i }" class="feed">
			<div id="writer_submenu">
				<c:choose>
					<c:when test="${ loginUser.userId ne f.fWriter }">
						<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
						<c:if test="${ !empty f.mImage }">
						<img src="${ contextPath }/resources/memberProfileFiles/${ f.mImage }" alt="" id="feed_profile_img">
						</c:if>
						<c:if test="${ empty f.mImage }">
						<img src="${ contextPath }/resources/icons/pro_default.png" alt="" id="feed_profile_img">
						</c:if>
						<div id="user_time">
							<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
							<h6><c:out value="${ f.fModifyDate }" /></h6>
							<c:if test="${ f.fOpenScope eq 'G' }">
								<h6 id="osG">비공개</h6>
							</c:if>
							<c:if test="${ f.gNo ne 0 }">
							<c:url var="godetail" value="gdetail.do">
							<c:param name="gNo" value="${ f.gNo }"/>
							</c:url>
							<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
							</c:if>
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feedMenu">
					</c:when>
					<c:otherwise>
						<a href="goMypage.do?mNo=${ loginUser.mNo }">
						<c:if test="${ !empty loginUser.mRenameImage }">
						<img src="${ contextPath }/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="" id="feed_profile_img">
						</c:if>
						<c:if test="${ empty loginUser.mRenameImage }">
						<img src="${ contextPath }/resources/icons/pro_default.png" alt="" id="feed_profile_img">
						</c:if>
						<div id="user_time">
							<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
							<h6><c:out value="${ f.fCreateDate }" /></h6>
							<c:if test="${ f.fOpenScope eq 'G' }">
								<h6 id="osG">비공개</h6>
							</c:if>
							<c:if test="${ f.gNo ne 0 }">
							<c:url var="godetail" value="gdetail.do">
							<c:param name="gNo" value="${ f.gNo }"/>
							</c:url>
							<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
							</c:if>
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feedMenu">
					</c:otherwise>
				</c:choose>
				<c:if test="${ loginUser.userId ne f.fWriter }">
					<!-- 다른 회원 글 볼 때 피드 메뉴 -->
	 				<div class="pop_menu">
	 				<input type="hidden" id="fn" name="fn" class="fn" value="${ f.fNo }">
						<div id="feed_menu_list">
							<ul>
					            <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
					            <li><a id="share_feed" class="share_feed">공유하기</a></li>
					            <li><a id="goStorage" class="goStorage">보관함</a></li>
					            <li><a id="close" class="close">취소</a></li>
							</ul>
						</div>
					</div>
					<div class="storagePop">
					</div>
				</c:if>
				<c:if test="${ loginUser.userId eq f.fWriter }">
					<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
	                <div class="pop_menu">
	                    <div id="feed_Mymenu_list">
	                        <ul>
	                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
	                        <li><a href="pDelete.do?fNo=${ f.fNo }" class="deleteMyPost">삭제</a></li> 
	                        <li><a id="close" class="close">취소</a></li>
	                        </ul>
	                    </div>
	                </div>
				</c:if>
			</div>
		<div class="feed_report">
			<input type="hidden" value=${f.fNo }>
			<div id="feed_report_con">
				<p>신고사유</p>
				<select id="reportType" class="selectRtype">
					<option value="unacceptfeed" selected>부적절한 게시글</option>
					<option value="insult">욕설</option>
					<option value="ad">광고</option>
					<option value="spam">도배</option>
				</select>
				<textarea class="sendreport Rcontent" id="reportContent" cols="28"
					rows="4"></textarea>
				<br> <input class="selectRtype Rtype" id="selectRtype"
					type="button" value="확인" style="cursor: pointer;"> <input
					class="sendreport report-submit" type="button" id="report-submit"
					value="확인" style="cursor: pointer; display: none;">
				<button class="selectRtype cancel" id="cancel"
					style="cursor: pointer;">취소</button>
				<button class="sendreport cancel2" id="cancel2"
					style="cursor: pointer; display: none;">취소</button>
			</div>
			</div>
			<!-- 댓글을 신고해보자! -->
			<div class="reply_report" id="reply_report" style="display:none">
				<div id="Reply_report_con">
					<p>신고사유</p>
					<select id="reply_reportType" class="selectRtype">
						<option value="unacceptfeed" selected>부적절한 게시글</option>
						<option value="insult">욕설</option>
						<option value="ad">광고</option>
						<option value="spam">도배</option>
					</select>
					<textarea class="sendreport Rcontent" id="reply_reportContent" cols="28"
						rows="4"></textarea>
					<br> <input class="selectRtype Rtype" id="selectRtype"
						type="button" value="확인" style="cursor: pointer;"> <input
						class="sendreport reply_submit" type="button" id="reply_report-submit"
						value="확인" style="cursor: pointer; display: none;">
					<button class="selectRtype cancel" id="cancel"
						style="cursor: pointer;">취소</button>
					<button class="sendreport cancel2" id="cancel2"
						style="cursor: pointer; display: none;">취소</button>
				</div>
			</div>
			<div id="con">
				<div id="feed_content">
					<c:if test="${ !empty f.photoList }">
						<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
						<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
						<ul id="imgList" style="height:633px">
							<c:forEach var="p" items="${ f.photoList }">
							<c:if test="${ p.changeName ne null }">
								<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
							</c:if>
							</c:forEach>
						</ul>
					</c:if>
						<%-- 
						<p id="text">
						<c:out value="${ f.fContent }" />
						</p>
						--%>
					<div id="text">
					${ f.fContent }
					</div>
	
					<div id="heart_reply">
					<!-- 좋아요 금지가 되어 있지 않을 경우 -->
					<c:if test="${ f.fLikeSet eq 'Y' }">
					<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
	             	<c:choose>
		             	<c:when test="${ f.likeChk eq null }">
		             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
		             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }</label>
		             	</c:when>
		             	<c:otherwise>
		             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">	             	
			               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }</label>
		             	</c:otherwise>
	             	</c:choose>
					</c:if>
	               		<input type="hidden" class="toNo" value="${ f.fNo }">
	               		<input type="hidden" class="toId" value="${ f.fWriter }">
	               		<!-- 댓글이 전체 허용일 경우 -->
						<c:if test="${ f.fReplySet eq 'Y' || f.fReplySet eq 'F' }">
						<c:choose>
							<c:when test="${ f.fLikeSet eq 'N' }">
							<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
							<label class="replycnt_p">${ f.fReplyCnt }</label>
							</c:when>
							<c:otherwise>
							<!-- 댓글과 좋아요 모두 허용될 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
							<label class="replycnt_p">${ f.fReplyCnt }</label>
							</c:otherwise>
						</c:choose>
						</c:if>
	
						<c:if test="${ f.fReplySet eq 'N' && f.fLikeSet eq 'N' }">
							<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
						</c:if>
	           		</div>
				</div>
				
				<div id="replyArea">
					<div id="replyList" style="display: block; height: fit-content;">
					<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
					<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
					<c:if test="${ f.fReplyCnt ne 0 }">
						<div id="replySub" style="display: block; height: 150px; overflow: auto;">
						<c:forEach var="r" items="${ f.replyList }">
							<c:if test="${ r.rStatus eq 'Y' }">
							<div id="selectOne">
							<!-- 댓글 번호 -->
							<input type="hidden" class="rNum" value="${ r.rNo }">
				  				<ul id="re_list" class="list">
				  				<c:if test="${ !empty r.rWriterImg }">
									<li><img src="${ contextPath }/resources/memberProfileFiles/${ r.rWriterImg }" alt=""
										id="reply_img">&nbsp;&nbsp;&nbsp;
										<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
								</c:if>
								<c:if test="${ empty r.rWriterImg }">
									<li><img src="${ contextPath }/resources/icons/pro_default.png" alt=""
										id="reply_img">&nbsp;&nbsp;&nbsp;
										<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
								</c:if>
									<li><textarea id="replyCon" class="rCon" data-autoresize readonly required="required" placeholder="댓글을 입력해 주세요." cols=40 rows=auto disabled><c:out value="${ r.rContent }" /></textarea>
									<input type="button" id="confirmR" class="rConfirm" value="완료"></li>
									<li><p id="time"><c:out value="${ r.rModifyDate }" /></p></li>
									<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn" class="rUpBtn"></li>
								</ul>
								<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
								<c:if test="${ loginUser.userId eq r.rWriter }">
								<div id="reply_menu" class="reply_menu">
									<div id="re_menu_list">
										<ul>
											<li><a id="rEdit" class="rEdit">댓글 수정</a></li>
											<li><a class="rDelete">댓글 삭제</a></li>
											<li><a id="re_close" class="rClose">취소</a></li>
										</ul>
									</div>
								</div>
								</c:if>
								<!-- 다른 사람이 단 댓글 볼 때 메뉴 -->
								<c:if test="${ loginUser.userId ne r.rWriter }">
								<div id="reply_menu" class="reply_menu">
									<div id="re_menu_list">
										<ul>
											<li><a href="goUserpage.do?userId=${ r.rWriter }&mNo=${ r.mNo }" class="rGoFeed">피드 가기</a></li>
											<li><a id="rReport" class="rReport">댓글 신고</a></li>
											<li><a id="re_close" class="rClose">취소</a></li>
										</ul>
									</div>
								</div>
								</c:if>
							</div>
							</c:if>
						</c:forEach>
						</div>
					</c:if>
					</div>
					<!-- 댓글 전체 허용일 경우 -->
					<c:if test="${ f.fReplySet eq 'Y' }">
					<div id="reply">
						<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
						<input type="text" id="textArea" class="rContent" name="textArea">
						<input type="button" id="${f.fWriter }"class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
					</div>
					</c:if>
				</div>
			</div>
		</div>
	</c:if>
	</c:forEach>

	<div id="footer"><p>GROOBEE © 2020</p></div>
	</div>
    <script>
    // 리프래시 이벤트
    function refresh(){
		location.reload();
	}
    
	$('.likeicon').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	});
	$('.replyUpBtn').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	});
	$('.feedMenu').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	});
	$('.rUpBtn').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	}); 	
	$('.feedMenu').on("click", function(event){
	    var sample = $(event.target).siblings()[1];
	    $(sample).show();
	    console.log($(event.target).siblings()[1]);
	});
/* 	$(document).on("click", '.feedMenu', function(event){
	    var sample = $(event.target).siblings()[1];
	    $(sample).show();
	}); */
    $('.close').on('click', function(){
        $('.pop_menu').hide();
    });
    $('.close').on('click', function(){
        $('.pop_Mymenu').hide();
    });
    $('.cancel').on("click", function(){
        $('.feed_report').hide();
    });
    
    $('.cancel').on("click", function(){
        $('.reply_report').hide();
    });
    
    $('.rUpBtn').on("click", function(event){
//  	  var btn = $(event.target).parents("div#replyArea").find("div#reply_menu");
      var btn = $(event.target).parent('li').parent('ul').next('div#reply_menu')
	  $(btn).show();
    });
    $('.rClose').on("click", function(){
        $('.reply_menu').hide();
	});
    $('.deleteMyPost').on('click', function () {
		if(confirm("이 포스트를 정말 삭제하시겠습니까?") == false) {
			return false;
		}	
    });
    $('.rEdit').on("click", function(e) {
		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");

		repCon.css('border', '1px solid #555555');
  	  	repCon.removeAttr('disabled');
  	  	repCon.removeAttr('readonly');
  	  	repBtn.css('display', 'block');
  	  	$('.reply_menu').hide();
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
        	} else if(ul == 0) {
        		$('#nextBtn'+i).nextAll('#imgList').css("display","none");
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
 			
	/**************** 댓글 등록 ****************/
	$(function() {
		
		$(".replyUpBtn").on("click", function(event) {
			var rContent = event.target.parentElement.children[1].value;
			var rfNo = event.target.parentElement.children[0].value;
			var rWriter = "<%= ((Member)session.getAttribute("loginUser")).getUserId() %>";
			var fWriter = event.target.id;
			$.ajax({
				url: "addReply.do",
				data: {
					rContent: rContent,
					rfNo: rfNo,
					rWriter: rWriter
				},
				type: "post",
				success: function(data) {	// 성공 시: success, 실패 시: fail
					if(data != "fail") {
						$(rContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
						location.reload();
					}
				}, error: function() {
					console.log("전송 실패");
				}
			});
			
			if(rContent == "") {
				alert("댓글을 입력해 주세요.");
				return false;
			}
			
			var ok = confirm("댓글을 등록하시겠습니까?");
         	console.log(ok);
         	if(ok){
        	sendAlram("상관없음",fWriter,"reply",rfNo);
        	console.log("상관없음",fWriter,"reply",rfNo+"테스트");
         }
	});

	// 댓글 수정 시 완료 버튼
 	$('.rConfirm').on("click", function(e) {
		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
		var rWriter = "<%= ((Member)session.getAttribute("loginUser")).getUserId() %>";
		var replyContent = e.target.previousElementSibling.value;
		
			$.ajax({
				url: "editReply.do",
				data: {
					rContent: replyContent,
					rNo: rNo,
					rWriter: rWriter
				},
				type: "post",
				success: function(data) {	// 성공 시: success, 실패 시: fail
					console.log(data);
 					if(data != "fail") {
						location.reload();
					}
				}, error: function() {
					console.log("전송 실패");
				}
			});
			
		if(confirm("댓글을 수정하시겠습니까?") == false) {
			return false;
		}	
		
	});
	
	// 댓글 삭제 시
 	$('.rDelete').on("click", function(e) {
		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
		var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
		var rWriter = "<%= ((Member)session.getAttribute("loginUser")).getUserId() %>";
		var none = $(this.parentElement).parents("div#replySub").children.length;
		var rMenu = $(this.parentElement).parents("div#selectOne").find("div#reply_menu");
		var fLoad = $(this.parentElement).parents("div.feed");
		
		$.ajax({
			url: "deleteReply.do",
			data: {rNo: rNo},
			type: "post",
			success: function(data) {	// 성공 시: success, 실패 시: fail
  				if(data == "success") {
					location.reload();
				}
			}, error: function() {
				console.log("전송 실패");
			}
		});
		
		// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
		if(none == 0) {
			$(this.parentElement).parents("div#replySub").css('display', 'none');
		}
		
		if(confirm("댓글을 삭제하시겠습니까?") == false) {
			return false;
		}
	});
	
	});
	
 	// 좋아요 알람
	$(".likeIcon").on('click',function(e){
		console.log("likeicon 클릭");
		console.log($(e.target).parent().children('.likeIcon')[0].id);
		var toId = $(e.target).parent().children('.toId').val();
		var toNo = $(e.target).parent().children('.toNo').val();   
		var fromId = '${loginUser.userId}';
		
		if($(e.target).parent().children('.likeIcon')[0].id == 'likeIcon'){
			$(e.target).attr('src','/spring/resources/icons/heart_red.png');
			$(e.target).attr('id','liked');				
			sendAlram("상관없음",toId,"like",toNo);
			var test = $("#"+e.target.name).text();
			test *= 1;
			test = test + 1;
			$("#"+e.target.name).text(test)
			
			$.ajax({
				url: "likeCount.do",
				data : {fNo : toNo,
						type : 'up',
						userId : 'null'},
				success : function(data){
					console.log(data + "좋아요 카운트 up 성공");
				}
			});
		}else{
			$.ajax({
				url: "likeCount.do",
				data : {fNo : toNo,
						type : 'down',
						userId : fromId},
				success : function(data){
					console.log(data + "좋아요 카운트 down 성공");
				}
			});
			$(e.target).attr('src','/spring/resources/icons/heart.png');
			$(e.target).attr('id','likeIcon');
			var test = $("#"+e.target.name).text();
			test *= 1;
			test = test - 1;
			$("#"+e.target.name).text(test)
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
 	
 	
 	/***** 피드 신고하기 *****/
 	
    $('.feed_report_btn').on("click", function(e){
    	var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
    	$(feedReport).show();
//        $('.feed_report').show();
    });
			     
		$(document).on('click', ".report-submit", function(e){
			var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
			var reportCon = e.target.previousElementSibling.previousElementSibling.previousElementSibling;
			var targetfNo=$(this).parent().prev().val();
			
			var text =$(this).prev().prev().prev().val();
			if(text == ""){
				alert('신고 사유를 입력해 주세요.')
			}else{
				
				$.ajax({
					url:'reportFInsert.do',
					data:{
						reportType : $("#reportType").val(),
						feedType : "feed",
						content : text,
						targetfNo:targetfNo
					},
					success: function(){
						$(feedReport).css('display', 'none');
						$(".selectRtype").css("display", "inline-block");
			      		$(".sendreport").css("display", "none");
			      		$(reportCon).val('')
						alert('신고 완료');
			      		refresh();
					},error:function(){
						alert('신고 실패!');
					}
				});
				
			};
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
	
	/* 스크롤 맨위로 올리기 */
	$(function(){
		$("#feedArea").scroll(function(){
			var st = $("#feedArea").scrollTop();
			if(st > 0) {
				$("#topScrollBox").show();
			} else if(st == 0) {
				$("#topScrollBox").hide();
			}
		});
		
		$("#topScrollBtn").on("click",function(){
			$("#feedArea").animate( { scrollTop : 0 }, 400 );
			return false;
		});
	});
	
<%-- 	// 해시태그 클릭하면 해시태그 검색하기
	$(document).on("click",".hashTag",function(){
		var keyword=$(this).text().substr(1,this.length); // #태그 분리 및  value 뽑아내기
		var mno = "<%= ((Member)session.getAttribute("loginUser")).getmNo() %>";
		console.log(keyword);
		location.href="search.do?type=tag&key="+keyword+"&mNo="+mno;
		
	}); --%>
	/*@유저 아이디 클릭이벤트*/
	function goUser(){
    	var id = $(event.target).attr('id')
    	location.href ='goUserpage.do?userId='+id+'&mNo='+${ loginUser.mNo };
    }
    /*#태그 이벤트*/
    function goTag(htag) {
    	var tag = $(htag).text();
    	console.log('검색하는 단어'+tag.substr(1));
    	location.href="search.do?type=tag&key="+tag.substr(1)+"&mNo="+${ loginUser.mNo };
	}
    
	$(function(){
		
		$('.share_feed').on("click",function(){
			var fNo = $(this).parents().children('.fn').val();
			console.log(fNo);
			
			$.ajax({
				url:"shareFeed.do",
				data:{ fNo:fNo, mNo:${ loginUser.mNo} },
				type:"post",
				success:function(data){
					if( data > 0){
						alert("게시글을 공유하였습니다.");
						$('.pop_menu').hide();
					}
				},error:function(){
					alert("이미 공유하신 게시글이거나, 공유에 실패하였습니다.");
				}
			});
		});
	});
	
	$(function(){
		$('.goStorage').on("click",function(){
			var mNo = ${ loginUser.mNo};
			var fNo = $(this).parents().children('.fn').val();
			var pop = $(this).parents().children('div.storagePop');
			console.log(pop);
			console.log(mNo);
			$.ajax({
				url:"selectStorage.do",
				data:{ mNo:mNo},
				dataType:"json",
				success:function(data){
					$('.pop_menu').hide();
			        $('.pop_Mymenu').hide();
					$divAll = $('.storagePop');
					$divAll.html("");
					
						var $input = $('<input type="hidden" id="in_fno" class="in_fno" value="'+fNo+'">')
						var $div = $('<div class="storagePop_menu" id="storagePop_menu" style="background: white; width: 320px; margin: auto; height: 210px; border-radius: 15px; margin-top:300px;">');
						var $p = $('<p id="sbText" style="text-align:center; padding:20px 0 20px 0; border-bottom:1px solid #ccc; color:#555555; font-weight:600">').text("보관함");
						var $p2 = $('<p id="sbText2" style="color:#555555; font-size:14px; text-align:center; padding:20px 0 20px 0">').text("보관함을 선택해주세요.")
						var $select = $('<select id="sbSel" style="width:140px; height:32px; border-radius:10px; margin:0 10px 0 40px">');
						for(var i=0; i < data.length; i++){
							$select.append('<option id="op" value="'+data[i].sbNo+'">'+data[i].sbName+"</option>");
						}
						var $button = $('<input type="button" id="insertStorage" class="insertStorage" value="확인" style="width:80px; height:32px; border:0; border-radius:10px; background:#daf4ed">');	
						var $cancelbtn =$('<input type="button" id="storageClose" class="storageClose" value="취소" style="width: 150px; height:32px; border:0; border-radius:10px; background:#daf4ed; margin: 10px 0 0 80px;">'); 
						
						$div.append($p);
						$div.append($p2);
						$div.append($select);
						$div.append($button);
						$div.append($cancelbtn);
						$divAll.append($input);
						$divAll.append($div);

						pop.css("display","block");
				},error:function(){
						alret("보관함 리스트 불러오기 실패");
				}
			});
			
			$(document).on("click",".storageClose",function(){
					$('.storagePop').hide();
				});
			
			$(document).on("click",".insertStorage",function(){

				
				var fNo = $(this).parents().children('.in_fno').val();
				console.log(fNo);
				var mNo = ${ loginUser.mNo};
				var sbNo = $(this).prev('select').children('option:selected').val();
				var sbName = $(this).prev('select').children('option:selected').text();
				console.log(sbNo);
				console.log(sbName);
				$.ajax({
					url:"insertStorage.do",
					data:{ fNo:fNo,mNo:mNo,sbNo:sbNo,sbName:sbName },
					type:"post",
					success:function(data){
						if(data > 0){
							alert("게시글을 보관함에 넣었습니다.");
						}else if(data ==0){
							alert("게시글이 이미 보관되어 있습니다.");
						}
						$('.storagePop').hide();
						$('.pop_menu').hide();
					},error:function(){
						alert("보관함에 이미 게시글이 있거나, 보관함에 넣기 실패하였습니다.");
					}
				});
			});
		});
	});
    
    </script>
    
</body>
</html>
