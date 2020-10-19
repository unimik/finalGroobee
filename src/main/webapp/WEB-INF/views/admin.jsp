<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>adminPage</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/admincommon.css">
<link rel="stylesheet" href="../resources/css/admin1.css">
<link rel="stylesheet" href="../resources/css/alarmPop.css">

</head>
<body>
	<div class="wapper">
		<div id="header">
			<img src="../resources/icons/logo.png" alt="logo" id="logo"
				name="logo">
		</div>
		<div class="content">
			<c:import url="common/adminMenubar.jsp"/>
			<div id="admin_common">
			<c:import url="common/sidebar.jsp"/>
				<p id="title">GROOBEE 회원관리</p>
				<div id="searchBox">
					<div id="all_user">
						<p>
							현재 GROOBEE 회원 수는 <b>395,302</b>명입니다.
						</p>
					</div>
					<div id="search">
						<form>
							<label>회원이름</label><input type="text" id="name" name="name">
							<label>아 이 디</label><input type="text" id="id" name="id"><br>
							<br> <label>탈퇴여부</label><select>
								<option>전체</option>
								<option>N</option>
								<option>Y</option>
							</select> <label>가 입 일</label><input type="date" id="enrolldate"
								name="enrolldate"><br> <input type="button"
								id="searchBtn" name="searchBtn" value="검색"> <input
								type="reset" id="resetBtn" name="resetBtn" value="초기화">
						</form>
					</div>
				</div>
			</div>
			<div id="containar">
				<table cellspacing="0" id="user_table">
					<thead>
						<tr>
							<td>번호</td>
							<td>아이디</td>
							<td>이름</td>
							<td>이메일</td>
							<td>전화번호</td>
							<td>가입일</td>
							<td>탈퇴여부</td>
							<td>삭제</td>
						</tr>
					</thead>
					<tbody>
						<tr id="user_info">
							<td>1</td>
							<td>user01</td>
							<td>김유저</td>
							<td>user01@naver.com</td>
							<td>01011111111</td>
							<td>2020-10-07</td>
							<td>N</td>
							<td><button id="user_delete">탈퇴</button></td>
						</tr>
						<tr id="user_info">
							<td>2</td>
							<td>user02</td>
							<td>박유저</td>
							<td>user02@naver.com</td>
							<td>01012345678</td>
							<td>2020-10-07</td>
							<td>N</td>
							<td><button id="user_delete">탈퇴</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script>
            $(document).ready(function(){
            
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