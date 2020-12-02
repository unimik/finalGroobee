<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>G R O O B E E</title>
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
					<tfoot></tfoot>
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
					<tfoot></tfoot>
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
					
	       
	        $('.enquiryBtn alarm_menubtn').on('click', function(){
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
			
			
			$.ajax({
				url:"feedSearch.do",
				type:'post',
				data:$("#feedSearch_form").serialize(),
				dataType:"json",
				success:function(data){
					
					$tableBody = $("#feedTable tbody");
					$tableBody.html("");
					
					var $tr2 = $("<tr>");
					$tableFoot = $("#feedTable tfoot");
					
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
					
					$tableFoot = $("#reply_table tfoot");
					var $tr2 = $("<tr>");
					
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
					var $pageBox = $('<td colspan="7" id="pagination" class="pagination">');
					$tr2.append($pageBox);
					$tableFoot.append($tr2);
					page1();
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
			
			// 페이지 마우스 오버 효과
			$(document).on('mouseover','.pageNum',function(){
				$(this).css("color","red").css("cursor","pointer");
			});
			$(document).on('mouseout','.pageNum',function(){
				$(this).css("color","black");
			});
			
			

			// 페이징 처리
			function page(){ 
				
			    $('#feedTable').each(function() {

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
				
				// reply page처리
				function page1(){ 
				
			    $('#reply_table').each(function() {

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
			    var $pager = $('<div class="pager" style="color:black;font-size:30px;"></div>'); 
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
    </script>
</body>
</html>