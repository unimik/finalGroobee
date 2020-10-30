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
					<!-- admin feed search -->
					<div class="search_feed search_box on">
						<form id="feedSearch_form" name="feedSearch_form">
							<label>	글 번 호 </label><input type="text" id="f_num" name="f_num">
							<label>아 이 디</label><input type="text" id="f_id" name="f_id"><br>
							<br> <label>글 내 용 </label><input type="text" id="f_Content"
								name="f_Content"> <label>작 성 일</label><input type="date"
								id="f_writedate" name="f_writedate"><br> <input
								type="button" id="f_SearchBtn" name="f_SearchBtn" value="검색">
							<input type="reset" id="f_ResetBtn" name="f_ResetBtn" value="초기화">
						</form>
					</div>
					<!-- admin reply search -->
					<div class="search_reply search_box">
						<form id="replySearch_form" name="replySearch_form">
							<label>댓글번호</label><input type="text" id="re_num" name="re_num">
							<label>아 이 디</label><input type="text" id="re_id" name="re_id"><br>
							<br> <label>댓글내용</label><input type="text" id="re_Content"
								name="re_Content"> <label>작 성 일</label><input
								type="date" id="re_writedate" name="re_writedate"><br> <input
								type="button" id="re_searchBtn" name="re_searchBtn" value="검색">
							<input type="reset" id="re_resetBtn" name="re_resetBtn" value="초기화">
						</form>
					</div>
				</div>
			</div>
			<!-- admin feed contents -->
			<div class="containar1 containar on">
				<table id="feedTable" name="feedTable" cellspacing="0" class="feed_table">
					<thead>
						<tr>
							<td>피드번호</td>
							<td>아이디</td>
							<td>내용</td>
							<td>작성일</td>
							<td>좋아요</td>
							<td>게시물 유효</td>
							<td>게시금지</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			
			<!-- admin reply contents -->
			<div class="containar2 containar">
				<table id="reply_table" name="reply_table" cellspacing="0" class="reply_table">
					<thead>
						<tr>
							<td>피드번호</td>
							<td>댓글번호</td>
							<td>아이디</td>
							<td>내용</td>
							<td>작성일</td>
							<td>게시유효</td>
							<td>게시금지</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
	// 리프래시를 위한 메소드
	 function refresh(){
			location.reload();
		}
	
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
        
    
		// feed 검색 버튼 클릭 이벤트
		 $('#f_SearchBtn').on("click",function(){
			
			var dynamicBtnY = '<input type="button" class="f_btn" value="OUT"/>';
			var dynamicBtnN = '<input type="button" class="f_btn" value="IN"/>';
			
			console.log($('feedSearch_form').serialize());
			
			$.ajax({
				url:"feedSearch.do",
				type:'post',
				data:$("#feedSearch_form").serialize(),
				dataType:"json",
				success:function(data){
					
					$tableBody = $("#feedTable tbody");
					$tableBody.html("");
					
					for(var i in data){
						
						var $tr = $("<tr>");
						var $fNo = $("<td>").text(data[i].fNo);	// 피드번호
						var $fWriter = $("<td>").text(data[i].fWriter); // 작성자
						var $fContent = $("<td>").text(data[i].fContent);	// 내용
						//var $rNo = $("<td>").text(data[i].rNo);	// 구분 (아직 미구현)
						var $fCreateDate = $("<td>").text(data[i].fCreateDate);// 작성일
						var $fLikeCnt = $("<td>").text(data[i].fLikeCnt);// 좋아요 갯수
						var $fStatus = $("<td>").text(data[i].fStatus); // 상태
						
						// 정지 버튼
						if(data[i].fStatus==='Y'){
							var $getOutBtn = $("<td>").html(dynamicBtnY); // 활성화 상태가 Y일 때 
						}else{
							var $getOutBtn = $("<td>").html(dynamicBtnN); // 활성화 상태가 N일 때
						}
						
							$tr.append($fNo);
							$tr.append($fWriter);
							$tr.append($fContent);
							$tr.append($fCreateDate);
							$tr.append($fLikeCnt);
							$tr.append($fStatus);
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
		
		// 댓글 검색 버튼 클릭 이벤트
		 $('#re_searchBtn').on("click",function(){
			console.log("클릭했엉?");
			
			var dynamicBtnY = '<input type="button" class="re_btn" value="OUT"/>';
			var dynamicBtnN = '<input type="button" class="re_btn" value="IN"/>';
			

			console.log("전달되는 값"+$("#replySearch_form").serialize());
			
			$.ajax({
				url:"replySearch.do",
				type:'post',
				data:$("#replySearch_form").serialize(),
				dataType:"json",
				success:function(data){
					
					$tableBody = $("#reply_table tbody");
					$tableBody.html("");
					
					for(var i in data){
						
						var $tr = $("<tr>");
						var $fNo = $("<td>").text(data[i].fNo);	// 피드번호
						var $rNo = $("<td>").text(data[i].rNo);	// 댓글번호
						var $rWriter = $("<td>").text(data[i].rWriter); // 작성자
						var $rContent = $("<td>").text(data[i].rContent);	// 내용
						var $rCreateDate = $("<td>").text(data[i].rCreateDate);// 작성일
						var $rStatus = $("<td>").text(data[i].rStatus); // 상태
						
						// 정지 버튼
						if(data[i].rStatus==='Y'){
							var $getOutBtn = $("<td>").html(dynamicBtnY); // 활성화 상태가 Y일 때 
						}else{
							var $getOutBtn = $("<td>").html(dynamicBtnN); // 활성화 상태가 N일 때
						}
						
							$tr.append($fNo);
							$tr.append($rNo);
							$tr.append($rWriter);
							$tr.append($rContent);
							$tr.append($rCreateDate);
							$tr.append($rStatus);
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
		// feed 상태 변경을 위한 이벤트
			$(document).on('click','.f_btn',function(){
				
				var no = $(this).parent().prev().prev().prev().prev().prev().prev().text();
				var status = $(this).parent().prev().text();

				 $.ajax({
					url:"feedStatusChange.do",
					type:'post',
					data:{no:no
						,status:status
										},
					success:function(data){
						alert("피드정보가 업데이트 되었습니다");
						refresh();
					},
					error:function(request,status,error){
						alert("code : "+request.status+"\n"
								+"message : "+request.responseText+"\n"
								+"error : "+ error);
					}
				});
				
			});
		
			// 댓글 상태 변경을 위한 이벤트
			$(document).on('click','.re_btn',function(){
				
				var no = $(this).parent().prev().prev().prev().prev().prev().text();
				var status = $(this).parent().prev().text();

				 $.ajax({
					url:"replyStatusChange.do",
					type:'post',
					data:{no:no
						,status:status
										},
					success:function(data){
						alert("댓글정보가 업데이트 되었습니다");
						refresh();
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