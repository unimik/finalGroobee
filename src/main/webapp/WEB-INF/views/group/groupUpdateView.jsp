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
                           <c:if test="${ !empty gmList }">
	                           <table class="member select">
	                           		<c:forEach var="gm" items="${ gmList }">
		                               <tr>
		                                   <td>${ gm.gmLevel }</td>
		                                   <c:if test="${ !empty loginUser.mImage }">
		                                   		<td><img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }"></td>
		                                   </c:if>
		                                   <c:if test="${ empty loginUser.mImage }">
		                                   		<td><img src="<%=request.getContextPath()%>/resources/icons/pro_default.png" ></td>
		                                   </c:if>
		                                   <td>${ gm.gmId }</td>
		                                   <td><img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" class="groupMemberMenu"></td>
		                               </tr>
	                              	</c:forEach>
	                           </table>
                           </c:if>
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
                           	   <c:if test="${ !empty NgmList }">
                               <div id="permit_user">
                               	   <c:forEach var="Ngm" items="${ NgmList }">
	                                   <ul class="permit_userInfo">
	                                       <li>${Ngm.gmLevel}</li>
	                                       <c:if test="${ !empty loginUser.mImage }">
	                                       		<li><img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }"></li>
	                                       </c:if>
	                                       <c:if test="${ empty loginUser.mImage }">
	                                       		<li><img src="<%=request.getContextPath()%>/resources/icons/pro_default.png"></li>
	                                       </c:if>
	                                       <li>${ Ngm.gmId }<input type="hidden" id="NgmId" name="NgmId" value="${ Ngm.gmId }"></li>
	                                       <li><input type="button" id="user_Y" name="user_Y" value="승인"></li>
	                                       <li><input type="button" id="user_N" name="user_N" value="거절"></li>
	                                   </ul>
	                                   <c:if test="${ !empty Ngm.a1 }">
		                                   <div class="permit_answer" id="permit_answer">
		                                       <p>답변1 : ${ Ngm.a1 }</p>
		                                       <c:if test="${ !empty Ngm.a2 }">
		                                       <p>답변2 : ${ Ngm.a2 }</p>
		                                       </c:if>
		                                       <c:if test="${ !empty Ngm.a3 }">
		                                       <p>답변3 : ${ Ngm.a3 }</p>
		                                       </c:if>
		                                   </div>
	                                   </c:if>
                                   </c:forEach>
                               </div>
                               </c:if>                      
                           </div>
                       </div>
                   </div>
               </div>



               <!-- 팝업 메뉴-->
               <div class="pop_menu_gmList">
                   <div id="feed_menu_gmlist">
                       <ul>
                          <li><a>그룹장 위임</a></li>
                          <li><a>매니저 임명</a></li>
                          <li><a>그룹 내보내기</a></li>
                          <li><a>신고</a></li> 
                          <li><a class="close">취소</a></li>
                       </ul>
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
                    if( $("#management_container").hide){
                        $("#info_container").hide();
                        $("#permit_first").hide();
                        $("#management_container").show();

                        $("#page_name").empty();
                        $("#page_name").html("&nbsp;&nbsp;&nbsp;회원 관리");
                    }
                    
                });

                $(".group_permit").on("click",function(){
                    if( $("#permit_first").hide){
                        $("#info_container").hide();
                        $("#permit_first").show();
                        $("#management_container").hide();

                        $("#page_name").empty();
                        $("#page_name").html("&nbsp;&nbsp;&nbsp;승인 관리");
                    }
                    
                });
                

                // 팝업처리
                $(".groupMemberMenu").on("click",function(){
                    $(".pop_menu_gmList").show();
                });
                $('.close').on('click',function(){
                    $('.pop_menu_gmList').hide();
                });

            });
			
            
            // 회원 승인
            $(function(){

            	$('#user_Y').on("click", function(){
                	$.ajax({
                		url:"gmUpdate.do",
                		data:{ gmId:$('#NgmId').val(), gNo:${g.gNo}},
                		type:"post",
                		success:function(data){
                			if(data>0){
                				alert("승인하셨습니다.");
                			}
                		}, error:function(){
                			alert("오류");
                		}
                	});
                });	
            })
            
            $(function(){
                $('.permit_answer').slideUp();
                $('.permit_userInfo').click(function(){
                // $(this).next('p').slideDown();
                    $(this).next('div').slideToggle(300,function(){
                        console.log('slideToggle() 실행');
                    });
                });
            });
    
            $(document).ready(function () {
                $('#chat_icon').click(function () {
                    var state = $(".chat").css('display');
                    if (state == 'none') {
                        $('.chat').show();
                    } else {
                        $('.chat').hide();
                    }
                });
            });

            $('.tab_menu_btn').on('click', function () {
                $('.tab_menu_btn').removeClass('on');
                $(this).addClass('on')
            });

            $('.tab_menu_btn1').on('click', function () {
                $('.tab_box').hide();
                $('.tab_box1').show();
            });

            $('.tab_menu_btn2').on('click', function () {
                $('.tab_box').hide();
                $('.tab_box2').show();
            });

            $(document).ready(function () {
                $('#detailInfo').click(function () {
                    $(".myAccount").animate({ width: "toggle" }, 250);
                });
            });

            $('.MyTab_tab').on("click", function () {
                $('.MyTab_tab').removeClass('on');
                $(this).addClass('on')
            });

            $('.MyTab_tab1').on('click', function () {
                $('.MyTab_box').hide();
                $('.MyTab_box1').show();
            });

            $('.MyTab_tab2').on('click', function () {
                $('.MyTab_box').hide();
                $('.MyTab_box2').show();
            });
            
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
    		
    		$('#cancel').on("click",function(){
    			location.href="javascript:history.go(-1);";
    		});
        </script>
</body>
</html>