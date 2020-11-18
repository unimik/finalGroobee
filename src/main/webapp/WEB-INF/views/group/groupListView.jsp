<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
	<link href="<%=request.getContextPath()%>/resources/css/groupMain.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<c:import url="../common/menubar.jsp"/>
		<input type="button" id="create_group" name="create_group" value="그룹생성">
		<div class="gListopen">
                <ul>
                    <li>All Group List</li>
                    <li><a id="showList">보기</a></li>
                </ul>
        </div>
		<c:if test="${ !empty glist }">
		<div id="groupAllList">
	       <c:forEach var="g" items="${ glist }">
	       <c:url var="gdetail" value="gdetail.do">
				<c:param name="gNo" value="${ g.gNo }"/>
		   </c:url>
	       <div id="groupBox">
	       <a href="${ gdetail }">
	       	   <c:if test="${ !empty g.gImage }">
	       	   		<img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameImage }" id="groupBack">
	       	   </c:if>
	       	   <c:if test="${ empty g.gImage }">
	           		<img src="<%=request.getContextPath()%>/resources/images/g_back.png" id="groupBack">
	           </c:if>
	           <c:if test="${ !empty g.gProfile }">
	           		<img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameProfile }" id="groupProfile">
	           </c:if>
	           <c:if test="${ empty g.gProfile }">
	           		<img src="<%=request.getContextPath()%>/resources/icons/g_pro.png" id="groupProfile">
	           </c:if>
	           <p id="groupName">${ g.gName }</p>
	           <p id="gcategoryName">${ g.gCategory }</p>
	       </a>
	       </div>
	       </c:forEach>
		</div>
		</c:if>
		
		
	<div id="feedArea">
		<c:forEach var="f" items="${ flist }" varStatus="status">
			<c:set var="i" value="${ i + 1 }"/>
			<div id="feed${ i }" class="feed">
				<div id="writer_submenu">
					<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
					<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
						<div id="user_time">
							<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
						<h6><c:out value="${ f.fCreateDate }" /></h6>
						<c:url var="godetail" value="gdetail.do">
						<c:param name="gNo" value="${ f.gNo }"/>
						</c:url>
						<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
						</div>
					</a>
				<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
					<div class="feed_report">
					             <div id="feed_report_con">
					                  <p>신고사유</p>
					                  <select id="reportType" class="selectRtype">
					                      <option value="unacceptfeed" selected>부적절한 게시글</option>
					                      <option value="insult">욕설</option>
					                      <option value="ad">광고</option>
					                      <option value="spam">도배</option>
					                  </select>
					                  	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
					                  <br>
					                  <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
									  <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
									  <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
									  <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
					       		</div>
					</div>
					<c:choose>
						<c:when test="${ loginUser.userId ne f.fWriter }">
						<!-- 다른 회원 글 볼 때 피드메뉴 -->
						<div class="pop_menu" id="pop_menu${ i }">
						<input type="hidden" id="fn" name="fn" class="fn" value="${ f.fNo }">
						<div id="feed_menu_list">
						    	<ul>
						       	   <li><a href="${ godetail }">그룹보기</a></li>
						           <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
						           <li><a id="share_feed" class="share_feed">공유하기</a></li>
						           <li><a>보관함</a></li>
						           <li><a id="close" class="close">취소</a></li>
						        </ul>
						    </div>
						</div>
						</c:when>
						<c:otherwise>
						<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
						<div class="pop_Mymenu">
						    <div id="feed_Mymenu_list">
						        <ul>
							        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
									<li><a href="pDelete.do?fNo=${ f.fNo }">삭제</a></li> 
							        <li><a id="close" class="close">취소</a></li>
						        </ul>
						    </div>
						</div>
						</c:otherwise>
					</c:choose>
				</div>
				
	        <div id="con">
				<div id="feed_content">
						<c:if test="${ !empty f.photoList }">
							<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
							<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
							<c:forEach var="p" items="${ f.photoList }">
							<c:if test="${ p.changeName ne null }">
								<ul id="imgList">
									<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
								</ul>
							</c:if>
							</c:forEach>
						</c:if>
					<div id="heart_reply">
						<img src="${ contextPath }/resources/icons/heart.png" alt="" class="likeIcon" id="likeIcon">
						<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
						<input type="hidden" class="toNo" value="${f.fNo}">
						<input type="hidden" class="toId" value="${f.fWriter}">
					</div>
					<p id="text"><c:out value="${ f.fContent }" /></p>
	
				</div>
				<div id="replyArea">
					<div id="replyList" style="display: block; height: fit-content;">
					
					<c:set var="reply" value="${ f.replyList }"/>
					<c:if test="${ !empty r.rContent }">
						<div id="replySub" style="display: block; height: 150px; overflow: auto;">
					</c:if>
					<c:forEach var="r" items="${ f.replyList }">
						<c:if test="${ !empty r.rContent }">
		  				<ul id="re_list">
							<li><img src="${ contextPath }/resources/images/IMG_7502.JPG" alt=""
								id="reply_img">&nbsp;&nbsp;&nbsp;
								<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
							<li><p id="replyCon"><c:out value="${ r.rContent }" /></p></li>
							<li><p id="time"><c:out value="${ r.rCreateDate }" /></p></li>
							<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn"></li>
						</ul>
						</c:if>
					</c:forEach>
				<c:if test="${ !empty r.rContent }">
					</div>
				</c:if>
				</div>

				<!-- 남이 단 댓글 볼 때 댓글 메뉴-->
				<div class="reply_menu">
					<div id="re_menu_list">
						<ul>
							<li><a>댓글 수정</a></li>
							<li><a>댓글 삭제</a></li>
							<li><a id="re_close">취소</a></li>
						</ul>
					</div>
				</div>

				<div id="reply">
					<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
					<input type="text" id="textArea" class="rContent" name="textArea">
					<input type="button" id="replyBtn" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
				</div>
			</div>
		</div>
		</div>
	   </c:forEach>
	   
	<script>
			
		$('#create_group').click(function(){
			location.href="gInsertView.do";
		});
		
		$('#showList').on('click',function(){
	        if( $('#showList').text() == '보기'){
	            $('#groupAllList').show();
	            $('#showList').text('닫기');
	        }else{
	            $('#groupAllList').hide();
	            $('#showList').text('보기');
	        }
	    });
		
		$(document).ready(function(){
			
		
			var count = $(".feed").length;
		
			for(var i = 1; i <= count; i++){
				console.log('.feed_menu'+i);
				 $('.feed_menu'+i).on("click",function(){
			         $(this).nextAll('div .pop_menu').show();
			         $(this).nextAll('div .pop_Mymenu').show();
			     });
				 
				  $('.close').on("click",function(){
			         $('.pop_menu').hide();
			         $('.pop_Mymenu').hide();
			     });
				  
				  
				  
			 	$('.feed_report_btn').on("click",function(){
			 		 $('.feed_report').show();
	            });
				 
			 	
			}
			     
			$(document).on('click',".report-submit",function(){
				
				if($(".Rcontent").val() == ""){
					alert('신고 사유를 입력해 주세요.')
				}else{
					
					$.ajax({
						url:'/spring/report.do',
						data:{
							reportType : $("#reportType").val(),
							feedType : "feed",
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
	   	 
		   	$(".cancel2").on("click",function(){
		   		$(".feed_report").css('display','none');
					$(".selectRtype").css("display","inline-block");
		   		$(".sendreport").css("display","none");
		   	});
		   	
		   	$(".Rtype").on("click",function(){
		   		$(".selectRtype").css("display","none");
		   		$(".sendreport").css("display","block");
		   	});        
		   	
		   	$('.cancel').on("click", function(){
		 		$('.feed_report').hide();
		 	});
		});	
		var size;
        var idx = idx1 = 0;
        var count = $(".feed").children('div#con').children('div#feed_content').children("ul#imgList").length;
        var ul;
        console.log(count);
        var liCount;
        
		for (var i = 1; i <= count; i++){
			ul = $("#feed"+i).children('div#con').children('div#feed_content').children("ul#imgList").children("li").length;
			
			console.log(ul);
			
			if( ul > 1){
        		$('#nextBtn'+i).css("display","block");
        		$('#prevBtn'+i).css({"display":"block"});
        	}
			
			
			$('#prevBtn'+i).on("click",function(){
	  			size = $(this).nextAll().children('li').length;
	  			console.log(size);
	  			
	  			if(size > 1){
	  				idx1 = (idx-1) % size;
	  				if(idx1 < 0)
	  					idx1 = size - 1;
	  					
	  					$(this).nextAll().children('li:hidden').css("left","-633px");
	  					$(this).nextAll().children('li:eq('+idx+')').animate({left:"+=633px"},500,function(){
	  						$(this).css("display","none").css("left","-633px");
	  					});
	  					$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"+=633px"},500);
	  					idx = idx1;
	  			}
	  		});
			
			$('#nextBtn'+i).on("click",function(){
	  			size = $(this).nextAll().children('li').length;
	  			console.log(size);
	  			
	  			if( size > 1){
	  				idx1 = (idx + 1) % size;
	  				$(this).nextAll().children('li:hidden').css("left","633px");
	  				$(this).nextAll().children('li:eq('+idx+')').animate({left:"-=633px"},500, function(){
	  					$(this).css("display","none").css("left","633px");
	  				});
	  				$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"-=633px"},500);
	  				idx = idx1;
	  			}
	  				
	  			
	  		});
			
			$(function() {
				
				// 댓글 등록
				$(".replyUpBtn").on("click", function(event) {
					var rContent = event.target.parentElement.children[1].value;
					var rfNo = event.target.parentElement.children[0].value;
					var rWriter = ${ loginUser.userId };
					
					$.ajax({
						url: "addReply.do",
						data: {
							rContent: rContent,
							rfNo: rfNo,
							rWriter: rWriter
						},
						type: "post",
						success: function(data) {	// 성공 시: success, 실패 시: fail
							if(data == "success") {
								$(rContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
								location.href="home.do?userId="+rWriter;
							}
						}, error: function() {
							console.log("전송 실패");
						}
					});
				});
			});
			
			
			
		}
		
		$(function(){
			
			
			$('.share_feed').on("click",function(){
				var fNo = $(this).parents().children('.fn').val();
				console.log(fNo);
				
				$.ajax({
					url:"shareFeed.do",
					data:{ fNo:fNo, mNo:${ loginUser.mNo} },
					type:"post",
					success:function(data){
						if( data == "success"){
							alert("게시글을 공유하였습니다.");
							$('.pop_menu').hide();
						}
					},error:function(){
						alert("공유 실패");
					}
				});
			});
		})
	</script>
</body>
</html>