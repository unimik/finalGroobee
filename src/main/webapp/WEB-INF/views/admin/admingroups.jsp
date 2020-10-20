<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>adminPage3</title>
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
                        <p>현재 GROOBEE 그룹 수는 <b>831</b>개입니다.</p>
                    </div>
                    <div id="search">
                        <form>
                            <label>그 룹 명</label><input type="text" id="name" name="name">
                            <label>관 심 사</label><select id="category">
                                <option>전체</option>
                                <option>문학/책</option>
                                <option>영화</option>
                                <option>미술/디자인</option>
                                <option>공연/전시</option>
                                <option>외국어</option>
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
                            <label>채팅여부</label><select id="chat">
                                <option>전체</option>
                                <option>N</option>
                                <option>Y</option>
                            </select>
                            <label>생 성 일</label><input type="date" id="enrolldate" name="enrolldate"><br>
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                            <input type="reset" id="resetBtn" name="resetBtn" value="초기화">
                        </form>
                    </div>
                </div>
            </div>
            <div id="containar">
                <table cellspacing="0" id="group_table">
                    <thead>
                        <tr>
                            <td>번호</td>
                            <td>그룹명</td>
                            <td>관심사</td>
                            <td>인원</td>
                            <td>생성일</td>
                            <td>채팅방</td>
                            <td>삭제</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="group_info">
                            <td>1</td>
                            <td>나만없어고양이</td>
                            <td>반려동물</td>
                            <td>999</td>
                            <td>2020-10-07</td>
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