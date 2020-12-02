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
<link rel="stylesheet" href="resources/css/admin3.css">
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
				<p id="title">GROOBEE Group관리</p>
				<div id="searchBox">
					<div id="all_group">
						<p>
							현재 GROOBEE Group은 <b id="total" style="color: red;"></b> 개 입니다.
						</p>
					</div>
					<div id="search">
						<form id="groupSearch_form" name="groupSearch_form">
							<label>그 룹 명</label><input type="text" id="name" name="name">
							<label>관 심 사</label><select id="category" name="category">
								<option>문화/책</option>
								<option>영화</option>
								<option>미술/디자인</option>
								<option>공연/전시</option>
								<option>외국어</option>
								<option>외국</option>
								<option>맛집</option>
								<option>요리/레시피</option>
								<option>인테리어/DIY</option>
								<option>음악</option>
								<option>엔터테인먼트</option>
								<option>반려동물</option>
								<option>여행</option>
								<option>육아/결혼</option>
								<option>스포츠</option>
								<option>지역</option>
							</select><br>
							<br> <label id="g_tag">태그</label><input type="text" id="tag" name="tag">
							<!-- <select id="chat">
                                <option>전체</option>
                                <option>N</option>
                                <option>Y</option> 
                            </select>-->
							<label>생 성 일</label><input type="date" id="enrolldate"
								name="enrolldate"><br> <input type="button"
								id="searchBtn" name="searchBtn" value="검색"> <input
								type="reset" id="resetBtn" name="resetBtn" value="초기화">
						</form>
					</div>
				</div>
			</div>
			<div id="containar">
				<table name="group_table" cellspacing="0" id="group_table">
					<thead>
						<tr>
							<td>번호</td>
							<td>그룹명</td>
							<td>관심사</td>
							<td>인원</td>
							<td>생성일</td>
							<td>태그</td>
							<td>활성화</td>
							<td>활동정지</td>
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
        $(document).ready(function(){
        	$.ajax({
				url:"totalGroups.do",
				dataType: "html",
				type:"get",
				success:function(data){
					console.log(data);
					$("#total").html(data);
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
    	// 리프래시를 위한 메소드
   	 function refresh(){
   			location.reload();
   		}

        
    	// 회원 검색 버튼 클릭 이벤트
		 $('#searchBtn').on("click",function(){
			console.log("클릭했엉?");
			
			var dynamicBtnY = '<input type="button" class="g_btn" value="OUT"/>';
			var dynamicBtnN = '<input type="button" class="g_btn" value="IN"/>';
			
			console.log("전달되는 값"+$("#groupSearch_form").serialize());
			
			$.ajax({
				url:"groupSearch.do",
				type:'post',
				data:$("#groupSearch_form").serialize(),
				dataType:"json",
				success:function(data){
					console.log(data);
					
					$tableBody = $("#group_table  tbody");
					$tableBody.html("");
					
					$tableFoot = $("#group_table tfoot");
					var $tr2 = $("<tr>");
					
					for(var i in data){
						
						var $tr = $("<tr>");
						var $gNo = $("<td>").text(data[i].gNo);	// 그룹 넘버
						var $gName = $("<td>").text(data[i].gName);	// 그룹명
						var $gCategory = $("<td>").text(data[i].gCategory); // 관심사
						var $gMax = $("<td>").text(data[i].gMax);	// 인원
						var $gDate = $("<td>").text(data[i].gDate);// 생성일
						var $gTag = $("<td>").text(data[i].gTag); // 태그
						var $gStatus = $("<td>").text(data[i].gStatus); // 활성화 여부
						
						// 정지 버튼
						if(data[i].gStatus==='Y'){
							var $getOutBtn = $("<td>").html(dynamicBtnY); // 활성화 상태가 Y일 때 
						}else{
							var $getOutBtn = $("<td>").html(dynamicBtnN); // 활성화 상태가 N일 때
						}
						
							$tr.append($gNo);
							$tr.append($gName);
							$tr.append($gCategory);
							$tr.append($gMax);
							$tr.append($gDate);
							$tr.append($gTag);
							$tr.append($gStatus);
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
    	
			// feed 상태 변경을 위한 이벤트
			$(document).on('click','.g_btn',function(){
				
				var no = $(this).parent().prev().prev().prev().prev().prev().prev().prev().text();
				var status = $(this).parent().prev().text();

				 $.ajax({
					url:"groupStatusChange.do",
					type:'post',
					data:{no:no
						,status:status
										},
					success:function(data){
						alert("그룹정보가 업데이트 되었습니다");
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
</script>

</body>
</html>