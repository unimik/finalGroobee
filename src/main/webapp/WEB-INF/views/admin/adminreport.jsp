<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>adminreportPage</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="resources/css/admincommon.css">
<link rel="stylesheet" href="resources/css/admin4.css">
<link rel="stylesheet" href="resources/css/alarmPop.css">
<link rel="stylesheet" href="resources/css/adminModal.css">
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
				<p id="title">GROOBEE 신고관리</p>
				<div id="searchBox">
					<div id="new_report">
						<p>
							보류 중인 신고 수는  <b id="delayedReport" style="color: red;"></b>개입니다.
						</p>
					</div>
					<div id="search">
						<form id="reportSearchForm">
							<label>처리상태</label><select id="state" name ="state">
								<option>보류</option>
								<option>완료</option>
							</select> <label>구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</label>
							<select id="category" name="category">
								<option>전체</option>
								<option>회원</option>
								<option>게시글</option>
								<option>댓글</option>
								<option>그룹</option>
							</select>
							<br><br> 
							<label>신고사유</label><select id="report_category" name="report_category">
								<option>전체</option>
								<option>부적절한내용</option>
								<option>욕설</option>
								<option>광고</option>
								<option>도배</option>
							</select> <label>신고일자</label><input type="date" id="enrolldate"
								name="enrolldate"><br> <input type="button"
								id="searchBtn" name="searchBtn" value="검색"> <input
								type="reset" id="resetBtn" name="resetBtn" value="초기화">
						</form>
					</div>
				</div>
			</div>
				 <!-- The Modal -->
    <div id="modal" class="modal" style="display:none;">
      <!-- Modal content -->
      <div class="modal_content">
      <!-- modal_left : 정보가 담길 곳 -->
	   <div class ="modal_left" style="height:80%;;">
	   		
	   		<div class="modal_etc" style="width:50%; text-align: center; float:left;">
	   			<div style="width:400px;height:200px;"><table id="details_etc_table" style="border:1px solid blue;width:400px;height:200px;"></table></div>
	   		</div>
	   			
	   		<div class="modal_report" style="width:50%; text-align: center;float:left;">
	   			<div style="width:400px;height:200px;"><table id="details_report_table" style="border:1px solid blue;width:400px;height:200px;"></table></div>	
	   		</div>
	   	</div>	
	   <!--  버튼이 존재할 곳 -->
	   <div class ="modal_right" style="height:20%; text-align: center;">
	   		<div id="submit_Btn" style=" float:left; "><input type="button" value="사용정지"/></div>
	   		<div id="cancel_Btn" style=" float:left; "><input type="button" value="닫기" onclick="close_pop();"/></div>
	   </div>
      </div>
    </div>
    <!--End Modal-->
			<div id="containar">
				<table cellspacing="0" id="report_table">
					<thead>
						<tr>
							<td>번호</td>
							<td>구분[번호]</td>
							<td>신고사유</td>
							<td>내용</td>
							<td>신고일</td>
							<td>처리상태</td>
							<td>삭제</td>
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
	// 모달  팝업(상세보기) 실행 기능
	$(document).on('click','.btnyn',function(){
		// [타입]과 [번호]를 넘겨줄 변수
		var typeAndNumber = $(this).parent().prev().prev().prev().prev().prev().text();
		console.log("typeAndNumber : "+typeAndNumber);
		// [신고 번호]를 넘겨줄 변수
		var dNo = $(this).parent().prev().prev().prev().prev().prev().prev().text();
		console.log("dNo : "+dNo);
		var $dNo = dNo;	
		// [신고 사유] 변수
		var $dType = $("<tr><td>").text("2.신고사유 : "+$(this).parent().prev().prev().prev().prev().text());
		// [신고 내용] 변수
		var $dContent =$("<tr><td>").text("3. 신고 내용 : "+$(this).parent().prev().prev().prev().text());
		
		// [상태]를 확인하고 상태변경 버튼을 숨기자.
		var rStatus = $(this).parent().prev().text();		
		console.log("rStatus의 상태는? " +rStatus);
		
		$.ajax({
			url:"reportDetails.do",
			type:"post",
			dataType: "json",
			data:{
				typeAndNumber:typeAndNumber	
			},
			success:function(data){
				// 상태변경 버튼 보이기 유/무
				if(rStatus==='Y'){
					$("#submit_Btn").css("display","none");
				}else{
					$("#submit_Btn").css("display","block");			
				} 
				
				var $tableEtc = $("#details_etc_table");
				var $tableReport = $("#details_report_table");
				var $tr=$("<tr>");
				$tableEtc.html("");
				$tableReport.html("");
				// 1. 그룹일 때
				var gNo= data.gNo;
				
				// 2. 회원일 때
				var mNo= data.mNo;
				var mStatus=data.mStatus;
				
				// 신고 정보를 테이블로 만들기
				
				$tableReport.append("1. 신고번호 : "+$dNo);
				$tableReport.append($dType);
				$tableReport.append($dContent);
				
				// 불러온 값을 테이블로 만들기
				// 1. 그룹	
				if(data.gNo !=null){
					var $gNo = $("<tr><td>").text("1. 그룹 번호 : "+ data.gNo);
					var $gCreator = $("<tr><td>").text("2. 그룹장 : "+data.gCreator);
					var $gName = $("<tr><td>").text("3. 그룹명 : "+ data.gName);
					var $gDate = $("<tr><td>").text("4. 그룹 생성일 : "+data.gDate);
					
					
					$tableEtc.append($gNo);
					$tableEtc.append($gCreator);
					$tableEtc.append($gName);
					$tableEtc.append($gDate);
				}
				// 2. 회원	
				if(data.mNo !=null){
					var $mNo = $("<tr><td>").text("1. 회원 번호 : "+ data.mNo);
					var $userId = $("<tr><td>").text("2. 회원 아이디 : "+data.userId);
					var $userName = $("<tr><td>").text("3. 회원 이름 : "+ data.userName);
					var $cDate = $("<tr><td>").text("4. 회원 가입일 : "+data.cDate);
					
					
					$tableEtc.append($mNo);
					$tableEtc.append($userId);
					$tableEtc.append($userName);
					$tableEtc.append($cDate); // mDate가 아니라 cDate임
				}
				

				
				//여기서 생성된 버튼을 실행시키면 YN값 변경과 declaration값 변경을 동시에 실행되는 메소드를 만들자 
				$("#submit_Btn").on("click",function(){
					// 1.그룹 상태변경 실행
					if(data.gNo !=null){
						$.ajax({
							url:"groupAndDeclarationStatusChange.do",
							type:'post',
							data:{gNo:gNo,
								 dNo:dNo},
							success:function(data){
								alert("처리하였습니다.");
								refresh();
							},
							error:function(request,status,error){
								alert("code : "+request.status+"\n"
										+"message : "+request.responseText+"\n"
										+"error : "+ error);
							}
						});
					}
					// 2.회원 상태변경 실행
					if(data.mNo !=null){
						$.ajax({
							url:"memberAndDeclarationStatusChange.do",
							type:'post',
							data:{mNo:mNo,
								 dNo:dNo},
							success:function(data){
								alert("처리하였습니다.");
								refresh();
							},
							error:function(request,status,error){
								alert("code : "+request.status+"\n"
										+"message : "+request.responseText+"\n"
										+"error : "+ error);
							}
						});
					}
					
					
					
				})
			},error:function(){
				console.log("report 세부사항 불러오기 실패!");
			}	
			
		});	
		
		// 화면 ON
        $('#modal').fadeIn();
	});
	// 모달 팝업 닫기버튼 기능
	function close_pop(flag) {
	     $('#modal').fadeOut();
	};


	
		// 페이지가 시작될 때 불러올 이벤트
        $(document).ready(function(){
        	// 보류된 신고 건수 불러오기
        	$.ajax({
				url:"delayedReport.do",
				dataType: "html",
				type:"get",
				success:function(data){
					$("#delayedReport").html(data);
				},error:function(){
					console.log("전송실패!");
				}				
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
        
     // 회원 검색  이벤트
		 $('#searchBtn').on("click",function(){
			
			var dynamicBtn = '<input type="button" class="btnyn" value="삭제하기"/>';
			
			
			$.ajax({
				url:"reportSearchList.do",
				type:'post',
				data:$("#reportSearchForm").serialize(),
				dataType:"json",
				success:function(data){
					
					$tableBody = $("#report_table tbody");
					$tableBody.html("");
	
					$tableFoot = $("#report_table tfoot");
					var $tr2 = $("<tr>");				
					
					for(var i in data){
						var $tr = $("<tr>");
						var $dNO = $("<td>").text(data[i].dNO);
						var $dDiv = $("<td>").text(data[i].dDiv+"."+data[i].dNumber);
						var $dType = $("<td>").text(data[i].dType);
						var $dContent = $("<td>").text(data[i].dContent);
						var $dReportDate = $("<td>").text(data[i].dReportDate);
						var $dComplete = $("<td>").text(data[i].dComplete);
						var $ynBtn = $("<td>").html(dynamicBtn); // 이동 버튼
						
							$tr.append($tr);
							$tr.append($dNO);
							$tr.append($dDiv);
							$tr.append($dType);
							$tr.append($dContent);
							$tr.append($dReportDate);
							$tr.append($dComplete);
							$tr.append($ynBtn);
							
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

		// 페이징 처리
			function page(){ 
				
			    $('#report_table').each(function() {

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
			// 페이지 마우스 오버 효과
			$(document).on('mouseover','.pageNum',function(){
				$(this).css("color","red").css("cursor","pointer");
			});
			$(document).on('mouseout','.pageNum',function(){
				$(this).css("color","black");
			});
	    	// 리프래시를 위한 메소드
		   	 function refresh(){
		   			location.reload();
		   		}
		
    </script>
	
</body>
</html>