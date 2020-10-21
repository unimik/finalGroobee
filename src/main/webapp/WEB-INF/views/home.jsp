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
	#feed{ height: fit-content; }
</style>
</head>
<body>
	<div class="wapper">
		<c:import url="common/menubar.jsp" />
		<div class="content">
		<div class="myAccount">
			<div id="myId">
				<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="myProfile"
					id="myProfile">
				<p>user01</p>
			</div>
			<div id="MyTab">
				<button class="MyTab_tab1 MyTab_tab on">친구</button>
				<button class="MyTab_tab2 MyTab_tab">그룹</button>
				<div id="MyTab_container">
					<div class="MyTab_box1 MyTab_box on">
						<div id="My_f_list">
							<ul id="f_info">
								<li><img src="${ contextPath }/resources/images/IMG_7273.JPEG" alt=""
									id="f_list_img"></li>
								<li>user02</li>
								<li><button id="following" name="following">팔로잉</button></li>
							</ul>
						</div>
						<div id="My_f_list">
							<ul id="f_info">
								<li><img src="${ contextPath }/resources/images/IMG_7273.JPEG" alt=""
									id="f_list_img"></li>
								<li>user03</li>
								<li><button id="following" name="following">팔로잉</button></li>
							</ul>
						</div>
						<div id="My_f_list">
							<ul id="f_info">
								<li><img src="${ contextPath }/resources/images/IMG_7273.JPEG" alt=""
									id="f_list_img"></li>
								<li>user04</li>
								<li><button id="following" name="following">팔로잉</button></li>
							</ul>
						</div>
						<div id="My_f_list">
							<ul id="f_info">
								<li><img src="${ contextPath }/resources/images/IMG_7273.JPEG" alt=""
									id="f_list_img"></li>
								<li>user05</li>
								<li><button id="follow" name="follow">팔로우</button></li>
							</ul>
						</div>
					</div>
					<div class="MyTab_box2 MyTab_box"></div>
				</div>
			</div>
		</div>
	</div>
	<div id="feedArea">
		<div id="feed">
			<div id="writer_submenu">
				<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt=""
					id="feed_profile_img">
				<div id="user_time">
					<c:choose>					
						<c:when test="${ feedPost.mNo eq loginUser.mNo }">
							<p id="feed_id">${ loginUser.userId }</p>
							<h6>${ fCreateDate }</h6>
						</c:when>
						<c:otherwise>
							<p id="feed_id">${ userId }</p>
							<h6>${ fCreateDate }</h6>
						</c:otherwise>
					</c:choose>
				</div>
				<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu">
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
                        <div class="pop_menu">
                            <div id="feed_Mymenu_list">
                                <ul>
                                <li><a href="../views/PostUpdateForm.html" id="feed_menu1_btn">수정</a></li> 
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
					<p id="text">${ fContent }</p>
					<ul id="tag">
						<li>${ fTag }</li>
					</ul>
				</div>
				<div id="replyArea">
					<div id="replyList">
						<ul id="re_list">
							<li><img src="${ contextPath }/resources/images/IMG_7502.JPG" alt=""
								id="reply_img">&nbsp;&nbsp;&nbsp;
								<p id="userId" name="rWriter">${ rWriter }</p></li>
							<li><p id="replyCon">${ rContent }</p></li>
							<li><p id="time">1시간 전</p></li>
							<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt=""
								id="updateBtn"></li>
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
						<input type="text" id="textArea" name="textArea"> <input
							type="button" id="replyBtn" name="replyBtn" value="등록">
					</div>
				</div>
			</div>
		</div>
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
