<%@page import="com.kh.spring.feed.model.vo.Reply"%>
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
	.replycnt_p{ width: fit-content; display: inline; font-size: 10pt; color: #a9a9a9; }
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
</style>

</head>
<body>
	<c:import url="common/menubar.jsp" />
	<div id = "topScrollBox"><img src="${ contextPath }/resources/icons/topScroll.png" id="topScrollBtn"></div>
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
			<c:if test="${ loginUser.userId ne f.fWriter }">
				<!-- 다른 회원 글 볼 때 피드 메뉴 -->
 				<div class="pop_menu">
					<div id="feed_menu_list">
						<ul>
							<li><a id="feed_report_btn">신고</a></li>
							<li><a>공유하기</a></li>
							<li><a>보관함</a></li>
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
			<div id="feed_report_con">
				<p>신고사유</p>
				<select style=>
					<option>부적절한 게시글</option>
					<option>욕설</option>
					<option>광고</option>
					<option>도배</option>
				</select> <br> <input type="button" id="submit" name="submit" value="확인">
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
				<p id="text"><c:out value="${ f.fContent }" /></p>

				<div id="heart_reply">
				

			<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
             	<c:choose>
	             	<c:when test="${f.likeChk eq null }">
	             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${f.fNo }"class="likeIcon" id="likeIcon">
	             		<label class="likeCnt" id="${f.fNo }">${f.fLikeCnt }</label>
	             	</c:when>
	             	<c:otherwise>
	             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${f.fNo }" class="likeIcon" id="liked">	             	
		               <label class="likeCnt" id="${f.fNo }">${f.fLikeCnt }</label>
	             	</c:otherwise>
             	</c:choose>

             		
             		<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
               		<input type="hidden" class="toNo" value="${f.fNo}">
               		<input type="hidden" class="toId" value="${f.fWriter}">
           		</div>
             	
					<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
					<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
						<p class="replycnt_p">${ f.replyList.size() }개</p>
					</c:if>
					<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
						<p class="replycnt_p">0개</p>
					</c:if>

			</div>
			<div id="replyArea">
				<div id="replyList" style="display: block; height: fit-content;">
				<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
				<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
				<c:if test="${ f.fReplyCnt ne null && f.replyList[0].rStatus eq 'Y' }">
					<div id="replySub" style="display: block; height: 150px; overflow: auto;">
					<c:forEach var="r" items="${ f.replyList }">
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
					</c:forEach>
					</div>
				</c:if>
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
//  	  var btn = $(event.target).parents("div#replyArea").find("div#reply_menu");
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
			
			var ok = confirm("댓글을 등록하시겠습니까?");
         	console.log(ok);
         	if(ok){
         	console.log(오케이);
        	sendAlram("상관없음",fWriter,"reply",rfNo); 
        	console.log("상관없음",fWriter,"reply",rfNo+"테스트");
//        	alert('stop');
         }
	});

	// 댓글 수정 시 완료 버튼
 	$('.rConfirm').on("click", function(e) {
/* 		var rContent = e.target.parentElement.children[1].value; */
		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
//		var rNo = e.target.parentElement.parentElement.parentElement.parentElement.previousElementSibling.children[0].children[0].value;
		var rWriter = "<%= ((Member)session.getAttribute("loginUser")).getUserId() %>";
		
		var replyContent = e.target.previousElementSibling.value;
//		var replyContent = e.target.parentElement.parentElement.parentElement.previousSibling.parentElement.children[0].children[0].children[1].innerText;
//		var replyDiv = e.target.parentElement.parentElement.parentElement.parentElement;
		
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
//						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
//						location.href="home.do?userId=" + rWriter;
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
		var rWriter = "<%= ((Member)session.getAttribute("loginUser")).getUserId() %>";
		var none = $(this.parentElement).parents("div#replySub").children.length;
		
		$.ajax({
			url: "deleteReply.do",
			data: {rNo: rNo},
			type: "post",
			success: function(data) {	// 성공 시: success, 실패 시: fail
//				console.log(data);
  				if(data == "success") {
//					$(ul).css('display', 'none');
					$('.rNum').css('display', 'none');
//					location.href="home.do?userId=" + rWriter;
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
    </script>
    
</body>
</html>
