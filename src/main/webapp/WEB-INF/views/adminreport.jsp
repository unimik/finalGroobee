<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>adminPage4</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="resources/css/admincommon.css">
    <link rel="stylesheet" href="resources/css/admin4.css">
    <link rel="stylesheet" href="resources/css/alarmPop.css">
</head>
<body>
    <div class="wapper">
        <div id="header">
            <img src="resources/icons/logo.png" alt="logo" id="logo" name="logo">
        </div>
        <div class="content">
            <div class="adminInfo">
                <div id="adminInfo">
                    <ul>
                        <li><img src="resources/images/IMG_7502.JPG" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;<p>admin</p></li>
                        <li><img src="resources/icons/write.png" alt="" id="writeIcon"></li>
                        <li><img src="resources/icons/alarm.png" alt="" id="alarmIcon"></li>
                    </ul>
                </div>
            </div>
            <div class="alarm_pop">
                <div class="alarm_enquiry">
                    <div id="btnArea">
                        <button class="alarmBtn alarm_menubtn on">알람</button>
                        <button class="enquiryBtn alarm_menubtn">문의</button>
                        <button class="close_pop">X</button>
                    </div>
                    <div class="alarm_containar">
                        <div class="alarmCon conBox on">
                            <ul id="alarmList">
                                <li><b>[ 회원신고 ]</b> 가 들어왔습니다.</li>
                                <li><b>[ 게시글신고 ]</b> 가 들어왔습니다.</li>
                                <li><b>[ 댓글신고 ]</b> 가 들어왔습니다.</li>
                            </ul>
                        </div>
                        <div class="enquiryCon conBox">
                            <div id="enquiryList">
                                <div id="enquiryBox">
                                    <p id="id">user01</p>
                                    <p>채팅내용 복구해주세요</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user02</p>
                                    <p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데 광고라고 신고를 하죠???????</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user01</p>
                                    <p>채팅내용 복구해주세요</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user02</p>
                                    <p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데 광고라고 신고를 하죠???????</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user01</p>
                                    <p>채팅내용 복구해주세요</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user02</p>
                                    <p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데 광고라고 신고를 하죠???????</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user01</p>
                                    <p>채팅내용 복구해주세요</p>
                                </div>
                                <div id="enquiryBox">
                                    <p id="id">user02</p>
                                    <p>차단한 사람 그냥 아예 차단리스트에도 안보이게 하는 기능은 없나요? 그리고 왜 제 계정 홍보하는건데 광고라고 신고를 하죠???????</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="admin_common">
                <c:import url="common/sidebar.jsp"/>
                <p id="title">GROOBEE 회원관리</p>
                <div id="searchBox">
                    <div id="new_report">
                        <p>보류 중인 신고 수는 <b>21</b>개입니다.</p>
                    </div>
                    <div id="search">
                        <form>
                            <label>처리상태</label><select id="state">
                                <option>전체</option>
                                <option>보류</option>
                                <option>완료</option>
                            </select>
                            <label>구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</label><select id="category">
                                <option>전체</option>
                                <option>회원</option>
                                <option>게시글</option>
                                <option>댓글</option>
                                <option>그룹</option>
                            </select><br><br>
                            <label>신고사유</label><select id="report_category">
                                <option>전체</option>
                                <option>부적절한내용</option>
                                <option>욕설</option>
                                <option>광고</option>
                                <option>도배</option>
                            </select>
                            <label>신고일자</label><input type="date" id="enrolldate" name="enrolldate"><br>
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                            <input type="reset" id="resetBtn" name="resetBtn" value="초기화">
                        </form>
                    </div>
                </div>
            </div>
            <div id="containar">
                <table cellspacing="0" id="report_table">
                    <thead>
                        <tr>
                            <td>번호</td>
                            <td>구분</td>
                            <td>신고사유</td>
                            <td>내용</td>
                            <td>신고일</td>
                            <td>처리상태</td>
                            <td>삭제</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="report_info">
                            <td>1</td>
                            <td>회원[user01]</td>
                            <td>욕설</td>
                            <td><nobr>이 착하지만 모자란 친구야</nobr></td>
                            <td>2020-10-07</td>
                            <td>보류</td>
                            <td><button id="report_delete">탈퇴</button></td>
                        </tr>
                        <tr id="report_info">
                            <td>2</td>
                            <td>그룹[물건사세요]</td>
                            <td>광고</td>
                            <td><nobr>오늘만 팔아요</nobr></td>
                            <td>2020-10-07</td>
                            <td>완료</td>
                            <td><button id="report_delete">삭제</button></td>
                        </tr>
                        <tr id="report_info">
                            <td>3</td>
                            <td>게시글[3]</td>
                            <td>부적절한내용</td>
                            <td><nobr>@!~스포츠~!%$$</nobr></td>
                            <td>2020-10-07</td>
                            <td>완료</td>
                            <td><button id="report_delete">삭제</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function(){
        
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
    </script>

</body>
</html>