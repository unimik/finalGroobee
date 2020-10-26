<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admingroupPage</title>
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
                <c:import url="commonAdmin/sidebar.jsp"/>
                <p id="title">GROOBEE 회원관리</p>
                <div id="searchBox">
                    <div id="all_group">
                        <p>현재 GROOBEE Group은 <b id="total" style="color: red;"></b> 개 입니다.</p>
                    </div>
                    <div id="search">
                        <form id="groupSearch_form" name="groupSearch_form">
                            <label>그 룹 명</label><input type="text" id="name" name="name">
                            <label>관 심 사</label><select id="category" name="category">
								<option disabled="disabled" selected="selected">---------</option>
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
                            </select><br><br>
                            <label>태그</label><input type="text" id="tag" name="tag">
                            <!-- <select id="chat">
                                <option>전체</option>
                                <option>N</option>
                                <option>Y</option> 
                            </select>-->
                            <label>생 성 일</label><input type="date" id="enrolldate" name="enrolldate"><br>
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                            <input type="reset" id="resetBtn" name="resetBtn" value="초기화">
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
                            <td>정지</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="group_info">
                            <td>1</td>
                            <td>나만없어고양이</td>
                            <td>반려동물</td>
                            <td>999</td>
                            <td>2020-10-07</td>
                            <td>#고양이</td>
                            <td>Y</td>
                            <td><button id="group_delete">삭제</button></td>
                        </tr>
                    </tbody>
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
        
        
    	// 회원 검색 버튼 클릭 이벤트
		 $('#searchBtn').on("click",function(){
			console.log("클릭했엉?");
			
			var dynamicBtnY = '<input type="button" name="btn" value="OUT"/>';
			var dynamicBtnN = '<input type="button" name="btn" value="IN"/>';
			

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
						if(data[i].mStatus==='Y'){
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