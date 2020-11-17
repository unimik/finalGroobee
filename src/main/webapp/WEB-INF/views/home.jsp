<%@page import="com.kh.spring.feed.model.vo.Photo"%>
<%@page import="com.kh.spring.feed.model.vo.Feed"%>
<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	#imgList{position:relative; margin:0; padding:0; height:633px; list-style:none; overflow-x:hidden;}
	#imgList li{ display:none; float:left; position: absolute; top:0; left:0;}
	#imgList li:nth-child(1){ display:block;}
	#imgList img{ width: 633px; height:633px; }
	.imgbtn{ z-index:5;border: 0; background: none; cursor: pointer;outline:none;}
	button[name=nextBtn]{display:none; position: absolute; margin: 300px 570px; }
	button[name=prevBtn]{display:none; position: absolute; margin: 300px 20px; }
	#replyList{ width: 100%; height: 0px; }
	#replySub::-webkit-scrollbar{ width: 7px;}
	#replySub::-webkit-scrollbar-thumb{ border-radius: 10px; background-color: #47c6a3; }
	#replySub::-webkit-scrollbar-track{ background-color: #daf4ed;}
	#rCount{ width: fit-content; font-size: 10pt; position: absolute; left: 100px; top: 75px; }
	#re_list li:nth-child(2){ width: 55%; margin-bottom: 20px; height: fit-content; }
	#replyCon{ width: 55%; resize: none; line-height: 12pt; white-space: pre-line;
			   inline-size: fit-content; border: none; font-size: 9pt; float: left; overflow: hidden; }
	#userId{ margin: 9px 10px 0 10px; }
	#time{ width: 100%; }
	#rWriterInfo{ width: 25%; }
	#rUpdateMenu{ width: 10%; }
	#confirmR{ display: none; float: left; margin: 10px; float: left; }
</style>

</head>
<body>
	<c:import url="common/menubar.jsp" />
	<div id="feedArea">
	<c:forEach var="f" items="${ feed }" varStatus="status">
		<c:set var="i" value="${ i + 1 }"/>
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
		<c:choose>
			<c:when test="${ loginUser.userId ne f.fWriter }">
				<!-- 다른 회원 글 볼 때 피드메뉴 -->
