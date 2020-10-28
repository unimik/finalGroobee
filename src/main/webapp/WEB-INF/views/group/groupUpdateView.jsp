<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/resources/css/groupUpdate.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/pop_menu.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
            <div id="feedArea">
                   <!--공통 부분-->
                   <div class="container" id="common_container1">
                       <p id="title">그룹관리</p>
                   </div>
                   <div class="container" id="common_container2">
                       <button  id="group_updateBtn" class="group_update group_menubtn on">
                           그룹 정보 수정
                       </button>
                       <button id="group_memberBtn" class="group_member group_menubtn">
                           회원 관리
                       </button>
                       <button id="group_permitBtn" class="group_permit group_menubtn">
                           승인 관리
                       </button>
                   </div>
                   <div class="container second" id="search_container">
                       <div id="search_container_first">
                           <p id="page_name">그룹 정보 수정</p>
                       </div>
                       <div id="search_container_second">
                           <input type="search" id="searchBox" name="searchBox"/><input type="button" id="searchBtn" name="searchBtn" value="검색" />
                       </div>
                   </div>

                   <!-- 1.회원관리-->
                   <div id="management_container">

                       <!--회원 정보 출력-->
                       <div class="member main" id="member_main">
	                           <div class="member select">
                           			
	                           </div>
                       </div>
                   </div> 
					<div class="feed_report">
                        <div id="feed_report_con">
                            <p>신고사유</p>
                            <select id="reportType" class="selectRtype">
                                <option value="unacceptfeed">부적절한 게시글</option>
                                <option value="insult">욕설</option>
                                <option value="ad">광고</option>
                                <option value="spam">도배</option>
                            </select>
                            	<textarea class="sendreport" id="reportContent" cols="28" rows="4"></textarea>
                            <br>
                            <input class="selectRtype" id="selectRtype"type="button" value="확인" style="cursor:pointer;">
                            <input class="sendreport" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
                            <button class="selectRtype" id="cancel" style="cursor:pointer;">취소</button>
                            <button class="sendreport" id="cancel2" style="cursor:pointer; display:none;">취소</button>
                        </div>
                    </div>
					
                   <!--2. info-->
                   <div class="container second" id="info_container">

                       <div class="container" id="container_first">
                           <form action="groupUpdate.do" id="updateform" method="post" enctype="multipart/form-data">
                               <input type="hidden" name="gNo" value="${ g.gNo }">
                               <div id="group_update">
                                   <div class="container" id="container_main_first">
                                       <div class="container second" id="container_main_first_first">
                                           <div class="groupImg">
                                           		<c:if test="${ !empty g.gProfile }">
				                        		<div id="imgView"><img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameProfile }"></div>
				                        		<p id="p_title">그룹 프로필사진</p>
				                        		<input type="file" id="groupProfile" name="file" accept="image/*" onchange="sethumbnail(event);">
			                        	   		</c:if>
			                        	   		<c:if test="${ empty g.gProfile }">
			                        	   		<div id="imgView"><img src="<%=request.getContextPath()%>/resources/icons/g_pro.png"></div>
				                        		<p id="p_title">그룹 프로필사진</p>
				                        		<input type="file" id="groupProfile" name="file" accept="image/*" onchange="sethumbnail(event);">
			                        	   		</c:if>
			                        	   </div>
			                                           
                                           <div class="container third" id="container_main_first_first_first">
                                               <p id="p_title">그룹 이름</p>
                                               <input type="text" class="container third" value=" ${ g.gName }" id="inputBox" name="gName">
                                           </div>
                                           <div class="container third" id="container_main_first_first_third">
                                               <p id="p_title">최대 인원수</p>
                                               <input type="number" class="container third" value="${ g.gMax }"id="inputBox" name="gMax">
                                           </div>
                                       </div>
                                       <div class="container second" id="container_main_first_second">
                                           <div class="container third" id="container_main_first_second_first" >
                                               <p id="p_title">그룹 관심사</p>
                                               <select class="container third" id="container_main_first_second_second" name="gCategory">
                                                   <option selected disabled>---------------------</option>
			                                       <option value="문화/책">문화/책</option>
			                                       <option value="영화">영화</option>
			                                       <option value="미술/디자인">미술/디자인</option>
			                                       <option value="공연/전시">공연/전시</option>
			                                       <option value="음악">음악</option>
			                                       <option value="엔터테인먼트">엔터테인먼트</option>
			                                       <option value="반려동물">반려동물</option>
			                                       <option value="여행">여행</option>
			                                       <option value="외국">외국</option>
			                                       <option value="맛집">맛집</option>
			                                       <option value="요리/레시피">요리/레시피</option>
			                                       <option value="인테리어/DIY">인테리어/DIY</option>
			                                       <option value="육아/결혼">육아/결혼</option>
			                                       <option value="스포츠">스포츠</option>
			                                       <option value="지역">지역</option>
                                               </select>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="container" id="container_main_second">
                                       <div id="container_main_second_first">
                                           <p id="p_title">공개 여부</p>
                                           <input type="radio" id="open" name="gOpenScope" value="Y"><label for="gOpenScope">공개</label>
                                           <input type="radio" id="not_open" name="gOpenScope" value="N"><label for="gOpenScope">비공개</label>
                                       </div>
                                       <div id="container_main_third_first">
                                           <p id="p_title">가입 승인</p>
                                           <input type="radio" id="approve" name="gJoinSet" value="Y"><label for="gJoinSet">허용</label>
                                           <input type="radio" id="not_approve" name="gJoinSet" value="N"><label for="gJoinSet">비허용</label>
                                       </div>
                                       <div id="container_main_fourth_first">
                                           <p id="p_title">가입 질문</p>
                                           <input type="radio" id="questionY" name="gQset" value="Y"><label for="gQset">있음</label>
                                           <input type="radio" id="questionN" name="gQset" value="N"><label for="gQset">없음</label>
                                       </div>
                                       <div id="container_main_fifth_first">  
                                           <p id="p_title">질문</p>
                                           <input type="text" id="question" name="q1" placeholder="질문 설정은 최대 3개까지 가능합니다." />&nbsp;
                                           <input type="button" id="add_question" name="add_question" value="+" />
                                           <input type="button" id="sub_question" name="sub_question" value="-">
                                       </div>
                                       <div id="container_main_sixth_first">
                                           <p id="p_title">대표 사진</p>
                                           <c:if test="${ !empty g.gImage }">
                                            <input type="file"  id="uploadFile" name="file" accept="image/*" onchange="sethumbnail2(event);"/>
                                           <div id="imgBox"><img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameImage }"></div>
                                       		</c:if>
                                       		<c:if test="${ empty g.gImage }">
                                       		<input type="file"  id="uploadFile" name="file" accept="image/*" onchange="sethumbnail2(event);"/>
                                           <div id="imgBox"><img src="<%=request.getContextPath()%>/resources/images/g_back.png"></div>
                                       		</c:if>
                                       </div>
                                       <div id="container_main_seventh_first">
                                           <p id="p_title">그룹 소개</p>
                                           <textarea cols="80" rows="5" id="groupInfo" name="gIntro" placeholder="${ g.gIntro }">${ g.gIntro }</textarea>
                                       </div>
                                       <div id="container_main_eighth_first">
                                           <p id="p_title">그룹 태그</p>
                                           <input type="text" id="groupTag" name="gTag" value="${ g.gTag }" placeholder=" '# 키워드' 를 입력해주세요       EX) #축구">
                                       </div>
                                   </div>
                               </div>
                               <div class="container" id="container_main_ninth">
                                   <input type="submit" id="submit" value=" 수정">
                                   <input type="button" id="cancel" value="취소">
                               </div>
                           </form>
                       </div>

                   </div> 

                   <!--3. permit-->
                   <div class="container second" id="permit_first">
                       
                       <div class="permit_MemberAnswer" id="permit_MemberAnswer">
                       		<div class="permit_member" id="permit_member">
                       			<div id="permit_user">
                       			</div>
                       		</div>
                       </div>
                   </div>
               </div>
        </div>
        <script>

            // groupUdate 메뉴 버튼 이벤트
            $(document).ready(function(){
            	
                $('.group_menubtn').on('click',function(){
                    $('.group_menubtn').removeClass('on');
                    $(this).addClass('on');
                });


                $(".group_update").on("click",function(){
                    if( $("#info_container").hide){
                        $("#info_container").show();
                        $("#permit_first").hide();
                        $("#management_container").hide();

                        $("#page_name").empty();
                        $("#page_name").html("&nbsp;&nbsp;&nbsp;그룹 정보 수정");
                    }
                
                });
                $(".group_member").on("click",function(){
                	getgmList();
                	
                    if( $("#management_container").hide){
                        $("#info_container").hide();
                        $("#permit_first").hide();
                        $("#management_container").show();

                        $("#page_name").empty();
                        $("#page_name").html("&nbsp;&nbsp;&nbsp;회원 관리");
                    }
                    
                });
                
                $(document).on("click","#gm_report",function(){
                    $('.feed_report').show();
                });
                
                $(".group_permit").on("click",function(){
                	 getNgmList();
                	
                    if( $("#permit_first").hide){
                        $("#info_container").hide();
                        $("#permit_first").show();
                        $("#management_container").hide();
						
                        $("#page_name").empty();
                        $("#page_name").html("&nbsp;&nbsp;&nbsp;승인 관리");
                    }
                   
                });
                
                // 팝업처리
             

                //******* 멤버 회원가입 답변 보기
                $('.showAnswer').on("click",function(){
                // $(this).next('p').slideDown();
                    $('.permit_answer').slideToggle(300,function(){
                        console.log('slideToggle() 실행');
                    });
                });
            });
            
            
            //****** 가입한 멤버 보기
			function getgmList(){
				var gNo = ${g.gNo};
				
				$.ajax({
					url:"gmList.do",
					data:{gNo:gNo},
					dataType:"json",
					success:function(data){
						$divAll = $('.select');
            			$divAll.html("");
            		    console.log(data);
            		    
            		    var $ul;
            		    var $li;
            		    var $gmLevel;
            		    var $profile;
            		    var $gmId;
            		    var $gmL;
            		    var $gmI;
            		    var $menuImg;
						var $div_back;
						var $div_popback;
						var $ul2;
						var $menu1;
						var $menu2;
						var $menu3;
						var $menu4;
						var $menu5;
						
						
						
						if(data.length > 0){
							for(var i in data){
								if( data[i].gmLevel == '그룹장'){
										
										$ul = $('<ul id="gm">');
										$gmLevel = $("<li>").text(data[i].gmLevel);
										$Profile = $("<li>").html('<img src="<%=request.getContextPath()%>/resources/icons/pro_default.png">');
										$gmId = $('<li id="gmId">').html(data[i].gmId);
										$gmL = $("<li>").html("<input type='hidden' id='g_gmL' name='g_gmL' value='" + data[i].gmLevel + "'>");
										
										
										$ul.append($gmLevel);
										$ul.append($Profile);
										$ul.append($gmId);
										$ul.append($gmL);
										$ul.append($gmI);
										$divAll.append($ul);
										
								} else if( data[i].gmLevel == '매니저'){
										$ul = $('<ul id="gm">');
										$gmLevel = $("<li>").text(data[i].gmLevel);
										$Profile = $("<li>").html('<img src="<%=request.getContextPath()%>/resources/icons/pro_default.png">');
										$gmId = $('<li>').html(data[i].gmId);
										$gmL = $("<li>").html("<input type='hidden' id='g_gmL' name='g_gmL' value='" + data[i].gmLevel + "'>");
										$menuImg = $("<li>").html('<img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" id="groupMemberMenu" class="groupMemberMenu">');
										$div_back = $('<div class="pop_menu_gmList">');
										$div_popback = $('<div id="feed_menu_gmlist">');
										$ul2 = $('<ul id="popGm">').html("<input type='hidden' id='g_gmI' name='g_gmI' value='"+ data[i].gmId + "'>");
										$menu1 = $('<li>').html('<a id="entrust">그룹장 위임</a>');
										$menu2 = $('<li>').html('<a id="changeMember">멤버로 변경</a>');
										$menu3 = $('<li>').html('<a id="del_gm">내보내기</a>');
										$menu4 = $('<li>').html('<a id="gm_report">신고</a>');
										$menu5 = $('<li>').html('<a class="close">취소</a>');
										
										$ul.append($gmLevel);
										$ul.append($Profile);
										$ul.append($gmId);
										$ul.append($gmL);
										$ul.append($menuImg);
										$ul2.append($menu1);
										$ul2.append($menu2);
										$ul2.append($menu3);
										$ul2.append($menu4);
										$ul2.append($menu5);
										$div_popback.append($ul2);
										$div_back.append($div_popback);
										$divAll.append($div_back);
										$divAll.append($ul);
								
								}else{
										$ul = $('<ul id="gm">');
										$gmLevel = $("<li>").text(data[i].gmLevel);
										$Profile = $("<li>").html('<img src="<%=request.getContextPath()%>/resources/icons/pro_default.png">');
										$gmId = $('<li>').html(data[i].gmId);
										$gmL = $("<li>").html("<input type='hidden' id='g_gmL' name='g_gmL' value='" + data[i].gmLevel + "'>");
										$menuImg = $("<li>").html('<img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" id="groupMemberMenu" class="groupMemberMenu">');
										$div_back = $('<div class="pop_menu_gmList">');
										$div_popback = $('<div id="feed_menu_gmlist">');
										$ul2 = $('<ul id="popGm">').html("<input type='hidden' id='g_gmI' name='g_gmI' value='"+ data[i].gmId + "'>");
										$menu1 = $('<li>').html('<a id="entrust">그룹장 위임</a>');
										$menu2 = $('<li>').html('<a id="changeManager">매니저 지정</a>');
										$menu3 = $('<li>').html('<a id="del_gm">내보내기</a>');
										$menu4 = $('<li>').html('<a id="gm_report">신고</a>');
										$menu5 = $('<li>').html('<a class="close">취소</a>');
											
											
										$ul.append($gmLevel);
										$ul.append($Profile);
										$ul.append($gmId);
										$ul.append($gmL);
										$ul.append($menuImg);
										$ul2.append($menu1);
										$ul2.append($menu2);
										$ul2.append($menu3);
										$ul2.append($menu4);
										$ul2.append($menu5);
										$div_popback.append($ul2);
										$div_back.append($div_popback);
										$divAll.append($div_back);
										$divAll.append($ul);
								}
							}
						}
					},error:function(){
						alert("오류");
					}
				});
    		};
    		
	              	
	        //************* 승인하지 않은 멤버 가져오기
            function getNgmList(){
            	var gNo = ${ g.gNo };
            	
            	$.ajax({
            		url:"NgmList.do",
            		data:{gNo:gNo},
            		dataType:"json",
            		success:function(data){
            			$divAll = $('#permit_user');
            			$divAll.html("");
            		    console.log(data);
            		    
            		    var $ul;
            		    var $li;
            		    var $gmLevel;
            		    var $img;
            		    var $gmId;
            		    var $inputAnswer;
            		    var $inputY;
            		    var $inputN;
            		    var $a1;
            		    var $a2;
            		    var $a3;
            		    var $div;
            		    var $p;
            		    
            		    if(data.length > 0){
            		    	for(var i in data){
            		    		$ul = $('<ul class="permit_userInfo">');
            		    		$gmLevel = $('<li>').text(data[i].gmLevel);
            		    		$img = $('<li>').html('<img src="<%=request.getContextPath()%>/resources/icons/pro_default.png">');
            		    		$gmId = $('<li id="NgmId" name="NgmId">').text(data[i].gmId);
            		    		$inputAnswer = $('<li>').html('<input type="button" class="showAnswer" id="showAnswer" name="showAnswer" value="답변보기">');
            		    		$inputY =$('<li>').html('<input type="button" class="user_Y" id="user_Y" name="user_Y" value="승인">');
            		    		$inputN =$('<li>').html('<input type="button" class="user_N" id="user_N" name="user_N" value="거절">');
            		    		$div = $('<div class="permit_answer" id="permit_answer">');
            		    		$a1 = $('<p>').text(data[i].a1);
            		    		$a2 = $('<p>').text(data[i].a2);
            		    		$a3 = $('<p>').text(data[i].a3);
            		    		
            		    		$ul.append($gmLevel);
            		    		$ul.append($img);
            		    		$ul.append($gmId);
            		    		$ul.append($inputAnswer);
            		    		$ul.append($inputY);
            		    		$ul.append($inputN);
            		    		$div.append($a1);
            		    		$div.append($a2);
            		    		$div.append($a3);
            		    		$divAll.append($ul);
            		    		$divAll.append($div);
            		    	}
            		    	
            		    }else{
            		    	$divAll.html("");
            		    	
            		    	$p = $('<p id="textP">').text("가입신청이 없습니다.");
            		    	$divAll.append($p);
            		    	
            		    }
            		}, error:function(){
            			console.log("실패");
            		}
            	});
            };
            
            
            
            //***************** 질문 추가/삭제 버튼 
            $(document).ready(function(){
                var i = 2;
                $('#add_question').on("click",function(){
                    $('#sub_question').show();
                    $('#container_main_fifth_first').append("<input type='text' id='question"+i+"' name='q"+i+"'>")
                    i++;
                    if(i>=4){
                        $('#add_question').attr("disabled","disabled");
                    };
                });

                $('#sub_question').on("click",function(){
                    if(i != 2){
                    $('#container_main_fifth_first input:last').remove();
                    $('#add_question').prop("disabled",false);
                    i--;

                    }
                });

    		});
    		
            //****************** 그룹사진 썸네일
            function sethumbnail(event){
    			var reader = new FileReader();
    			
    			reader.onload = function(event){
    				var img = document.createElement('img');
    				img.setAttribute("src",event.target.result);
    				document.querySelector("div#imgView>img").remove();
    				document.querySelector("div#imgView").appendChild(img);
    			};
    			
    			reader.readAsDataURL(event.target.files[0]);
    		} ;
            
            function sethumbnail2(event){
    			var reader = new FileReader();
    			
    			reader.onload = function(event){
    				var groupimg = document.createElement('img');
    				groupimg.setAttribute("src",event.target.result);
    				document.querySelector("div#imgBox>img").remove();
    				document.querySelector("div#imgBox").appendChild(groupimg);
    			};
    			
    			reader.readAsDataURL(event.target.files[0]);
    		};
    		
    		
    		//************** 수정하지 않기
    		$('#cancel').on("click",function(){
    			location.href="javascript:history.go(-1);";
    		});
    		
    		
    		
    
    		
    		 $(document).ready(function(){
    			 
    			 
    			//*******************  그룹장 변경 
    			
    		    $(document).on("click","#entrust",function(){
   	            	var gmL = $("#g_gmL").val();
    				var gNo = ${g.gNo};
   	            	console.log(gmL);
   	            	$.ajax({
   	            		url:"gmChangeLevel.do",
   	            		data:{ gmL:gmL, gNo:gNo },
   	            		type:"post",
   	            		success:function(data){
   	            			if(data > 0){
   	            				console.log("완료");
   	            				gmChangeMaster();
   	            			}
   	            		},error:function(){
   	            			alert("오류");
   	            		}
   	            	});
   			 	});
   			 	
    		    
    			//*******************  그룹장 변경 
				function gmChangeMaster(){
    	            	var gmId = $('#g_gmI').val();
    	            	var gNo = ${ g.gNo };
    	            	console.log(gmId);
    	            	console.log(gNo);
    	            	$.ajax({
    	            		url:"gmChangeMaster.do",
    	            		data:{ gmId:gmId, gNo:gNo },
    	            		type:"post",
    	            		success:function(data){
    	            			console.log(data);
    	            			if(data > 0){
    	            				alert("그룹장이 변경되었습니다.");
    	            				 $('.pop_menu_gmList').hide();
    	            				 gCreatorChange();	            				 
    	            			} else{
    	            				alert("전송실패");
    	            			}
    	            		},error:function(){
    	            			alert("오류");
    	            		}
    	            	});
    	            	
    	            };
    	         
    	            
        			//*******************  그룹의 그룹장 아이디 변경 
    	            function gCreatorChange(){
    	            	var gNo = ${g.gNo};
    	            	var gmI = $('#g_gmI').val();
    	            	console.log(gmI);
    	            	
    	            	location.href="gCreatorChange.do?gNo="+gNo+"&gmI="+gmI;
      	            };
      	            
      	            
      	          
        		  //*******************  그룹 매니저 지정 
      	          $(document).on("click", "#changeManager", function(){
	   	            	var gNo = ${g.gNo};
	 	            	var gmI = $('#g_gmI').val();
	   	            	$.ajax({
	   	            		url:"changeManager.do",
	   	            		data:{gmId:gmI, gNo:gNo},
	   	            		type:"post",
	   	            		success:function(data){
	   	            			if(data>0){
	   	            				gManagerChange();
	   	            			}else{
	   	            				alert("매니저를 지정할 수 없습니다.");
	   	            			}
	   	            		}, error:function(){
	   	            			alert("오류");
	   	            		}
	   	            	});
	   	            }); 
        		  
	      	      		//*******************  그룹 매니저 지정 후 gmList 다시 불러오기
	        	        function gManagerChange(){
	    	            	var gNo = ${g.gNo};
	    	            	var gmI = $('#g_gmI').val();
	    	            	
	    	            	$.ajax({
	    	            		url:"gManagerChange.do",
	    	            		data:{ gNo:gNo, gmI:gmI},
	    	            		type:"post",
	    	            		success:function(data){
	    	            			if(data > 0){
	    	            				alert("매니저를 지정하셨습니다.");
	    	            				getgmList();
	    	            			}
	    	            		},error:function(){
	    	            			alert("오류");
	    	            		}
	    	            	});
	    	            };
    	            
      	          
        		  	//*************** 매니저 -> 멤버로 변경
	      	        $(document).on("click", "#changeMember", function(){
	   	            	var gNo = ${g.gNo};
	 	            	var gmI = $('#g_gmI').val();
	 	            	$.ajax({
		            		url:"changeMember.do",
		            		data:{ gNo:gNo, gmI:gmI},
		            		type:"post",
		            		success:function(data){
		            			if(data > 0){
		            				gmChangeMember();
		            			}else {
	   	            				alert("멤버로 변경할 수 없습니다.");
		            			}
		            		},error:function(){
		            			alert("오류");
		            		}
		            	});
	   	            }); 
	      	      
			      	  //*************** 매니저 -> 멤버로 변경 후 gmList 다시 불러오기
		  	        function gmChangeMember(){
			            	var gNo = ${g.gNo};
			            	var gmI = $('#g_gmI').val();
			            	$.ajax({
		   	            		url:"gManagerDelete.do",
		   	            		data:{gmI:gmI, gNo:gNo},
		   	            		type:"post",
		   	            		success:function(data){
		   	            			console.log(data);
		   	            			if(data>0){
		   	            				alert("멤버로 변경하였습니다.");
		   	            				getgmList();
		   	            			}
		   	            		}, error:function(){
		   	            			alert("오류");
		   	            		}
		   	            	});
			            };
			            
			            
    	        	var gNo = ${ g.gNo }; 
    		        // 회원 승인
    		        $(document).on("click", "#user_Y", function(event){
    		              	$.ajax({
    		              		url:"gmUpdate.do",
    		              		data:{ gmId:$('#NgmId').text(), gNo:gNo },
    		              		type:"post",
    		              		async:false,
    		              		success:function(data){
    		              			if(data>0){
    		              				alert("승인하셨습니다.");
    		              				getNgmList();
    		              			}
    		              		}, error:function(){
    		              			alert("오류");
    		              		}
    		              	});
   		              });
   		            	
   		            	
   		            $(document).on("click","#user_N",function(event){
  		            		$.ajax({
  		            			url:"gmDeleteCheck.do",
  		            			data:{ gmId:$('#NgmId').text(), gNo:gNo },
  		            			type:"post",
  		            			async:false,
  		            			success:function(data){
  		            				if(data > 0){
  		            					alert("승인거부하셨습니다.");
  		            					getNgmList();
  		            				}
  		            			}, error:function(){
  		            				alert("오류");
  		            			}
  		            		});
   		            });
    		            
    		       $(document).on("click","#del_gm",function(){
    		            	var gmId= $('#g_gmI').val();
    		            	var gNo = ${ g.gNo };
    	         		$.ajax({
    	         			url:"gmDeleteCheck.do",
    	         			data:{ gmId:gmId, gNo:gNo },
    	         			type:"post",
    	         			async:false,
    	         			success:function(data){
    	         				if(data > 0){
    	         					alert("강퇴하셨습니다.");
    	         					$('.pop_menu_gmList').hide();
    	         					getgmList();
    	         				}
    	         			}, error:function(){
    	         				alert("오류");
    	         			}
    	         		});
    	         	});
    		            
    		            
    		            $(document).on("click","#groupMemberMenu",function(){
    		            	var id = $('#g_gmI').val();
    		            	console.log(id);
    	                    $(".pop_menu_gmList").show();
    	                });
    	                
    	                $(document).on('click','.close',function(){
    	                    $('.pop_menu_gmList').hide();
    	                });
    	                
    		           
    		        });
    		 	
    		 /**************** 그룹 신고 관련*******************/ 
     		$(document).on('click',"#report-submit",function(){
     			
     			if($("#reportContent").val() == ""){
     				alert('신고 사유를 입력해 주세요.')
     			}else{
     				
     				$.ajax({
     					url:'/spring/report.do',
     					data:{
     						reportType : $("#reportType").val(),
     						feedType : "groop",
     						content : $("#reportContent").val()
     					},
     					success: function(){
     						$(".feed_report").css('display','none');
     						$(".selectRtype").css("display","inline-block");
     			      		$(".sendreport").css("display","none");
     			      		$("#reportContent").val('')
     						alert('신고완료');
     					},error:function(){
     						alert('신고 실패!');
     					}
     				});
     				
     			};
     		});
           	 
           	$("#cancel2").on('click',function(){
           		$(".feed_report").css('display','none');
     			$(".selectRtype").css("display","inline-block");
           		$(".sendreport").css("display","none");
           	})
           	
           	$("#selectRtype").on('click',function(){
           		$(".selectRtype").css("display","none");
           		$(".sendreport").css("display","block");
           	}); 
        </script>
</body>
</html>