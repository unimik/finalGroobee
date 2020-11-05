<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>groupMain</title>
	<link href="<%=request.getContextPath()%>/resources/css/groupMain.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
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
	<script>
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
	</script>
	<div id="feedArea">
		<c:if test="${ !empty flist }">
		<c:forEach var="f" items="${ flist }" varStatus="status">
			<c:set var="i" value="${ i + 1 }"/>
			<div id="feed${ i }" class="feed">
				<div id="writer_submenu">
					<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
					<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
					<div id="user_time">
						<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
						<h6><c:out value="${ f.fCreateDate }" /></h6>
					</div>
					</a>
					<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="test">
	                     
	            <c:choose>
				<c:when test="${ loginUser.userId ne f.fWriter }">
		            <!-- 다른 회원 글 볼 때 피드메뉴 -->
		            <div class="pop_menu">
		                <div id="feed_menu_list">
		                    <ul>
		                       <li><a href="../views/groupDetail.html">그룹보기</a></li>
		                       <li><a id="feed_report_btn">신고</a></li> 
		                       <li><a>공유하기</a></li> 
		                       <li><a>보관함</a></li> 
		                       <li><a id="close">취소</a></li>
		                    </ul>
		                </div>
		            </div>
		        </c:when>
				<c:otherwise>
					<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
	                <div class="pop_menu">
	                    <div id="feed_Mymenu_list">
	                        <ul>
	                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
	                        <li><a>삭제</a></li> 
	                        <li><a id="close" class="close">취소</a></li>
	                        </ul>
	                    </div>
	                </div>
				</c:otherwise>
			</c:choose>
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
	                    </ul>
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
	                    남이 단 댓글 볼 때 댓글 메뉴
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
	
</body>
</html>