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
            <div id="chat" name="chat" class="chat">
                <div class="tab_menu">
                    <button class="tab_menu_btn1 tab_menu_btn on">내 채팅</button>
                    <button class="tab_menu_btn2 tab_menu_btn">그룹</button>
                    <div class="tab_box_container">
                        <div class="tab_box1 tab_box on">
                            <div id="search_f">
                                <input type="search" id="f_list" name="f_list" placeholder="친구 검색">
                                <input type="button" id="searchBtn" name="searchBtn" value="검색">
                            </div>
                            <div id="myChat_list">
                                <ul id="list">
                                    <li><img src="${ contextPath }/resources/images/IMG_7273.JPEG" alt="" id="chat_back"></li>
                                    <li>user02</li>
                                    <li>그래서 어떻게 됐음?</li>
                                </ul>
                            </div>
                            <div id="myChat_list">
                                <ul id="list">
                                    <li><img src="${ contextPath }/resources/images/IMG_7460.JPG" alt="" id="chat_back"></li>
                                    <li>user03</li>
                                    <li>나는 낼 들어온다 안녕~</li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab_box2 tab_box">
                            <div id="search_g">
                                <input type="search" id="g_list" name="g_list" placeholder="그룹 검색">
                                <input type="button" id="searchBtn" name="searchBtn" value="검색">
                            </div>
                            <div id="myGroupChat_list">
                                <ul id="list">
                                    <li><img src="${ contextPath }/resources/images/group_sample.png" alt="" id="chat_back"></li>
                                    <li>강남 사람</li>
                                    <li>오늘 날씨 좋지 않나요?</li>
                                </ul>
                            </div>
                            <div id="myGroupChat_list">
                                <ul id="list">
                                    <li><img src="${ contextPath }/resources/images/IMG_7460.JPG" alt="" id="chat_back"></li>
                                    <li>떠나자 여행</li>
                                    <li>거기 여행지로 추천!!</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="search_userInfo">
                <div class="myAccount">
                    <div id="myId">
                        <img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="myProfile" id="myProfile">
                        <p>${ loginUser.userId }</p>
                    </div>
                    <div id="MyTab">
                        <button class="MyTab_tab1 MyTab_tab on">친구</button>
                        <button class="MyTab_tab2 MyTab_tab">그룹</button>
                        <div id="MyTab_container">
                            <div class="MyTab_box1 MyTab_box on">
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="${ contextPath }/resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>${ userId }</li>
	                                        <c:if test="${ followUser.follows eq mNo }">
	                                        <li><button id="following" name="following">팔로잉</button></li>                                        	
	                                        </c:if>
	                                	<li><button id="follow" name="follow">팔로우</button></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="MyTab_box2 MyTab_box">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--피드 영역 스크롤 필요해서 position 인라인으로 변경해둠-->
            <div id="feedArea" style="position: relative;">
                <!-- 전체 감싸는 div 영역 -->
                <div id="postingForm">
                    <h4>새 피드 작성</h4>
                    <hr>
                    <form action="pInsert.do" method="post" enctype="multipart/form-data">
                    	<input type="hidden" name="fWriter" value="${ loginUser.userId }">
						<input type="hidden" name="mNo" value="${ loginUser.mNo }">
                        <table id="tbb">
                            <!--글 쓰는 영역-->
                            <tr>
                                <td>
                                    <textarea cols="60" rows="7" name="fContent"></textarea>
                                </td>    
                            </tr>
                            <!-- 파일 첨부 영역 + 버튼 누르면 최대 5개까지 첨부파일 넣을 수 있게 해야함 ** 수정 할것-->
                            <tr>
                                <td>
                                    <img id="fileIcon" src="${ contextPath }/resources/icons/add_file.png">
                                </td>
                                <td class="filetb">
                                    <input type="file" id="input_file" name="uploadFile">
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
                                    <select id="myGroupList">
										<c:choose>
											<c:when test="${ gNo ne null }">
												<option>${ gName }</option>
											</c:when>
											<c:otherwise>
                                        		<option>가입된 그룹이 없습니다.</option>
											</c:otherwise>
										</c:choose>
                                    </select>
                                </td>
                            </tr>
                            
                            <!--공개여부 설정-->
                            <tr height="50px">
                                <td class="checkList tdfi">공개여부</td>
                                <td class="tdfi">
                                    <select>
                                        <option id="public" name="public">전체공개</option>
                                        <option id="friends" name="friends">친구만</option>
                                        <option id="private" name="private">비공개</option>
                                    </select>
                                </td>
                            </tr>
                            <!--그 외 설정들 라디오 버튼의 value 값 정해지면 수정해야함-->
                            <tr height="35px">
                                <td class="checkList">설정</td>
                                <td class="st">좋아요</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="like" id="" value="Y(임시)" checked ><label for="like">허용</label></li>                                </li>
                                        <li><input type="radio" name="like" id="" value="N(임시)" ><label for="like">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr height="35px">
                                <td class="checkListse st">댓글</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="reply" id="" value="Y(임시)" checked ><label for="reply">허용</label></li>
                                        <li><input type="radio" name="reply" id="" value="F(임시)" ><label for="reply">친구만 허용</label></li>                                        </li>
                                        <li><input type="radio" name="reply" id="" value="N(임시)" ><label for="reply">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr height="35px">
                                <td class="checkListse st">공유</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="share" id="" value="Y(임시)" checked ><label for="share">허용</label></li>                                        </li>
                                        <li><input type="radio" name="share" id="" value="N(임시)" ><label for="share">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td id="btnstd">
                                    <button id="btns1">
                                        <a id="page_back" href="javascript:history.go(-1);">이전</a>
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


            /************  팝업 메뉴 script *********** */

            $('#feed_menu').on("click",function(){
                $('.pop_menu').show();
            });

            $('#close').on('click',function(){
                $('.pop_menu').hide();
            });

            $('#feed_report_btn').on("click",function(){
                $('.feed_report').show();
            });

            $('#cancel').on("click",function(){
                $('.feed_report').hide();
            });

            $('#updateBtn').on("click",function(){
                $('.reply_menu').show();
            });

            $('#re_close').on("click",function(){
                $('.reply_menu').hide();
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


    </script>
</body>
</html>