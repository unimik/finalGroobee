<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>adminfeedPage</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="resources/css/admincommon.css">
<link rel="stylesheet" href="resources/css/admin2.css">
<link rel="stylesheet" href="resources/css/alarmPop.css">
</head>
<body>
	<div class="wapper">
		<div id="header">
			<img src="resources/icons/logo.png" alt="logo" id="logo" name="logo">
		</div>
		<div class="content">
			<c:import url="commonAdmin/admininfo.jsp" />
			<div id="admin_common">
				<c:import url="commonAdmin/sidebar.jsp" />
				<p id="title">GROOBEE 게시글 / 댓글 관리</p>
				<div id="searchBox">
					<div class="tab_menu">
						<button class="feed tab_menuBtn on">게시글</button>
						<button class="reply tab_menuBtn">댓글</button>
					</div>
					<div class="search_feed search_box on">
						<form>
							<label>글 번 호 </label><input type="text" id="num" name="num">
							<label>아 이 디</label><input type="text" id="id" name="id"><br>
							<br> <label>글 내 용 </label><input type="text" id="fContent"
								name="fContent"> <label>작 성 일</label><input type="date"
								id="writedate" name="writedate"><br> <input
								type="button" id="searchBtn" name="searchBtn" value="검색">
							<input type="reset" id="resetBtn" name="resetBtn" value="초기화">
						</form>
					</div>
					<div class="search_reply search_box">
						<form>
							<label>댓글번호</label><input type="text" id="re_num" name="num">
							<label>아 이 디</label><input type="text" id="id" name="id"><br>
							<br> <label>댓글내용</label><input type="text" id="re_Content"
								name="re_Content"> <label>작 성 일</label><input
								type="date" id="writedate" name="writedate"><br> <input
								type="button" id="searchBtn" name="searchBtn" value="검색">
							<input type="reset" id="resetBtn" name="resetBtn" value="초기화">
						</form>
					</div>
				</div>
			</div>
			<div class="containar1 containar on">
				<table cellspacing="0" class="feed_table">
					<thead>
						<tr>
							<td>글번호</td>
							<td>아이디</td>
							<td>내용</td>
							<td>구분</td>
							<td>작성일</td>
							<td>첨부파일</td>
							<td>삭제</td>
						</tr>
					</thead>
					<tbody>
						<tr id="feed_info">
							<td>1</td>
							<td>user01</td>
							<td><nobr>오늘의 일상 오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의
									일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의
									일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의
									일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의
									일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상오늘의 일상</nobr></td>
							<td>개인</td>
							<td>2020-10-07</td>
							<td>◎</td>
							<td><button id="f_delete">삭제</button></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="containar2 containar">
				<table cellspacing="0" class="reply_table">
					<thead>
						<tr>
							<td>글번호</td>
							<td>댓글번호</td>
							<td>아이디</td>
							<td>내용</td>
							<td>작성일</td>
							<td>삭제</td>
						</tr>
					</thead>
					<tbody>
						<tr id="feed_info">
							<td>1</td>
							<td>1</td>
							<td>user01</td>
							<td><nobr>이거 잘 찍었다!!</nobr></td>
							<td>2020-10-07</td>
							<td><button id="f_delete">삭제</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
        $(document).ready(function(){
            $('.tab_menuBtn').on("click",function(){
                $('.tab_menuBtn').removeClass("on");
                $(this).addClass("on");
            });

            $('.feed').on("click",function(){
                    $('.search_box').hide();
                    $('.search_feed').show();
                    $('.containar').hide();
                    $('.containar1').show();
                });

            $('.reply').on("click",function(){
                $('.search_box').hide();
                $('.search_reply').show();
                $('.containar').hide();
                $('.containar2').show();
            });


            $('#alarmIcon').on("click",function(){
                    $('.alarm_pop').show();
                });

                $('.alarm_menubtn').on("click",function(){
                    $('.alarm_menubtn').removeClass('on');
                    $(this).addClass('on')
                });

                $('.alarmBtn').on('click', function(){
                    $('.conBox').hide();
                    $('.alarmCon').show();
                });

                $('.enquiryBtn').on('click', function(){
                    $('.conBox').hide();
                    $('.enquiryCon').show();
                });

                $('.close_pop').on("click",function(){
                    $('.alarm_pop').hide();
                });
        });
    </script>
</body>
</html>