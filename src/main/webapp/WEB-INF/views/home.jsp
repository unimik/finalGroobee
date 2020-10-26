<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>G R O O B E E</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="resources/css/home.css">
<link rel="stylesheet" href="resources/css/myAccount.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	#feed{ height: fit-content; margin-bottom: 50px; }
	#footer{ height: 200px; text-align: center; }
</style>
</head>
<body>
	<div class="wapper">
		<c:import url="common/menubar.jsp" />
		<div class="content">
			<div class="myAccount">
				<div id="myId">
					<img src="../resources/images/IMG_7502.JPG" alt="myProfile"
						id="myProfile">
					<p>user01</p>
				</div>
				<div id="MyTab">
					<button class="MyTab_tab1 MyTab_tab on">팔로워</button>
					<button class="MyTab_tab2 MyTab_tab">팔로잉</button>
					<button class="MyTab_tab3 MyTab_tab">그룹</button>
					<div id="MyTab_container">
						<!-- 팔로워 -->
						<div class="MyTab_box1 MyTab_box on">
							<div id="My_follower_list">
								<ul id="follower_info">
									<li><img src="../resources/images/IMG_7273.JPEG" alt=""
										id="follower_list_img"></li>
									<li>user02</li>
									<li><button id="follower" name="follower">삭제</button></li>
								</ul>
							</div>
						</div>
						<!-- 팔로잉 -->
						<div class="MyTab_box2 MyTab_box">
							<div id="My_following_list">
								<ul id="following_info">
									<li><img src="../resources/images/IMG_7273.JPEG" alt=""
										id="following_list_img"></li>
									<li>user02</li>
									<li><button id="following" name="following">팔로잉</button></li>
								</ul>
							</div>
						</div>
						<!-- 그룹 -->
						<div class="MyTab_box3 MyTab_box">
							<div id="My_fgroup_list">
								<ul id="fgroup_info">
									<li><img src="../resources/images/IMG_7273.JPEG" alt=""
										id="fgroup_list_img"></li>
									<li>user02</li>
									<li><button id="del_group" name="del_group">탈퇴</button></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<div id="feedArea">
	<c:forEach var="f" items="${ feed }" varStatus="status">
		<div id="feed">
			<div id="writer_submenu">
				<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
				<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt=""
					id="feed_profile_img">
				<div id="user_time">
					<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
					<h6><c:out value="${ f.fCreateDate }" /></h6>
				</div>
				</a>
				<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu">
			</div>
		<c:choose>
			<c:when test="${ !loginUser.userId }">
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
			</c:when>
			<c:otherwise>
				<!-- 내가 쓴 글 볼 때 피드메뉴 -->
                <div class="pop_menu">
                    <div id="feed_Mymenu_list">
                        <ul>
                        <li><a href="../views/PostUpdateForm.html" id="feed_menu1_btn">수정</a></li> 
                        <li><a>삭제</a></li> 
                        <li><a id="close">취소</a></li>
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
				<img src="${ contextPath }/resources/images/IMG_7572.JPG" alt="" id="input_img">
				<div id="heart_reply">
					<img src="${ contextPath }/resources/icons/heart.png" alt="" id="likeIcon">
					<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
				</div>
				<p id="text"><c:out value="${ f.fContent }" /></p>

			</div>
			<div id="replyArea">
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
			</div>
		</div>
		</div>
	</c:forEach>
	<div id="footer"><p>GROOBEE © 2020</p></div>
	</div>
	</div>
	
	<script>
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

        $('#goMypage').click(function(){
            location.href="../views/myPage_Main.html";
        });

    </script>
</body>
</html>
