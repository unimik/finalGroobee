<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_Edit.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myAccount.css">
</head>
<body>
	 <div class="wrapper">
        <div id="header">
            <img src="<%=request.getContextPath()%>/resources/icons/logo.png" alt="logo" id="logo" name="logo">
        </div>
        <div class="content">
            <div class="search_userInfo">
                <div id="searchbar">
                    <input type="search" id="allSearch" name="allSearch">
                    <input type="button" id="allSearchBtn" name="allSearchBtn" value="검색">
                </div>
                <div id="userInfo">
                    <ul>
                        <li><a href="../views/myPage_Main.html"><img src="../resources/images/IMG_7502.JPG" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;<p>user01</p></a></li>
                        <li><img src="<%=request.getContextPath()%>/resources/icons/write.png" alt="" id="writeIcon"></li>
                        <li><img src="<%=request.getContextPath()%>/resources/icons/alarm.png" alt="" id="alarmIcon"></li>
                        <li><img src="<%=request.getContextPath()%>/resources/icons/open.png" alt="" id="detailInfo"></li>
                    </ul>
                </div>
                <div class="myAccount">
                    <div id="myId">
                        <a href="../views/myPage_Main.html">
                        <img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="myProfile" id="myProfile">
                        <p>user01</p>
                        </a>
                    </div>
                    <div id="MyTab">
                        <button class="MyTab_tab1 MyTab_tab on">친구</button>
                        <button class="MyTab_tab2 MyTab_tab">그룹</button>
                        <div id="MyTab_container">
                            <div class="MyTab_box1 MyTab_box on">
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user02</li>
                                        <li><button id="following" name="following">팔로잉</button></li>
                                    </ul>
                                </div>
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="../resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user03</li>
                                        <li><button id="following" name="following">팔로잉</button></li>
                                    </ul>
                                </div>
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="../resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user04</li>
                                        <li><button id="following" name="following">팔로잉</button></li>
                                    </ul>
                                </div>
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="../resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user05</li>
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
            
    <!-- 프로필 편집 부분 -->
        <div id="editArea">
            <div id="edit">
                <div id="edit_head">
                    <h2>프로필 편집</h2>
                </div>
                
                <div id="edit_body">
                    <div id="myProfileImg">
                        <img src="<%=request.getContextPath()%>/resources/images/mp_profile_sample.jpg">
                        <div class="change_myImg">
                            <p>USER01</p>
                            <a href="#" id="imgScript">프로필 사진 바꾸기</a>
                        </div>
                    </div>
                    <div id="info_edit">
                        <div class="info_name">
                            <p>이름</p>
                            <input type="text" id="name" name="name">
                        </div>
                        <div class="info_selfIntro">
                            <p>소개</p>
                            <textarea id="selfIntro" cols="35" rows="6"></textarea>
                        </div>
                        <div class="info_email">
                            <p>이메일</p>
                            <input type="text" id="email1" name="email1">
                            <input type="text" id="email2" name="email2">
                            <select name="select_email" id="select_email">
                                <option value="직접입력">직접입력</option>
                                <option value="직접입력">@naver.com</option>
                                <option value="직접입력">@daum.net</option>
                                <option value="직접입력">@gmail.com</option>
                            </select>
                        </div>
                        <div class="info_phone">
                            <p>전화번호</p>
                            <select name="select_number" id="select_number">
                                <option value="직접입력">직접입력</option>
                                <option value="직접입력">010</option>
                                <option value="직접입력">011</option>
                                <option value="직접입력">019</option>
                            </select>
                            <input type="text" id="phone2" class="phone" name="phone">
                            <input type="text" id="phone3" class="phone" name="phone">
                        </div>
                        <div class="info_interests">
                            <p>관심사</p>
                            <input type="checkbox" id="interests_literature" class="interests" name="interests">
                            <label for="interests_literature">문학·책</label>
                            <input type="checkbox" id="interests_movie" class="interests" name="interests">
                            <label for="interests_movie">영화</label>
                            <input type="checkbox" id="interests_artDesign" class="interests" name="interests">
                            <label for="interests_artDesign">미술·디자인</label>
                            <input type="checkbox" id="interests_perform" class="interests" name="interests">
                            <label for="interests_perform">공연·전시</label>
                        </div>
                        <div class="info_interests">
                            <input type="checkbox" id="interests_music" class="interests" name="interests">
                            <label for="interests_music">음악</label>
                            <input type="checkbox" id="interests_entertainment" class="interests" name="interests">
                            <label for="interests_entertainment">엔터테인먼트</label>
                            <input type="checkbox" id="interests_pets" class="interests" name="interests">
                            <label for="interests_pets">반려동물</label>
                            <input type="checkbox" id="interests_travel" class="interests" name="interests">
                            <label for="interests_travel">여행</label>
                        </div>
                        <div class="info_interests">
                            <input type="checkbox" id="interests_language" class="interests" name="interests">
                            <label for="interests_language">외국어</label>
                            <input type="checkbox" id="interests_famousRestaurant" class="interests" name="interests">
                            <label for="interests_famousRestaurant">맛집</label>
                            <input type="checkbox" id="interests_cooking" class="interests" name="interests">
                            <label for="interests_cooking">요리·레시피</label>
                            <input type="checkbox" id="interests_DIY" class="interests" name="interests">
                            <label for="interests_DIY">인테리어·DIY</label>
                        </div>
                        <div class="info_interests">
                            <input type="checkbox" id="interests_marriage" class="interests" name="interests">
                            <label for="interests_marriage">육아·결혼</label>
                            <input type="checkbox" id="interests_sports" class="interests" name="interests">
                            <label for="interests_sports">스포츠</label>
                            <input type="checkbox" id="interests_local" class="interests" name="interests">
                            <label for="interests_local">지역</label>
                        </div>
                    </div>
                </div>
            <!-- 버튼 만들기 -->
                <div id="edit_body2">
                    <div id="editBtnArea">
                        <input type="submit" id="edit_submitBtn" class="completeBtn" value="변경하기">
                        <input type="button" id="edit_cancleBtn" class="completeBtn" value="취소" onclick="goBack()">
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

        /* 게시글, 보관함, 내 그룹 전환 시 스크립트 */
        $('.feedPost_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
        });

        $('.feedStorageBox_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
        });

        $('.feedMyGroup_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
        });

        $('div[type = button]').css({'cursor' : 'pointer'});
        $('input[type = button]').css({'cursor' : 'pointer'});
        $('input[type = submit]').css({'cursor' : 'pointer'});
        $('img[type = button]').css({'cursor' : 'pointer'});

        function goBack() {
            window.history.back();
        }

    </script>
</body>
</html>