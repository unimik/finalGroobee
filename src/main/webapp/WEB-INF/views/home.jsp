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
	#feed{ height: fit-content; margin-bottom: 50px; }
	.feed h6{ color: #cccccc; margin: 0; padding:0; margin-top: 2px;}
	#footer{ height: 200px; text-align: center; }
	.pop_menu{ background: #00000005; }
	a{ color: black; }
	#imgList{position:relative; margin:0; padding:0; height:633px; list-style:none; overflow:hidden;}
	#imgList li{display:none; float:left; position: absolute; top:0; left:0;}
	#imgList li:nth-child(1){display:block;}
	.imgbtn{  z-index:10;border: 0; background: none; cursor: pointer;outline:none;}
	#nextBtn{ position: absolute; margin: 300px 570px; }
	#prevBtn{display:none; position: absolute; margin: 300px 20px; }
</style>

</head>
<body>
	<c:import url="common/menubar.jsp" />
	<div id="feedArea">
	<c:forEach var="f" items="${ feed }" varStatus="status">
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
			</div>
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
						<button id="nextBtn" name="nextBtn" class="imgbtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
						<button id="prevBtn" name="prevBtn" class="imgbtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
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
				<%-- <div id="replyArea">
					<div id="replyList" style="display: none;">
					</div>
						<c:if test="${ f.replyList[2] eq f.fNo }">
							<div id="replyList" style="display: block;">
							<c:forEach var="r" items="${ f.replyList }">
							<ul id="re_list">
								<li><img src="${ contextPath }/resources/images/IMG_7502.JPG" alt=""
									id="reply_img">&nbsp;&nbsp;&nbsp;
									<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
								<li><p id="replyCon"><c:out value="${ r.rContent }" /></p></li>
								<li><p id="time"><c:out value="${ r.rCreateDate }" /></p></li>
								<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
							</ul>
							</c:forEach>
							</div>
						</c:if>
	
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
						<input type="button" id="replyBtn" name="replyBtn" value="등록">
					</div>
				</div> --%>
			</div>
		</div>
	</c:forEach>
	<div id="footer"><p>GROOBEE © 2020</p></div>
	</div>
	</div>
    <script>

            $('.test').on("click", function(){
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

			
            var size;
            var idx = 0;
           
            
   			$('#nextBtn').on("click",function(){
	  			size = $(this).nextAll().children('li').length;
	  			console.log(size);
	  			if(size > 1){
	  				for(var i=1; size<=i; i++){
			  			idx+i = (idx + 1) % size;
			  			$(this).nextAll('#imgList li:hidden').css("left","633px");
			  			$(this).nextAll("#imgList li:eq("+idx+i+")").animate({left:"-= 633px"},300);
			  			idx = idx+i;
		  			};
	  			}	
	  			});
	  		});
    </script>
    
</body>
</html>
