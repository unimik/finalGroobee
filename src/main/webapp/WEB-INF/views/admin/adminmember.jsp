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
							<td>회원정지</td>
						</tr>
					</thead>
					<tbody>	
						 <!-- <div class="pagination" id="pagination"></div> -->
					</tbody>
					<tfoot>
					</tfoot>
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
		
		// 페이지 마우스 오버 효과
		$(document).on('mouseover','.pageNum',function(){
			$(this).css("color","red").css("cursor","pointer");
		});
		$(document).on('mouseout','.pageNum',function(){
			$(this).css("color","black");
		});
		
		

		// 페이징 처리
		function page(){ 
			
		    $('#user_table').each(function() {

			console.log("page()가 실행됨");		   
			
		    var pagination = $("#pagination"); // 페이징을 표시할 곳
		    
		    var pagesu = 10;  //페이지 번호 갯수 
		    var currentPage = 0;    
		    var numPerPage = 10;  //목록의 수   
		    var $table = $(this);      // table을 가르킴 
		    console.log(this); // this => tbody
		    
		    //length로 원래 리스트의 전체길이구함   
		    var numRows = $table.find('tbody tr').length;
		    console.log("numRows : "+numRows); // 출력될 행의 갯수
		     
		    //Math.ceil를 이용하여 반올림   
		    var numPages = Math.ceil(numRows / numPerPage);
		    console.log("numPages의 갯수 : "+ numPages);
		    
		    //리스트가 없으면 종료   
		    if (numPages==0) return;
		        
		    //pager라는 클래스의 div엘리먼트 작성  
		    var $pager = $('<div class="pager"></div>'); 
		    var nowp = currentPage;
		    var endp = nowp+10;
		    
		    //페이지를 클릭하면 다시 셋팅 
		    $table.on('click', function() {
			    //기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다 
			    $table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();   
			    $("#pagination").html("");
			  
			    if (numPages > 1) {     // 페이지가 하나이상 생성될 때   
			    	
			    	// 현재 5페이지 이하이면    
				    if (currentPage < 5 && numPages-currentPage >= 5) {  
					    nowp = 0;     // 1부터  
					    endp = pagesu;    // 10까지
				    
				    }else{
					    nowp = currentPage -5;  // 6넘어가면 2부터 찍고	 
					    endp = nowp+pagesu;   // 10까지
					    pi = 1;	    
				    }
					// 10페이지 이하일 때 
				    if (numPages < endp) {    
					    endp = numPages;   // 마지막페이지를 갯수 만큼    
					    nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
				    }
				    
					// 시작이 음수 or 0 이면
				    if (nowp < 1) {         
				    	nowp = 0;     // 1페이지부터 시작
			    	}
			    
			    }else{       // 한페이지 이하이면    
				    nowp = 0;      // 한번만 페이징 생성  
				    endp = numPages;    
			    }
		    
		    
				    // [처음]    
				    $('<span class="pageNum first" > [처음] </span>').on('click', {newPage: page},function(event) { 
				    currentPage = 0;       
				    $table.trigger('click');      
				    $($(".pageNum")[2]).addClass('active').siblings().removeClass('active');    
				    }).appendTo(pagination).addClass('clickable');
				    
				    
				    
				    // [이전]    
				    $('<span class="pageNum back"> [이전] </span>').on('click', {newPage: page},function(event) {  
				
				    	if(currentPage == 0) return; 
				    	 currentPage = currentPage-1;
				    	 $table.trigger('click'); 
				    	 $($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
				   		}).appendTo(pagination).addClass('clickable');
				    
				    
				    // [1,2,3,4,5,6,7,8]
				    for (var page = nowp ; page < endp; page++) {    
					    $('<span class="pageNum"></span>').text( page + 1 ).on('click', {newPage: page}, function(event) {
					    	currentPage = event.data['newPage']; 
					    	
					    	$table.trigger('click');	    
					    	
					    	$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
					    }).appendTo(pagination).addClass('clickable');    
				    } 
				        
				    // [다음]
				    $('<span class="pageNum next"> [다음] </span>').on('click', {newPage: page},function(event) {
					    if(currentPage == numPages-1) return;
				   	    currentPage = currentPage+1;    
					    $table.trigger('click');
					    $($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');	    
					    }).appendTo(pagination).addClass('clickable');
				    
				    
				    // [끝]
				    $('<span class="pageNum last"> [끝] </span>').on('click', {newPage: page},function(event) {    
				    currentPage = numPages-1;
				    $table.trigger('click');
				    $($(".pageNum")[endp-nowp+1]).addClass('active').siblings().removeClass('active');
				    }).appendTo(pagination).addClass('clickable');    
				    $($(".pageNum")[2]).addClass('active');    
				    });
				    
				    
				    $pager.insertAfter($table).find('span.pageNum:first').next().next().addClass('active');   
				    
				    $pager.appendTo(pagination);
				    
				    $table.trigger('click');
				    
				    });
		    
		   
		    }
		
		// 회원 검색  이벤트
		 $('#searchBtn').on("click",function(){
			
			var dynamicBtnY = '<input type="button" class="btnyn" value="OUT"/>';
			var dynamicBtnN = '<input type="button" class="btnyn" value="IN"/>';
			
			
			$.ajax({
				url:"memberSearch.do",
				type:'post',
				data:$("#memberSearch_form").serialize(),
				dataType:"json",
				success:function(data){
					$tableBody = $("#user_table tbody");
					$tableBody.html("");

					$tableFoot = $("#user_table tfoot");
					var $tr2 = $("<tr>");				
					
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
					var $pageBox = $('<td colspan="7" id="pagination" class="pagination">');
					$tr2.append($pageBox);
					$tableFoot.append($tr2);
					page();
				},
				error:function(request,status,error){
					alert("code : "+request.status+"\n"
							+"message : "+request.responseText+"\n"
							+"error : "+ error);		
				}
			});
		}); 
		// 리프래시를 위한 메소드
		 function refresh(){
				location.reload();
			}
		// member 상태 변경을 위한 이벤트
		$(document).on('click','.btnyn',function(){
			
			var id = $(this).parent().prev().prev().prev().prev().prev().text();
			var status = $(this).parent().prev().text();
						

			 $.ajax({
				url:"memberStatusChange.do",
				type:'post',
				data:{id:id
					,status:status
									},
				success:function(data){
					alert("회원정보가 업데이트 되었습니다");
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