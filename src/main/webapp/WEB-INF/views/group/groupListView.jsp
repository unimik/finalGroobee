<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
	<link href="<%=request.getContextPath()%>/resources/css/groupMain.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	#cancel2{outline:none; margin-left: 16px; margin-top:-4px;cursor: pointer;display: block;width: 100px; background:#e5e5e5;border: none;border-radius: 10px;width:100px;height: 35px;float: left;}
	button{ cursor: pointer; }
	.usertag {color: #47c6a3;}
	<%--해쉬태그 색을 바꿔주세요...--%>
	.hashtag{color:#88abda;}
</style>
</head>
<body>
<c:import url="../common/menubar.jsp"/>
		<input type="button" id="create_group" name="create_group" value="그룹생성">
		<div class="gListopen">
                <ul>
                    <li>All Group List</li>
                    <li><a id="showList">보기</a></li>
                </ul>
        </div>
		<c:if test="${ !empty glist }">
		<div id="groupAllList">
	       <c:forEach var="g" items="${ glist }">
	       <c:url var="gdetail" value="gdetail.do">
				<c:param name="gNo" value="${ g.gNo }"/>
		   </c:url>
	       <div id="groupBox">
	       <a href="${ gdetail }">
	       	   <c:if test="${ !empty g.gImage }">
	       	   		<img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameImage }" id="groupBack">
	       	   </c:if>
	       	   <c:if test="${ empty g.gImage }">
	           		<img src="<%=request.getContextPath()%>/resources/images/g_back.png" id="groupBack">
	           </c:if>
	           <c:if test="${ !empty g.gProfile }">
	           		<img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameProfile }" id="groupProfile">
	           </c:if>
	           <c:if test="${ empty g.gProfile }">
	           		<img src="<%=request.getContextPath()%>/resources/icons/g_pro.png" id="groupProfile">
	           </c:if>
	           <p id="groupName">${ g.gName }</p>
	           <p id="gcategoryName">${ g.gCategory }</p>
	       </a>
	       </div>
	       </c:forEach>
		</div>
		</c:if>
		
		
	<div id="feedArea">
		<c:forEach var="f" items="${ flist }" varStatus="status">
			<c:set var="i" value="${ i + 1 }"/>
			<!-- 공개 여부가 비공개가 아닐 때 (전체 공개, 친구 공개) -->
			<c:if test="${ f.fOpenScope ne 'G' }">
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
							<c:url var="godetail" value="gdetail.do">
							<c:param name="gNo" value="${ f.gNo }"/>
							</c:url>
							<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
					</c:when>
					<c:otherwise>
						<a href="goMypage.do?mNo=${ loginUser.mNo }">
						<c:if test="${ !empty f.mImage }">
						<img src="${ contextPath }/resources/memberProfileFiles/${ f.mImage }" alt="" id="feed_profile_img">
						</c:if>
						<c:if test="${ empty f.mImage }">
						<img src="${ contextPath }/resources/icons/pro_default.png" alt="" id="feed_profile_img">
						</c:if>
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
					</c:otherwise>
				</c:choose>
					<c:choose>
						<c:when test="${ loginUser.userId ne f.fWriter }">
						<!-- 다른 회원 글 볼 때 피드메뉴 -->
						<div class="pop_menu" id="pop_menu${ i }">
						<input type="hidden" id="fn" name="fn" class="fn" value="${ f.fNo }">
							<div id="feed_menu_list">
							    	<ul>
							       	   <li><a href="${ godetail }">그룹보기</a></li>
							           <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
							           <li><a id="share_feed" class="share_feed">공유하기</a></li>
							           <li><a id="goStorage" class="goStorage">보관함</a></li>
							           <li><a id="close" class="close">취소</a></li>
							        </ul>
							</div>
						</div>
						<div class="storagePop">
						</div>
						</c:when>
						<c:otherwise>
						<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
						<div class="pop_Mymenu">
						    <div id="feed_Mymenu_list">
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
					<div class="feed_report">
						<input type="hidden" value="${f.fNo }"/>
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
						
					 <%-- <p id="text"><c:out value="${ f.fContent }" /></p> --%>
					<div id="text">
					${ f.fContent }
					</div>
					<div id="heart_reply">
					<!-- 좋아요 금지가 되어 있지 않을 경우 -->
					<c:if test="${ f.fLikeSet == 'Y' || empty f.fLikeSet }">
					<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
	             	<c:choose>
		             	<c:when test="${ f.likeChk eq null }">
		             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
		             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
		             	</c:when>
		             	<c:otherwise>
		             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">	             	
			               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
		             	</c:otherwise>
	             	</c:choose>
					</c:if>
	               		<input type="hidden" class="toNo" value="${ f.fNo }">
	               		<input type="hidden" class="toId" value="${ f.fWriter }">
	               		<!-- 댓글이 전체 허용일 경우 -->
						<c:if test="${ f.fReplySet eq 'Y' || f.fReplySet eq 'F' || empty f.fReplySet }">
						<c:choose>
							<c:when test="${ f.fLikeSet eq 'N' }">
							<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
							<% int rCount = 0; %>
							<c:forEach var="rC" items="${ f.replyList }">
								<c:if test="${ rC.rStatus eq 'Y' }">
									<% ++rCount; %>
								</c:if>
							</c:forEach>
							<label class="replycnt_p"><%= rCount %>개</label>
							</c:when>
							<c:otherwise>
							<!-- 댓글과 좋아요 모두 허용될 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
							<% int rCount = 0; %>
							<c:forEach var="rC" items="${ f.replyList }">
								<c:if test="${ rC.rStatus eq 'Y' }">
									<% ++rCount; %>
								</c:if>
							</c:forEach>
							<label class="replycnt_p"><%= rCount %>개</label>
							</c:otherwise>
						</c:choose>
						</c:if>
	
						<c:if test="${ f.fReplySet eq 'N' && f.fLikeSet eq 'N' }">
							<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
						</c:if>
	           		</div>
				</div>
				<div id="replyArea">
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
					<div id="replyList" style="display: block; height: fit-content;">
					<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
					<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
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
					</div>
					<!-- 댓글 전체 허용일 경우 -->
					<c:if test="${ f.fReplySet eq 'Y' || empty f.fReplySet }">
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
	   </c:forEach>
	   <!-- 공개 여부가 비공개일 때 -->
		<c:if test="${ f.fOpenScope eq 'G' }">
			<c:if test="${ loginUser.userId eq f.fWriter }">
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
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="test">
					</c:when>
					<c:otherwise>
						<a href="goMypage.do?mNo=${ loginUser.mNo }">
						<c:if test="${ !empty f.mImage }">
						<img src="${ contextPath }/resources/memberProfileFiles/${ f.mImage }" alt="" id="feed_profile_img">
						</c:if>
						<c:if test="${ empty f.mImage }">
						<img src="${ contextPath }/resources/icons/pro_default.png" alt="" id="feed_profile_img">
						</c:if>
						<div id="user_time">
							<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
							<h6><c:out value="${ f.fCreateDate }" /></h6>
						</div>
						</a>
						<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="test">
					</c:otherwise>
				</c:choose>
				<c:if test="${ loginUser.userId ne f.fWriter }">
					<!-- 다른 회원 글 볼 때 피드 메뉴 -->
	 				<div class="pop_menu">
						<div id="feed_menu_list">
							<ul>
					            <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
					            <li><a id="share_feed" class="share_feed">공유하기</a></li>
					            <li><a id="goStorage" class="goStorage">보관함</a></li>
					            <li><a id="close" class="close">취소</a></li>
							</ul>
						</div>
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
			<input type="hidden" value="${f.fNo}" class="feedNo"/>
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
					 <%-- <p id="text"><c:out value="${ f.fContent }" /></p> --%>
					<div id="text">
					${ f.fContent }
					</div>
					<div id="heart_reply">
					<!-- 좋아요 금지가 되어 있지 않을 경우 -->
					<c:if test="${ f.fLikeSet eq 'Y' || empty f.fLikeSet }">
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
						<c:if test="${ f.fReplySet eq 'Y' || empty f.fReplySet }">
						<c:choose>
							<c:when test="${ f.fLikeSet eq 'N' }">
							<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
								<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
									<label class="replycnt_p">${ f.replyList.size() }개</label>
								</c:if>
								<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
									<label class="replycnt_p">0개</label>
								</c:if>
							</c:when>
							<c:otherwise>
							<!-- 댓글과 좋아요 모두 허용될 때 -->
							<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
								<c:forEach var="r" items="${ f.replyList }">
								<c:if test="${ r.rStatus eq 'Y' }">
									<label class="replycnt_p">${ f.replyList.size() }개</label>
								</c:if>
								<c:if test="${ r.rStatus eq 'N' || empty r.rStatus }">
									<label class="replycnt_p">0개</label>
								</c:if>
								</c:forEach>
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

					</div>
					<!-- 댓글 전체 허용일 경우 -->
					<c:if test="${ f.fReplySet eq 'Y' || empty f.fReplySet }">
					<div id="reply">
						<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
						<input type="text" id="textArea" class="rContent" name="textArea">
						<input type="button"  id="${f.fWriter }"class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
					</div>
					</c:if>
				</div>
			</div>
		</div>
		</c:if>
	</c:if>
	<script>
	
	$('.likeicon').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	});
	$('.replyUpBtn').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	});
	$('.rUpBtn').mouseenter(function() {
		$(this).css('cursor', 'pointer')
	});
	
		function refresh(){
			location.reload();
		}	
		
		$('#create_group').click(function(){
			location.href="gInsertView.do";
		});
		
		$('#showList').on('click',function(){
	        if( $('#showList').text() == '보기'){
	            $('#groupAllList').show();
	            $('#showList').text('닫기');
	        }else{
	            $('#groupAllList').hide();
	            $('#showList').text('보기');
	        }
	    });
		
		$(document).ready(function(e){
		
			var count = $(".feed").length;
		
			for(var i = 1; i <= count; i++){
				console.log('.feed_menu'+i);
				 $('.feed_menu'+i).on("click",function(){
			         $(this).nextAll('div .pop_menu').show();
			         $(this).nextAll('div .pop_Mymenu').show();
			     });
				 
				$('.feed_menu'+i).mouseenter(function() {
				$(this).css('cursor', 'pointer')
				});
				 
				  $('.close').on("click",function(){
			         $('.pop_menu').hide();
			         $('.pop_Mymenu').hide();
			     });
				  
				  
				  $('.feed_report_btn').on("click",function(){
		                $(this).parents().children('.feed_report').show();
		                /* var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.nextElementSibling.nextElementSibling;
		                console.log(feedReport);
		                $(feedReport).show(); */
		               });
				 
			 	
			}
			     
			$(document).on('click',".report-submit",function(){
				//var feedReport = e.target.parentElement.parentElement;
				//var reportCon = e.target.parentElement.parentElement.children[0].children[2];
				$(".pop_menu").css("display","none");
				
				var reportContent= $(this).siblings("#reportContent").val();
				var reportType=$(this).siblings("#reportType").val();
				
				var targetfNo=$(this).parents().prev().val(); // fNo 불러오기
				
				
				if($("#reportType").val() == ""){
					alert('신고 사유를 입력해 주세요.')
				}else{
					
					$.ajax({
						url:'reportFInsert.do',
						data:{
							reportType : reportType,
							feedType : "feed",
							content : reportContent,
							targetfNo:targetfNo
						},
						success: function(){
							$(".feed_report").css('display','none');
							$(".selectRtype").css("display","inline-block");
				      		$(".sendreport").css("display","none");
				      		$("#reportContent").val('')
							alert('신고완료');
						},error:function(){
							alert('신고 실패!');
						}
					});
					
				};
			});
	   	 
		   	$(".cancel2").on("click",function(e){
		   		var feedReport = e.target.parentElement.parentElement;
		   		$(feedReport).css('display','none');
				$(".selectRtype").css("display","inline-block");
		   		$(".sendreport").css("display","none");
		   	});
		   	
		   	$(".Rtype").on("click",function(){
		   		$(".selectRtype").css("display","none");
		   		$(".sendreport").css("display","block");
		   	});        
		   	
		   	$('.cancel').on("click", function(e){
		   		var feedReport = e.target.parentElement.parentElement;
		 		$(feedReport).hide();
		 	});
		});	
		
		$('.rUpBtn').on("click", function(event){
//	  	  var btn = $(event.target).parents("div#replyArea").find("div#reply_menu");
	      var btn = $(event.target).parent('li').parent('ul').next('div#reply_menu')
		  $(btn).show();
	    });
	    $('.rClose').on("click", function(){
	        $('.reply_menu').hide();
	    });
	    $('.deleteMyPost').on('click', function () {
	    	confirm('이 포스트를 정말 삭제하시겠습니까?');
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
							alret("보관함리스트 불러오기 실패");
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
								alert("게시글이 이미 보관되어있습니다.");
							}
							$('.storagePop').hide();
							$('.pop_menu').hide();
						},error:function(){
							alert("보관함에 이미 게시글이 있거나, 보관함에 넣기 실패하였습니다.");
						}
					});
				});
			});
		})
	
		
	/**************** 댓글 등록 ****************/
			$(function() {
				
				$(".replyUpBtn").on("click", function(event) {
					var rContent = event.target.parentElement.children[1].value;
					var rfNo = event.target.parentElement.children[0].value;
					var rWriter = "${ loginUser.userId }";
					
					$.ajax({
						url: "addReply.do",
						data: {
							rContent: rContent,
							rfNo: rfNo,
							rWriter: rWriter
						},
						type: "post",
						success: function(data) {	// 성공 시: success, 실패 시: fail
							if(data == "success") {
								$(rContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
								location.href="glist.do?userId="+rWriter;
							}
						}, error: function() {
							console.log("전송 실패");
						}
					});
					
					var ok = confirm("댓글을 등록하시겠습니까?");
		         	console.log(ok);
		         	if(ok){
		         	console.log(오케이);
		        	sendAlram("상관없음",fWriter,"reply",rfNo); 
		        	console.log("상관없음",fWriter,"reply",rfNo+"테스트");
//		        	alert('stop');
		         }
			});

			// 댓글 수정 시 완료 버튼
		 	$('.rConfirm').on("click", function(e) {
		/* 		var rContent = e.target.parentElement.children[1].value; */
				var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
//				var rNo = e.target.parentElement.parentElement.parentElement.parentElement.previousElementSibling.children[0].children[0].value;
				var rWriter = "${ loginUser.userId }";
				
				var replyContent = e.target.previousElementSibling.value;
//				var replyContent = e.target.parentElement.parentElement.parentElement.previousSibling.parentElement.children[0].children[0].children[1].innerText;
//				var replyDiv = e.target.parentElement.parentElement.parentElement.parentElement;
				
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
		 					if(data == "success") {
//								$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
//								location.href="home.do?userId=" + rWriter;
								location.reload();
							}
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
				var rWriter = "${ loginUser.userId }";
				var none = $(this.parentElement).parents("div#replySub").children.length;
				
				$.ajax({
					url: "deleteReply.do",
					data: {rNo: rNo},
					type: "post",
					success: function(data) {	// 성공 시: success, 실패 시: fail
//						console.log(data);
		  				if(data == "success") {
//							$(ul).css('display', 'none');
							$('.rNum').css('display', 'none');
//							location.href="home.do?userId=" + rWriter;
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
				
				confirm("댓글을 삭제하시겠습니까?");
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
		 		$(this).parents('#reply_menu').hide();
		 		$(this).parents().children(".reply_report").css("display","block");
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
	/*@유저아이디 클릭이벤트 */
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