<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kh.spring.member.model.vo.Member"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	 <div id="header">
            <img src="resources/icons/logo.png" alt="logo" id="logo" name="logo">
     </div>
     <div class="content">
     <div class="search_userInfo">
           <div id="searchbar">
           	   <form action="search.do" method="post">
	               <input type="search" id="allSearch" name="allSearch">
	               <input type="submit" id="allSearchBtn" name="allSearchBtn" value="검색">
           	</form>
    	 </div>
           <div id="userInfo">
               <ul>
                   <!--<li id="goMypage"><a href="goMypage.do?mNo=${ loginUser.mNo }"><img src="resources/images/IMG_7502.JPG" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;<p>user01</p></a></li>-->
                   <li id="goMypage">
                   		<c:if test="${ !empty loginUser.mImage }">
                   		</c:if>
                   		<c:if test="${ empty loginUser.mImage }">
                   		<img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                   		</c:if>
                   		<p>${ loginUser.userId }</p>
                   </li>
                   <li><a href="/views/PostInsertForm.html"><img src="resources/icons/write.png" alt="" id="writeIcon"></a></li>
                   <li><img src="resources/icons/alarm.png" alt="" id="alarmIcon"></li>
                   <li><img src="resources/icons/open.png" alt="" id="detailInfo"></li>
               </ul>
           </div>
     </div>
     <div id="menubar">
     	 <c:url var="goHome" value="home.do"/>
     	 <c:url var="glist" value="glist.do"/>
         <ul id="menu">
             <li><a href="${ goHome }"><img src="resources/icons/menu_home.png" alt="HOME"></a></li>
             <li><img src="resources/icons/menu_chat.png" alt="CHAT" id="chat_icon" name="chat_icon"></li>

             <li><a href="${ glist }"><img src="resources/icons/logoicon.png"></a></li>
             <li><a href="goSetting.do" ><img src="resources/icons/menu_set.png" alt="SET"></a></li>
         </ul>
     </div>
</body>
</html>