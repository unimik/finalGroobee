<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="adminInfo">
		<div id="adminInfo">
			<ul>
				<li><img src="resources/images/IMG_7502.JPG" alt=""
					id="profile_img">&nbsp;&nbsp;&nbsp;
					<p>admin</p></li>
				<!-- <li><img src="resources/icons/write.png" alt="" id="writeIcon"></li> -->
				<li><img src="resources/icons/alarm.png" alt="" id="alarmIcon"></li>
			</ul>
		</div>
	</div>
	<div class="alarm_pop">
		<div class="alarm_enquiry">
			<div id="btnArea">
				<button class="alarmBtn alarm_menubtn on">알람</button>
				<button class="enquiryBtn alarm_menubtn">문의</button>
				<button class="close_pop">X</button>
			</div>
			<div class="alarm_containar">
				<!-- 알림 -->
				<div class="alarmCon conBox on">
					<ul id="alarmList"> <!-- alaramPop.css에 있음 -->
						<li><b>[ 회원신고 ]</b> 가 들어왔습니다.</li>
						<li><b>[ 게시글신고 ]</b> 가 들어왔습니다.</li>
						<li><b>[ 댓글신고 ]</b> 가 들어왔습니다.</li>
					</ul>
				</div>
				<!-- 문의 -->
				<div class="enquiryCon conBox">
 					<div id="enquiryList"> 
<!-- 					<div id="enquiryBox">
							<p id="id">user01</p>
							<p>채팅내용 복구해주세요</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user02</p>
							<p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데
								광고라고 신고를 하죠???????</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user01</p>
							<p>채팅내용 복구해주세요</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user02</p>
							<p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데
								광고라고 신고를 하죠???????</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user01</p>
							<p>채팅내용 복구해주세요</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user02</p>
							<p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데
								광고라고 신고를 하죠???????</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user01</p>
							<p>채팅내용 복구해주세요</p>
						</div>
						<div id="enquiryBox">
							<p id="id">user02</p>
							<p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데
								광고라고 신고를 하죠???????</p>
						</div> -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(function(){
		questionList();
	});
    // 문의 글을 불러오는 메소드
    function questionList(){
		   $.ajax({
				url:"questionSearchList.do",
				dataType:"json",
				success:function(data){
					console.log(data);
					$tableBody = $("#enquiryList");
					$tableBody.html("");
					
					for(var i in data){
						
						var $enquiryBox = $('<div id="enquiryBox">');
						var $userId = $('<p id="id">').text(data[i].userId);
						var $qContent = $("<p>").text(data[i].qContent);
						
						
							$enquiryBox.append($userId);
							$enquiryBox.append($qContent);
							
							$tableBody.append($enquiryBox);
					}
					
				},
				error:function(request,status,error){
					alert("code : "+request.status+"\n"
							+"message : "+request.responseText+"\n"
							+"error : "+ error);		
				}
			});
     }
	</script>
</body>
</html>