<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="${ contextPath }/resources/css/common.css">
    <link rel="stylesheet" href="${ contextPath }/resources/css/home.css">
    <link rel="stylesheet" href="${ contextPath }/resources/css/chat.css">
    <link rel="stylesheet" href="${ contextPath }/resources/css/myAccount.css">
    <link rel="stylesheet" href="${ contextPath }/resources/css/postInsertForm.css">
    <title>G R O O B E E</title>
</head>
<body>
    <div class="wapper">
        <c:import url="../common/menubar.jsp"/>
        <div class="content">
            <div class="search_userInfo">
                
            </div>
            <!--피드 영역 스크롤 필요해서 position 인라인으로 변경해둠-->
            <div id="feedArea" style="position: relative;">
                <!-- 전체 감싸는 div 영역 -->
                <div id="postingForm">
                    <h4>피드 수정하기</h4>
                    <hr>
                    <form action="pUpdate.do" method="post" id="postInsert" enctype="multipart/form-data">
                    	<input type="hidden" name="fWriter" value="${ loginUser.userId }">
						<input type="hidden" name="mNo" value="${ loginUser.mNo }">
						<input type="hidden" name="originName" value="${ p.originName }">
						<input type="hidden" name="changeName" value="${ p.changeName }">
                        <table id="tbb">
                            <!-- 글 쓰는 영역 -->
                            <tr>
                                <td>
                                    <textarea cols="60" rows="7" name="fContent">${ f.fContent }</textarea>
                                </td>    
                            </tr>
                            <!-- 파일 첨부 영역 -->
                            <tr>
                                <td>
                                    <img id="fileIcon" src="${ contextPath }/resources/icons/add_file.png">
                                </td>
                                <td class="filetb">
                                    <input type="file" multiple="multiple" id="input_file" name="reloadFile"
                                     accept="image/png, image/jpeg, image/JPEG, image/jpg, image/bmp, image/gif">
                                    <c:if test="${ !empty p.originName }">
                                    	<a href="${ contextPath }/resources/pUploadFiles/${ p.changeName }"></a>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td id="underLine"></td>
                            </tr>
                            <tr>
                                <td class="checkList tdfi">작성위치</td>
                                <td class="tdfi">
                                    <select id="select_board">
                                        <option value="myFeed">내 피드</option>
                                        <option value="group">그룹 피드</option>
                                    </select>
                                </td>
                                <td>
                                    <select id="myGroupList" name="gNo">
                                    	<c:forEach var="g" items="${ gn }">
                                    	<c:if test="${ empty g.gmId }">
                                        	<option>가입된 그룹이 없습니다.</option>
                                    	</c:if>
                                    	
                                    	<c:if test="${ loginUser.userId eq g.gmId }">
											<option value="${ g.gNo }">${ g.gName }</option>
										</c:if>
										</c:forEach>
                                    </select>
                                </td>
                            </tr>
                            
                            <!--공개여부 설정-->
                            <tr height="50px">
                                <td class="checkList tdfi">공개여부</td>
                                <td class="tdfi">
                                    <select>
                                    	<c:forEach var="open" items="feed">
                                        <option id="public" value="Y">전체공개</option>
                                        <option id="friends" value="F">친구만</option>
                                        <option id="private" value="G">비공개</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <!--그 외 설정들 라디오 버튼의 value 값 정해지면 수정해야함-->
                            <tr height="35px">
                                <td class="checkList">설정</td>
                                <td class="st">좋아요</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="like" id="" value="Y" checked ><label for="like">허용</label></li>
                                        <li><input type="radio" name="like" id="" value="N" ><label for="like">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr height="35px">
                                <td class="checkListse st">댓글</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="reply" id="" value="Y" checked ><label for="reply">허용</label></li>
                                        <li><input type="radio" name="reply" id="" value="F" ><label for="reply">친구만 허용</label></li>
                                        <li><input type="radio" name="reply" id="" value="N" ><label for="reply">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr height="35px">
                                <td class="checkListse st">공유</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="share" id="" value="Y" checked ><label for="share">허용</label></li>
                                        <li><input type="radio" name="share" id="" value="N" ><label for="share">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td id="btnstd">
                                    <button id="btns1">
                                        <a id="page_back" href="home.do">이전</a>
                                    </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input id="btns2" type="submit" value="작성">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script>

        $(document).ready(function(){
        	
            $('#chat_icon').click(function(){
                var state = $(".chat").css('display');
                if(state=='none'){
                    $('.chat').show();
                }else{
                    $('.chat').hide();
                }
            });

            /*************** 그룹 선택 옵션 *****************/

            $('#select_board').change(function(){
                var state = $("#select_board option:selected").val();
                
                if(state == 'group'){
                    $('#myGroupList').css("display","block");
                } else{
                    $('#myGroupList').hide();
                }
            })
        });


       $('.tab_menu_btn').on('click',function(){
            $('.tab_menu_btn').removeClass('on');
            $(this).addClass('on')
        });

        $('.tab_menu_btn1').on('click',function(){
            $('.tab_box').hide();
            $('.tab_box1').show();
        });

        $('.tab_menu_btn2').on('click',function(){
            $('.tab_box').hide();
            $('.tab_box2').show();
        });


        /************* 내계정 자세히보기 script **************/

        $(document).ready(function(){
            $('#detailInfo').click(function(){
                $(".myAccount").animate({width:"toggle"},250);
            });
        });

        $('.MyTab_tab').on("click",function(){
            $('.MyTab_tab').removeClass('on');
            $(this).addClass('on')
        });

        $('.MyTab_tab1').on('click', function(){
            $('.MyTab_box').hide();
            $('.MyTab_box1').show();
        });

        $('.MyTab_tab2').on('click', function(){
            $('.MyTab_box').hide();
            $('.MyTab_box2').show();
        });

        
        /************* 파일 다중 업로드 Ajax 
        
        function UploadBtn() {
        	
        	var form = $("#postInsert")[0];
        	var formData = new FormData(form);
        	
        	$.ajax({
        		type: 'post',
        		url: 'MultiUpload.do',
        		data: formData,
        		processData: false,
        		contentType: false,
        		success: function(data) {
        			alert("포스트 업로드에 성공하였습니다.");
        			$
        		},
        		error: function(html) {
        			alert("포스트 업로드에 실패하였습니다.");
        			console.log(error);
        			console.log(error.status);
        		}
        	});
        }
        
        **************/
    </script>
</body>
</html>