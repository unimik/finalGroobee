<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/resources/css/groupInsertView.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
		<div id="feedArea">
        	<form action="ginsert.do" id="joinform" method="post" enctype="multipart/form-data">
            	<div id="group_create">
                	<div class="container">
                	<input type="hidden" id="gCreator" name="gmId" value="${ loginUser.userId }">
                    	<p id="title">그룹 만들기</p>
                    </div>
                   	<div class="container" id="container_main_first">
                    	<div class="container second" id="container_main_first_first">
                        	<div class="groupImg">
                        		<div id="imgView"></div>
                        		<p id="p_title">그룹 프로필사진</p>
                        		<input type="file" id="groupProfile" name="file" accept="image/*" onchange="sethumbnail(event);">
                        	</div>
                        	
                        	<div class="container third" id="container_main_first_first_first">
                            	<p id="p_title">그룹 이름</p>
                                <input type="text" class="container third" id="inputBox" name="gName">
                            </div>
                            <div class="container third" id="container_main_first_first_third">
                            	<p id="p_title">최대 인원수</p>
                                <input type="number" class="container third" id="inputBox" name="gMax">
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
                            <input type="file"  id="uploadFile" name="file" accept="image/*" onchange="sethumbnail2(event);"/>
                            <div id="imgBox"></div>
                        </div>
                        <div id="container_main_seventh_first">
                            <p id="p_title">그룹 소개</p>
                            <textarea cols="80" rows="5" id="groupInfo" name="gIntro" placeholder="간단한 그룹 소개말을 작성해주세요."></textarea>
                        </div>
                        <div id="container_main_eighth_first">
                            <p id="p_title">그룹 태그</p>
                            <input type="text" id="groupTag" name="gTag" placeholder=" '# 키워드' 를 입력해주세요       EX) #축구">
                        </div>
                    </div>
               </div>
               <div class="container" id="container_main_ninth">
                   <input type="submit" id="submit" value=" 그룹 생성">
                   <input type="button" id="cancel" value="취소">
               </div>
            </form>
        </div>
	</div>
	<script>
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