<!-- 				<div class="pop_menu">
					<div id="feed_menu_list">
						<ul>
							<li><a id="feed_report_btn">신고</a></li>
							<li><a>공유하기</a></li>
							<li><a>보관함</a></li>
							<li><a id="close">취소</a></li>
						</ul>
					</div>
				</div> -->
			</c:when>
			<c:otherwise>
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
			</c:otherwise>
		</c:choose>
	</div>
			<div class="feed_report">
			<div id="feed_report_con">
				<p>신고사유</p>
				<select style=>
					<option>부적절한 게시글</option>
					<option>욕설</option>
					<option>광고</option>
					<option>도배</option>
				</select> <br> <input type="button" id="submit" name="submit"
					value="확인">
				<button id="cancel">취소</button>
			</div>
		</div>
		<div id="con">
			<div id="feed_content">
					<c:if test="${ !empty f.photoList }">
						<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
						<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
						<c:forEach var="p" items="${ f.photoList }">
						<c:if test="${ p.changeName ne null }">
							<ul id="imgList">
								<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
							</ul>
						</c:if>
						</c:forEach>
					</c:if>
				<div id="heart_reply">
					<img src="${ contextPath }/resources/icons/heart.png" alt="" class="likeIcon" id="likeIcon">
					<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
					<input type="hidden" class="toNo" value="${f.fNo}">
					<input type="hidden" class="toId" value="${f.fWriter}">
				</div>
				<p id="text"><c:out value="${ f.fContent }" /></p>

			</div>
			<div id="replyArea">
				<div id="replyList" style="display: block; height: fit-content;">
				
				<c:set var="reply" value="${ f.replyList }"/>
				<!-- 나중에 f.fReplyCnt > 0 로 수정 -->
				<c:if test="${ !empty reply }">
				<div id="replySub" style="display: block; height: 150px; overflow: auto;">
				<c:forEach var="r" items="${ f.replyList }">
				<input type="hidden" class="rNum" value="${ r.rNo }">	<!-- 댓글 번호 -->
				<c:if test="${ !empty r.rContent }">
				<c:set var="i" value="${ i + 1 }"/>
	  				<ul id="re_list" class="list${ i }">
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
				</c:if>
				</c:forEach>
				</div>
				</c:if>
				</div>

				<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
				<div class="reply_menu">
					<div id="re_menu_list">
						<ul>
							<li><a class="rEdit">댓글 수정</a></li>
							<li><a class="rDelete" href="deleteReply.do?rNo=${ rpl.rNo }">댓글 삭제</a></li>
							<li><a id="re_close" class="rClose">취소</a></li>
						</ul>
					</div>
				</div>

				<div id="reply">
					<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
					<input type="text" id="textArea" class="rContent" name="textArea">
					<input type="button" id="replyBtn" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
				</div>
			</div>
		</div>
	</div>
	</c:forEach>
	<div id="footer"><p>GROOBEE © 2020</p></div>
	</div>
    <script>
	
	$('.test').on("click", function(event){
	    var sample = $(event.target).siblings()[1];
	    $(sample).show();
	});
    $('.close').on('click', function(){
        $('.pop_menu').hide();
    });
    $('#feed_report_btn').on("click", function(){
        $('.feed_report').show();
    });
    $('#cancel').on("click", function(){
        $('.feed_report').hide();
    });
    $('.rUpBtn').on("click", function(event){
  	  var btn = $(event.target).parent().parent().parent().parent().siblings();
	  $(btn).show();
    });
    $('.rClose').on("click", function(){
        $('.reply_menu').hide();
    });
    $('.deleteMyPost').on('click', function () {
    	confirm('이 포스트를 정말 삭제하시겠습니까?');
    });
    $('.rEdit').on("click", function() {
  	  $('#replyCon').css('border','1px solid #555555');
  	  $('#replyCon').removeAttr('readonly');
  	  $('#replyCon').removeAttr('disabled');
  	  
  	  $('#confirmR').css('display', 'block');
  	  $('.reply_menu').hide();
    });
          
       // text-area resize
       $.each(jQuery('textarea[data-autoresize]'), function() {
    	   var offset = this.offsetHeight - this.clientHeight;
    	   var resizeTextarea = function(el) { $(el).css('height', 'auto').css('height', el.scrollHeight + offset); };
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
						location.href="home.do?userId="+rWriter;
					}
				}, error: function() {
					console.log("전송 실패");
				}
			});
			
			confirm("댓글을 등록하시겠습니까?");
		});
 	
 	$('.rConfirm').on("click", function(e) {
/* 		var rContent = e.target.parentElement.children[1].value; */
		var rNo = e.target.parentElement.children[0].value;
		var rWriter = "<%= ((Member)session.getAttribute("loginUser")).getUserId() %>";
		
		var replyContent = $('#replyCon').val();
//		var replyContent = e.target.parentElement.parentElement.parentElement.previousSibling.parentElement.children[0].children[0].children[1].innerText;
		
			$.ajax({
				url: "editReply.do",
				data: {
					rContent: replyContent,
					rNo: rNo,
					rWriter: rWriter
				},
				type: "post",
				success: function(data) {	// 성공 시: success, 실패 시: fail
					if(data == "success") {
						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
						location.href="home.do?userId="+rWriter;
					}
				}, error: function() {
					console.log("전송 실패");
				}
			});
		
	});
	});
 			// 좋아요 알람
    			$(".likeIcon").on('click',function(e){
    				console.log("likeicon 클릭");
    				$(e.target).attr('src','/spring/resources/icons/heart_red.png');
    				var toId = $(e.target).parent().children('.toId').val();
    				var toNo = $(e.target).parent().children('.toNo').val();
    				
    				sendAlram("상관없음",toId,"like",toNo);
    				console.log("상관없음",toId,"like",toNo);
    			})
    </script>
    
</body>
</html>
