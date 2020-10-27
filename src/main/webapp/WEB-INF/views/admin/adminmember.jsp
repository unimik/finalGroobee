<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>adminmemberPage</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="resources/css/admincommon.css">
<link rel="stylesheet" href="resources/css/admin1.css">
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
				
				<p id="title">GROOBEE 회원관리</p>
				<div id="searchBox">
					<div id="all_user" style="font-size: 15px;">
						<p>현재 GROOBEE 회원 수는 <b id="total" style="color: red;"></b> 명입니다.</p>
					</div>
					<div id="search">
						<form id="memberSearch_form" name="memberSearch_form">
							<label>회원이름</label><input type="text" id="name" name="name">
							<label>아 이 디</label><input type="text" id="id" name="id"><br>
							<br> <label>탈퇴여부</label>
							<select id="getOut" name="getOut">								
								<option>Y</option>
								<option>N</option>
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
							<td>가입일</td>
							<td>탈퇴여부</td>
							<td>삭제</td>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script>
		var totalCount;
		
		$(document).ready(function() {
			$.ajax({
				url:"totalMember.do",
				dataType: "html",
				type:"get",
				success:function(data){
					console.log(data);
					$("#total").html(data);
				},error:function(){
					console.log("전송실패!");
				}				
			});
			$('#alarmIcon').on("click", function() {
				$('.alarm_pop').show();
			});

			$('.alarm_menubtn').on("click", function() {
				$('.alarm_menubtn').removeClass('on');
				$(this).addClass('on')
			});

			$('.alarmBtn').on('click', function() {
				$('.conBox').hide();
				$('.alarmCon').show();
			});

			$('.enquiryBtn').on('click', function() {
				$('.conBox').hide();
				$('.enquiryCon').show();
			});

			$('.close_pop').on("click", function() {
				$('.alarm_pop').hide();
			});
		});
		
		// 회원 검색 버튼 클릭 이벤트
		 $('#searchBtn').on("click",function(){
			console.log("클릭했엉?");
			
			var dynamicBtnY = '<input type="button" name="btn" value="OUT"/>';
			var dynamicBtnN = '<input type="button" name="btn" value="IN"/>';
			
			
			$.ajax({
				url:"memberSearch.do",
				type:'post',
				data:$("#memberSearch_form").serialize(),
				dataType:"json",
				success:function(data){
					console.log(data);
					
					$tableBody = $("#user_table tbody");
					$tableBody.html("");
					
					for(var i in data){
						var $tr = $("<tr>");
						var $mNo = $("<td>").text(data[i].mNo);
						var $userId = $("<td>").text(data[i].userId);
						var $userName = $("<td>").text(data[i].userName);
						var $email = $("<td>").text(data[i].email);	
						var $cDate = $("<td>").text(data[i].cDate);
						var $mStatus = $("<td>").text(data[i].mStatus);
						if(data[i].mStatus==='Y'){
							var $getOutBtn = $("<td>").html(dynamicBtnY);//회원의 상태가 Y일 때
						}else{
							var $getOutBtn = $("<td>").html(dynamicBtnN);//회원의 상태가 N일 때
						}
						
							$tr.append($mNo);
							$tr.append($userId);
							$tr.append($userName);
							$tr.append($email);
							$tr.append($cDate);
							$tr.append($mStatus);
							$tr.append($getOutBtn);
							
							$tableBody.append($tr);
					}
				},
				error:function(request,status,error){
					alert("code : "+request.status+"\n"
							+"message : "+request.responseText+"\n"
							+"error : "+ error);		
				}
			});
		}); 
	</script>
</body>
</html>