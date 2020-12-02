<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/totalSearch.css">
    <link rel="stylesheet" href="resources/css/home.css">
    <link rel="stylesheet" href="resources/css/chat.css">
    <link rel="stylesheet" href="resources/css/myAccount.css">
    <style>
    .post{height: 200px;}
    .post p{margin: 25px; top: 17px; display: inline-block; height: 150px; overflow: hidden; font-size:small}
    #nouser{font-size:14px; padding:10px 30px;  color: #555555;}
    .sendreport { margin-top:0;}
    .usertag {color: #47c6a3;}
    .storagePop{position: fixed; display: none; width: 100%; height: 100%; left:0; top:0; z-index: 100; overflow: auto; background-color: rgba(0,0,0,0.4);};
    </style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	 <div id="searchArea">
	 <div><p>${ rStr }<br><p></div>
                <!--계정/그룹 검색 결과-->
                <div id="search_account">
                    <!--계정-->
                    <div id="user">
                        <div id="title_user">
                            <p id="title"><b>계정</b></p>
                        </div>
                        <div id="con_user" class="scr">
                        <c:choose>
	                        <c:when test="${empty mList}">
	         					<div id="nouser">계정이 존재하지 않습니다</div>
	         				</c:when>
	         				<c:otherwise>
	                        	<c:forEach var="m" items="${ mList }">
	                            <c:choose>
	                            <c:when test="${ empty m.mImage }">
		                            <div id="search_user" style=" cursor: pointer;" onclick="location.href='goUserpage.do?userId=${ m.userId }&mNo=${ loginUser.mNo }'">
		                                <img src="resources/icons/pro_default.png" alt="" id="user_profile_img">
		                                <p id="search_id">${ m.userId }</p>
		                                <input type="hidden" id="mNo" name="mNo" value="${m.mNo}"/>
		                                <input type="hidden" id="mStatus" name="mStatus" value="${m.mStatus}"/>
		                            </div>
	                            </c:when>
	                            <c:otherwise>
	                            <div id="search_user" style=" cursor: pointer;" onclick="location.href='goUserpage.do?userId=${ m.userId }&mNo=${ loginUser.mNo }'">
	                                <img src="resources/memberProfileFiles/${ m.mRenameImage }" alt="" id="user_profile_img">
	                                <p id="search_id">${ m.userId }</p>
	                            </div>                            
	                            </c:otherwise>
	                            </c:choose>                            
	                            </c:forEach>
	                         </c:otherwise>
                         </c:choose>   
                        </div>
                    </div>
                     <script type="text/javascript">
                     function ClickUser(obj) {
                     	console.log("눌렀다")
	
						}
                     </script>
                    <!--그룹-->
                    <div id="group">
                        <div id="title_group">
                            <p id="title"><b>그룹</b> </p>
                        </div>
                        <div id="con_group">
                        <c:choose>
	                        <c:when test="${empty gList}">
	         					<div id="nouser">그룹이 존재하지 않습니다</div>
	         				</c:when>
	         				<c:otherwise>
	                        	<c:forEach var="g" items="${ gList }">
		                            <div id="search_group" style=" cursor: pointer;" onclick="location.href='gdetail.do?gNo=${ g.gNo }';">
		                                <c:if test="${ !empty g.gRenameProfile  }">
		                                <img src="resources/gUploadFiles/${g.gRenameProfile}" alt="" id="group_profile_img">
		                                </c:if>
		                                <c:if test="${ empty g.gRenameProfile  }">
		                                <img src="resources/icons/g_pro.png" alt="" id="group_profile_img">
		                                </c:if>
		                                <p id="search_id_group">${ g.gName} </p>
		                            </div>                      
		                       </c:forEach>
	                       </c:otherwise>                        
                       </c:choose>
                        </div>
                    </div>
                </div>

                <!--연관 태그-->
                <div id="search_tag">
                    <div id="title_tag">
                        <p id="title"><b>연관 태그</b> </p>
                    </div>
                    <div id="con_tag">
                        <ul id="tag">
                        <c:choose>
	                        <c:when test="${empty rsList}">
	         					<li style="">연관검색어가 존재하지 않습니다</li>
             				</c:when>
	         				<c:otherwise>
	                        	<c:forEach var="rs" items="${ rsList }">
		                            <li style=" cursor: pointer;"><a href="tagSearch.do?search=${searchKey}+${rs}+&mNo=${ loginUser.mNo }">#${rs}</a></li>
		                       </c:forEach>
	                       </c:otherwise>                        
                        </c:choose>
                        </ul>
                    </div>
                </div>
                <!--검색된 피드-->
                <div id="search_feed">
                    <div id="title_feed">
                        <p id="title"><b>게시물</b> </p>
                    </div>
                    <div id="con_feed">
                    <c:choose>
	                    <c:when test="${empty fList}">
		       				<div id="nouser">게시글이 존재하지 않습니다</div>	                    	
	       				</c:when>
	       				<c:otherwise>
	                    	<c:forEach var="f" items="${ fList }">
	                    	<c:choose>
	                   			<c:when test="${ empty f.thumbnail }">
		                   			<div class="post" id="${ f.fNo }" onclick="goDetail(${ f.fNo },${ f.mNo })" style=" cursor: pointer;">
			                             <p>${f.fContent} </p>
			                        </div>
	                   			</c:when>
	                   			<c:otherwise>
		                   			<div class="post" id="${ f.fNo }" onclick="goDetail(${ f.fNo },${ f.mNo })">
			                            <img src="resources/pUploadFiles/${f.thumbnail}" alt="" id="post_con">                                 	
			                        </div>
	                   			</c:otherwise>
	                   		</c:choose>							                 		
	                   		</c:forEach>
		                </c:otherwise>
					</c:choose>
                    </div>
                </div>
                
                <!-- 포스트박스 클릭 시 -->
                <div class=pop_feed>
                </div>
            </div>
		
	<script>
	
	/*게시글 팝업*/
	  function goDetail(fNo,smNo){
		console.log($(this).attr("id") );
		var mNo = '${loginUser.mNo}';
	
        $.ajax({
            url:"goDetail.do",
            dataType:"json",
            data:{mNo: mNo,fNo :fNo,smNo : smNo},
            type:"post",
            success:function(data){
              
          	  var input=""; 
                input += "<div class='feed_delete'>";
                input += "<img src='/spring/resources/icons/close_white.png' type='button'>";
                input += "</div>";
                input += "<div id='writer_submenu2'>";
                if(data.mImage != null){
                  input += "<img src='/spring/resources/memberProfileFiles/"+data.mImage+"' alt='' id='feed_profile_img'>";
                } else {
                  input += "<img src='/spring/resources/icons/pro_default.png' alt='' id='feed_profile_img'>";
                }
	              input += "<div id='user_time2'>";
	              input += "<p id='feed_id'>"+data.fWriter+"</p>";
	              input += "<h6>"+data.fCreateDate+"</h6>";
	              input += "</div>";
	              input += "<img src='/spring/resources/icons/feed_menu.png' alt='' id='feed_menu' class='test'>";
	              input += "</div>";
	              input +="<div class='pop_menu'>";
	              <!-- 내가 쓴 글 볼 때 피드 메뉴 -->
	              if(smNo == mNo){
		              input +="<div id='feed_Mymenu_list'>";
		              input +="<ul>";
		              input +="<li><a href='pUpdateView.do?fNo="+fNo+"&like="+data.fLikeSet+"&share="+data.fShareSet+"&reply="+data.fReplySet+"' id='feed_menu1_btn'>수정</a></li>";
		              input +="<li><a href='pDelete.do?fNo="+fNo+"' class='deleteMyPost'>삭제</a></li>";
		              input +="<li><a id='close' class='close'>취소</a></li>";
		              input +="</ul>";
		              input +="</div>";
	              } else {
		              input +="<div id='popfeed_menu_list'>";
		              input +="<ul>";
		              input +="<li><a id='feed_report_btn_class' class='feed_report_btn_class'>신고</a></li>"; 
		              input +="<li><a id='share_feed' class='share_feed'>공유하기</a></li>"; 
		              input +="<li><a id='goStorage' class='goStorage'>보관함</a></li>";
		              input +="<li><a id='close' class='close'>취소</a></li>";
		              input +="</ul>";
		              input +="</div>";
	              }
				  input +="</div>";
	              input +="<div class='storagePop'>";
	          	  input +="</div>";
	          	  input +="<div class='feed_report'>";
	    		  input +="<input type='hidden' value='"+fNo+"'>";
	    		  input +="<div id='feed_report_con'>";
	    		  input +="<p>신고사유</p>";
		    	  input +="<select id='reportType' class='selectRtype'>";
		    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
		    	  input +="<option value='insult'>욕설</option>";
		    	  input +="<option value='ad'>광고</option>";
		    	  input +="<option value='spam'>도배</option>";
		    	  input +="</select>";
		    	  input +="<textarea class='sendreport Rcontent' id='reportContent' cols='28' rows='4'></textarea>";
		    	  input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
	    		  input +="<input class='sendreport report-submit_class' type='button' id='report-submit_class' value='확인' style='cursor: pointer; display: none;'>";
	    		  input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
	    		  input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
	    		  input +="</div>";
	    		  input +="</div>";
	              input +="<div id='con2'>";
	              input +="<div id='feed_content'>";
	        	  	if(data.photoList.length > 0 ){
		      	  	input +="<button id='nextBtn${ i }' name='nextBtn' class='imgbtn nextBtn'><img src='/spring/resources/icons/nextbtn.png'></button>";
					input +="<button id='prevBtn${ i }' name='prevBtn' class='imgbtn prevBtn'><img src='/spring/resources/icons/prevbtn.png'></button>";
	            	input +="<ul id='imgList' style='height:633px'>";
		              for(var i=0; i < data.photoList.length; i++){
						  if(data.photoList[i].changeName != null){
							  input +="<li><img src='/spring/resources/pUploadFiles/"+data.photoList[i].changeName+"' alt='' id='input_img'></li>";
			              }
		              } 
		              input +="</ul>";
	        	  }
	              input +="<p id='text'>"+data.fcontent+"</p>";
		              input +="<div id='heart_reply'>";
					  <!-- 좋아요 금지가 되어 있지 않을 경우 -->
	 				  if(data.fLikeSet == 'Y' ||  data.fLikeSet == null){
						<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
		             	if(data.likeChk == null){
			             	input +="<img src='/spring/resources/icons/heart.png' alt='' name='"+fNo+"'class='likeIcon' id='likeIcon' onclick='likeClick(this);'>";
			             	input +="<label class='likeCnt' id='"+fNo+"'>"+data.fLikeCnt+"개</label>";
		             	} else {
			             	input +="<img src='/spring/resources/icons/heart_red.png' alt='' name='"+fNo+"' class='liked' id='liked' onclick='likeClick(this);'>";	             	
			             	input +="<label class='likeCnt' id='"+fNo+"'>"+data.fLikeCnt+"개</label>";
		             	}
					  }
	 				 input +="<input type='hidden'  class='fLikeCnt' value='"+data.fLikeCnt+"'>";
					  input +="<input type='hidden' class='toNo' value='"+fNo+"'>";
					  input +="<input type='hidden' class='toId' value='"+data.fWriter+"'>";
	              	  	<!-- 댓글이 전체 허용일 경우 -->
					  if(data.fReplySet == 'Y' || data.fReplySet == null){
					  	 if(data.fLikeSet == 'N'){
					  	 <!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
					  	 input +="<img src='/spring/resources/icons/bubble.png' alt='' id='replyIcon' style='margin: 9px 0 0 25px;'>";
					  	 	if(data.replyListSize > 0){
					  	 	 if(data.replyList[0].rStatus == 'Y'){
					  	 	 input +="<label class='replycnt_p'>"+data.replyListSize+"개</label>";
					  	 	 }
					  	 	 else if(data.replyList[0].rStatus == 'N' || data.replyList[0].rStatus == null){
					  	 	 input +="<label class='replycnt_p'>0개</label>";
					  	 	 }
					  	 	} else {
					  	 	 input +="<label class='replycnt_p'>0개</label>";
					  	 	}
					  	 } else {
					  	 <!-- 댓글과 좋아요 모두 허용될 때 -->
					  	 input +="<img src='/spring/resources/icons/bubble.png' alt='' id='replyIcon'>";
					  		if(data.replyListSize > 0){
					  	 	 if(data.replyList[0].rStatus == 'Y'){
					  	 	 input +="<label class='replycnt_p'>"+data.replyListSize+"개</label>";
					  	 	 }
					  	 	 else if(data.replyList[0].rStatus == 'N' || data.replyList[0].rStatus == null){
					  	 	 input +="<label class='replycnt_p'>0개</label>";
					  	 	 }
					  		} else {
						  	 	 input +="<label class='replycnt_p'>0개</label>";
						  	 	}
					  	 }
					  }
					  if(data.fReplySet == 'N' && data.fLikeSet == 'N'){
					  input +="<label class='setN'>댓글과 좋아요가 금지된 포스트입니다.</label>";
					  } 
		              input +="</div>";
		              input +="</div>";
	                  input +="<div id='replyArea'>";
		              input +="<div id='replyEditCont'>";
	                  if(data.replyList.length > 0){
		              input +="<div id='replySub'>";
		              for(var i=0;i<data.replyList.length;i++){
			              input +="<div id='selectOne'>";	
			              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
		                  input +="<div id='replyList'>";
		                  input +="<ul id='re_list' class='list'>";
		                  if(data.replyList[i].mNo == mNo){
				  			  if(data.replyList[i].rWriterImg != null){
				  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
				  			  }else{
				  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
				  			  }
		                  } else {
		                	  if(data.replyList[i].rWriterImg != null){
		                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		                	  }else{
		                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		                	  }
		                  }
		            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
			              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
			              input +="<li><img src='/spring/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
			              if(data.replyList[i].mNo == mNo){
							  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
			               }
						  input +="</ul>";
			              input +="</div>";
			              input +="<div class='reply_menu'>";

			              if(data.replyList[i].mNo == mNo){
				              input +="<div id='re_menu_list'>";
				              input +="<ul>";
				              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
				              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
				              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
				              input +="</ul>";
				          	  input +="</div>";
			              } else{
				              input +="<div id='user_menu_list'>";
				              input +="<ul>";
			            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
			            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
				              input +="</ul>";
				          	  input +="</div>";
				    		  <!-- 댓글을 신고해보자! -->
				    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
				    		  input +="<div id='reply_report_con'>";
					    	  input +="<p>신고사유</p>";
					    	  input +="<select id='reply_reportType' class='selectRtype'>";
					    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
						      input +="<option value='insult'>욕설</option>";
						      input +="<option value='ad'>광고</option>";
						      input +="<option value='spam'>도배</option>";
						      input +="</select>";   
						      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
						      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
						      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
						      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
						      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
						      input +="</div>";
						      input +="</div>";
			              }
	                  	  input +="</div>";
		                  input +="</div>";       
		              }
	                  input +="</div>";       
	                  }
	                  input +="</div>";  
	                  if(data.fReplySet == 'Y' || data.fReplySet == null){
		              input +="<div id='reply'>";
		              input +="<input type='hidden' class='replyFeedNo' name='replyFeedNo' value="+fNo+">";
		              input +="<input type='text' id='textArea' class='replyContent' name='textArea'>";
		              input +="<input type='button' id='replyBtn'  class='replyUpBtn' name='replyBtn' value='등록' onClick='applyReply("+fNo+");'>";
		              input +="</div>";
	                  }
		              input +="</div>";
	              input +="</div>";
                  
	                 $(".pop_feed").html(input);
	      	 		  $(".pop_feed").show();

	      	        $('.feed_delete').click(function() {
	      	            $(".pop_feed").hide();
	      	        });
	      	        
		      	      $('#feed_menu').click(function() {
		                  $('.pop_menu').show();
			          }); 
			      	
			          $('.close').on('click', function(){
			              $('.pop_menu').hide();
			          });
			          
	 		          $('.rUpBtn').on("click", function(e){
	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
			              $(replyMenu).show();
			          }); 
			          $('.rClose').on("click", function(){
			              $('.reply_menu').hide();
			          });
			          
			          $('.cancel').on("click", function(){
			              $('.feed_report').hide();
			          });
			          
			          $('.cancel').on("click", function(){
			              $('.reply_report').hide();
			          });
			          
			          
			        var size;
			        var idx = idx1 = 0;
			        var count = $(".pop_feed").children('div#con2').children('div#feed_content').children("ul#imgList").children('li').length;
			        console.log(count);
			        var liCount;
			          
			  		for (var i = 1; i <= count; i++){
			  			
			  			if( count > 1){
			          		$('#nextBtn').css("display","block");
			          		$('#prevBtn').css({"display":"block"});
			          	}
			  			
			  		}
			  			$(document).on("click",'#prevBtn',function(){
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
			  			
			  			$(document).on("click",'#nextBtn',function(){
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
			  			
			  		 	/* 댓글 신고하기*/
			  		 	// 1. 신고하기 버튼 이벤트
			  		 	$(document).on("click","#rReport",function(){
			  		 		$(".reply_report").css("display","block");
			  		 		// 2.리플 번호 불러오기
			  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
			  		 		
			  			 	// 3. 댓글 신고하기
			  			 	$(document).on("click",'.reply_submit',function(){
			  			 		var text =$(this).prev().prev().prev().val();
			  			 		
			  			 		console.log(text);
			  		 			console.log(targetrNo);
			  			 		console.log($("#reply_reportType").val());
			  			 		
			  			 		if(text == ""){
			  						alert('신고 사유를 입력해 주세요.')
			  					}else{
			  						
			  						$.ajax({
			  							url:'reportRInsert.do',
			  							data:{
			  								reportType : $("#reply_reportType").val(),
			  								replyType : "reply",
			  								content : text,
			  								targetrNo:targetrNo
			  							},
			  							success: function(){
			  								alert('신고 완료');
			  								$('.reply_menu').hide();
			  					      		$('.reply_report').hide();
			  							},error:function(){
			  								alert('신고 실패!');
			  							}
			  						});
			  						
			  					};	
			  			 	});
			  		 	});
			          
			          
			       	/***** 피드 신고하기 *****/
			       	
			               $('#feed_report_btn_class').on("click",function(){
						                $('.feed_report').show();
						            });
			      			     
			      		 $(document).on('click', ".report-submit_class", function(e){
			      			var feedReport = $(e.target).parents()[1];
			      			var reportCon = $(e.target).parents()[0].children[1];
			      			var targetfNo=$(e.target).parents()[1].children[0].value;
			      			
			      			var text =$(e.target).parents()[0].children[2].value;
			      			if(text == null){
			      				alert('신고 사유를 입력해 주세요.');
			      			}else{
			      				
			      				$.ajax({
			      					url:'reportFInsert.do',
			      					data:{
			      						reportType : $("#reportType").val(),
			      						feedType : "feed",
			      						content : text,
			      						targetfNo:targetfNo
			      					},
			      					success: function(){
			      						$(feedReport).css('display', 'none');
			      						$(".selectRtype").css("display", "inline-block");
			      			      		$(".sendreport").css("display", "none");
			      			      		$(reportCon).val('');
			      						alert('신고 완료');
			      						$('.feed_report').hide();
			      						$('.reply_menu').hide();
			      			      		refresh();
			      					},error:function(){
			      						alert('신고 실패!');
			      					}
			      				});
			      				
			      			};
			      		});
			         	 
			      	   	$(".cancel2").on("click",function(e){
			      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
			      	   		$(feedReport).css('display', 'none');
			      			$(".selectRtype").css("display", "inline-block");
			      	   		$(".sendreport").css("display", "none");
			      	   	});
			      	   	
			      	   	$(".Rtype").on("click",function(e){
			      	   		$(".selectRtype").css("display", "none");
			      	   		$(".sendreport").css("display", "block");
			      	   	});
			          
			          /* 댓글 수정시 텍스트창 변경 */
			          $('.rEdit').on("click", function(e) {
			      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
			      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
			      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

			      			repCon.css('border', '1px solid #555555');
			        	  	repCon.removeAttr('disabled');
			        	  	repCon.removeAttr('readonly');
			        	  	repBtn.css('display', 'block');
			        	  	rupBtn.css('display', 'none');
			        	 
			        	  	$('.reply_menu').hide();
			          });
			          
				      	/* 댓글 수정 시 완료 버튼 누르면 */
				       	$('.rConfirm').on("click", function(e) {
				      		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
				      		var rWriter = '${loginUser.userId}';
				      		var replyContent = $(this).parent().children()[1].children[0].value;
				      		
				      			$.ajax({
				      				url: "editReply.do",
				      				data: {
				      					rContent: replyContent,
				      					rNo: rNo,
				      					rWriter: rWriter,
				      					fNo : fNo
				      				},
				      				type: "post",
				      				async:false,
				      				success: function(data) {	// 성공 시: success, 실패 시: fail
				      					console.log(data);
				       				
//				      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
				       						//location.href="goMypage.do?mNo="+mNo;
				       						$('#replySub').remove();
				       						
				       						var input = "";
				       					 input +="<div id='replySub'>";
				       	              for(var i=0;i<data.replyList.length;i++){
				       		              input +="<div id='selectOne'>";	
				       		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
				       		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
				       	                  input +="<div id='replyList'>";
				       	                  input +="<ul id='re_list' class='list'>";
				       	               if(data.replyList[i].mNo == mNo){
				 			  			  if(data.replyList[i].rWriterImg != null){
				 			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
				 			  			  }else{
				 			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
				 			  			  }
				 	                  } else {
				 	                	  if(data.replyList[i].rWriterImg != null){
				 	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
				 	                	  }else{
				 	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
				 	                	  }
				 	                  }
				       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
				       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
				       		              input +="<li><img src='/spring/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
				       		              if(data.replyList[i].mNo == mNo){
				       						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
				       		               }
				       					  input +="</ul>";
				       		              input +="</div>";
				       		              input +="<div class='reply_menu'>";

				       		              if(data.replyList[i].mNo == mNo){
				       			              input +="<div id='re_menu_list'>";
				       			              input +="<ul>";
				       			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
				       			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
				       			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
				       			              input +="</ul>";
				       			          	  input +="</div>";
				       		              } else{
				    			              input +="<div id='user_menu_list'>";
				    			              input +="<ul>";
				    		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
				    		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
				    			              input +="</ul>";
				    			          	  input +="</div>";
				    			    		  <!-- 댓글을 신고해보자! -->
				    			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
				    			    		  input +="<div id='reply_report_con'>";
				    				    	  input +="<p>신고사유</p>";
				    				    	  input +="<select id='reply_reportType' class='selectRtype'>";
				    				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
				    					      input +="<option value='insult'>욕설</option>";
				    					      input +="<option value='ad'>광고</option>";
				    					      input +="<option value='spam'>도배</option>";
				    					      input +="</select>";   
				    					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
				    					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
				    					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
				    					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
				    					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
				    					      input +="</div>";
				    					      input +="</div>";
				       		              }
				                          input +="</div>";
				                          input +="</div>";
				       	              }
				       	                  input +="</div>"; 
				       	                  
				       	                  $('#replyEditCont').append(input);
				       	                  
				       	                  
				       	      	        $('.feed_delete').click(function() {
				       	      	            $(".pop_feed").hide();
				       	      	        });
				       	      	        
				       		      	      $('#feed_menu').click(function() {
				       		                  $('.pop_menu').show();
				       			          }); 
				       			      	
				       			          $('.close').on('click', function(){
				       			              $('.pop_menu').hide();
				       			          });
				       			          
				       	 		          $('.rUpBtn').on("click", function(e){
				       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
				       			              $(replyMenu).show();
				       			          }); 
				       			          $('.rClose').on("click", function(){
				       			              $('.reply_menu').hide();
				       			          });
				       			          
				       			          $('.cancel').on("click", function(){
				       			              $('.feed_report').hide();
				       			          });
				       			          
				       			          $('.cancel').on("click", function(){
				       			              $('.reply_report').hide();
				       			          });
				       			          
				       			  		// 댓글 삭제 시
				       			  		$('.rDelete').on("click", function(e) {
				       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
				       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
				       						var rWriter = '${loginUser.userId}';
				       						var none = $(this.parentElement).parents("div#replySub").children.length;
				       						
				       						$.ajax({
				       							url: "deleteReply.do",
				       							data: {rNo: rNo},
				       							type: "post",
				       							success: function(data) {	// 성공 시: success, 실패 시: fail
				       				  				if(data == "success") {
//				       									$(ul).css('display', 'none');
				       									$('.rNum').css('display', 'none');
				       									location.reload();
				       								}
				       							}, error: function() {
				       								console.log("전송 실패");
				       							}
				       						});
				       						
				       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
				       						if(none == 0) {
				       							$(this.parentElement).parents("div#replySub").css('display', 'none');
				       						}
				       						
				       						confirm("댓글을 삭제하시겠습니까?");
				       			  		});
				       			          
				       			          // text-area resize
				       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
				       			      		var offset = this.offsetHeight - this.clientHeight;
				       			      		var resizeTextarea = function(el) {
				       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
				       			      		};
				       			      		$(this).on('keyup input', function() {
				       			      		 resizeTextarea(this);
				       			      		}).removeAttr('data-autoresize');
				       			      	});
				       			          
				    		  		 	/* 댓글 신고하기*/
				    		  		 	// 1. 신고하기 버튼 이벤트
				    		  		 	$(document).on("click","#rReport",function(){
				    		  		 		$(".reply_report").css("display","block");
				    		  		 		// 2.리플 번호 불러오기
				    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
				    		  		 		
				    		  			 	// 3. 댓글 신고하기
				    		  			 	$(document).on("click",'.reply_submit',function(){
				    		  			 		var text =$(this).prev().prev().prev().val();
				    		  			 		
				    		  			 		console.log(text);
				    		  		 			console.log(targetrNo);
				    		  			 		console.log($("#reply_reportType").val());
				    		  			 		
				    		  			 		if(text == ""){
				    		  						alert('신고 사유를 입력해 주세요.')
				    		  					}else{
				    		  						
				    		  						$.ajax({
				    		  							url:'reportRInsert.do',
				    		  							data:{
				    		  								reportType : $("#reply_reportType").val(),
				    		  								replyType : "reply",
				    		  								content : text,
				    		  								targetrNo:targetrNo
				    		  							},
				    		  							success: function(){
				    		  								alert('신고 완료');
				    		  								$('.reply_menu').hide();
				    		  					      		$('.reply_report').hide();
				    		  							},error:function(){
				    		  								alert('신고 실패!');
				    		  							}
				    		  						});
				    		  						
				    		  					};	
				    		  			 	});
				    		  		 	});
				    		         	 
				    		      	   	$(".cancel2").on("click",function(e){
				    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
				    		      	   		$(feedReport).css('display', 'none');
				    		      			$(".selectRtype").css("display", "inline-block");
				    		      	   		$(".sendreport").css("display", "none");
				    		      	   	});
				    		      	   	
				    		      	   	$(".Rtype").on("click",function(e){
				    		      	   		$(".selectRtype").css("display", "none");
				    		      	   		$(".sendreport").css("display", "block");
				    		      	   	});
				    		          
				    		          /* 댓글 수정시 텍스트창 변경 */
				    		          $('.rEdit').on("click", function(e) {
				    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
				    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
				    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

				    		      			repCon.css('border', '1px solid #555555');
				    		        	  	repCon.removeAttr('disabled');
				    		        	  	repCon.removeAttr('readonly');
				    		        	  	repBtn.css('display', 'block');
				    		        	  	rupBtn.css('display', 'none');
				    		        	 
				    		        	  	$('.reply_menu').hide();
				    		          });
				    		          
				    			      	/* 두번째 댓글 수정 시 완료 버튼 누르면 */
								       	$('.rConfirm').on("click", function(e) {
								      		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
								      		var rWriter = '${loginUser.userId}';
								      		var replyContent = $(this).parent().children()[1].children[0].value;
								      		
								      			$.ajax({
								      				url: "editReply.do",
								      				data: {
								      					rContent: replyContent,
								      					rNo: rNo,
								      					rWriter: rWriter,
								      					fNo : fNo
								      				},
								      				type: "post",
								      				async:false,
								      				success: function(data) {	// 성공 시: success, 실패 시: fail
								      					console.log(data);
								       				
//								      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
								       						//location.href="goMypage.do?mNo="+mNo;
								       						$('#replySub').remove();
								       						
								       						var input = "";
								       					 input +="<div id='replySub'>";
								       	              for(var i=0;i<data.replyList.length;i++){
								       		              input +="<div id='selectOne'>";	
								       		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
								       		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
								       	                  input +="<div id='replyList'>";
								       	                  input +="<ul id='re_list' class='list'>";
								       	               if(data.replyList[i].mNo == mNo){
								 			  			  if(data.replyList[i].rWriterImg != null){
								 			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
								 			  			  }else{
								 			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
								 			  			  }
								 	                  } else {
								 	                	  if(data.replyList[i].rWriterImg != null){
								 	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
								 	                	  }else{
								 	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
								 	                	  }
								 	                  }
								       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
								       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
								       		              input +="<li><img src='/spring/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
								       		              if(data.replyList[i].mNo == mNo){
								       						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
								       		               }
								       					  input +="</ul>";
								       		              input +="</div>";
								       		              input +="<div class='reply_menu'>";

								       		              if(data.replyList[i].mNo == mNo){
								       			              input +="<div id='re_menu_list'>";
								       			              input +="<ul>";
								       			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
								       			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
								       			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
								       			              input +="</ul>";
								       			          	  input +="</div>";
								       		              } else{
								    			              input +="<div id='user_menu_list'>";
								    			              input +="<ul>";
								    		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
								    		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
								    			              input +="</ul>";
								    			          	  input +="</div>";
								    			    		  <!-- 댓글을 신고해보자! -->
								    			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
								    			    		  input +="<div id='reply_report_con'>";
								    				    	  input +="<p>신고사유</p>";
								    				    	  input +="<select id='reply_reportType' class='selectRtype'>";
								    				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
								    					      input +="<option value='insult'>욕설</option>";
								    					      input +="<option value='ad'>광고</option>";
								    					      input +="<option value='spam'>도배</option>";
								    					      input +="</select>";   
								    					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
								    					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
								    					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
								    					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
								    					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
								    					      input +="</div>";
								    					      input +="</div>";
								       		              }
								                          input +="</div>";
								                          input +="</div>";
								       	              }
								       	                  input +="</div>"; 
								       	                  
								       	                  $('#replyEditCont').append(input);
								       	                  
								       	                  
								       	      	        $('.feed_delete').click(function() {
								       	      	            $(".pop_feed").hide();
								       	      	        });
								       	      	        
								       		      	      $('#feed_menu').click(function() {
								       		                  $('.pop_menu').show();
								       			          }); 
								       			      	
								       			          $('.close').on('click', function(){
								       			              $('.pop_menu').hide();
								       			          });
								       			          
								       	 		          $('.rUpBtn').on("click", function(e){
								       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
								       			              $(replyMenu).show();
								       			          }); 
								       			          $('.rClose').on("click", function(){
								       			              $('.reply_menu').hide();
								       			          });
								       			          
								       			          $('.cancel').on("click", function(){
								       			              $('.feed_report').hide();
								       			          });
								       			          
								       			          $('.cancel').on("click", function(){
								       			              $('.reply_report').hide();
								       			          });
								       			          
								       			  		// 댓글 삭제 시
								       			  		$('.rDelete').on("click", function(e) {
								       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
								       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
								       						var rWriter = '${loginUser.userId}';
								       						var none = $(this.parentElement).parents("div#replySub").children.length;
								       						
								       						$.ajax({
								       							url: "deleteReply.do",
								       							data: {rNo: rNo},
								       							type: "post",
								       							success: function(data) {	// 성공 시: success, 실패 시: fail
								       				  				if(data == "success") {
//								       									$(ul).css('display', 'none');
								       									$('.rNum').css('display', 'none');
								       									location.reload();
								       								}
								       							}, error: function() {
								       								console.log("전송 실패");
								       							}
								       						});
								       						
								       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
								       						if(none == 0) {
								       							$(this.parentElement).parents("div#replySub").css('display', 'none');
								       						}
								       						
								       						confirm("댓글을 삭제하시겠습니까?");
								       			  		});
								       			          
								       			          // text-area resize
								       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
								       			      		var offset = this.offsetHeight - this.clientHeight;
								       			      		var resizeTextarea = function(el) {
								       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
								       			      		};
								       			      		$(this).on('keyup input', function() {
								       			      		 resizeTextarea(this);
								       			      		}).removeAttr('data-autoresize');
								       			      	});
								       			          
								    		  		 	/* 댓글 신고하기*/
								    		  		 	// 1. 신고하기 버튼 이벤트
								    		  		 	$(document).on("click","#rReport",function(){
								    		  		 		$(".reply_report").css("display","block");
								    		  		 		// 2.리플 번호 불러오기
								    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
								    		  		 		
								    		  			 	// 3. 댓글 신고하기
								    		  			 	$(document).on("click",'.reply_submit',function(){
								    		  			 		var text =$(this).prev().prev().prev().val();
								    		  			 		
								    		  			 		console.log(text);
								    		  		 			console.log(targetrNo);
								    		  			 		console.log($("#reply_reportType").val());
								    		  			 		
								    		  			 		if(text == ""){
								    		  						alert('신고 사유를 입력해 주세요.')
								    		  					}else{
								    		  						
								    		  						$.ajax({
								    		  							url:'reportRInsert.do',
								    		  							data:{
								    		  								reportType : $("#reply_reportType").val(),
								    		  								replyType : "reply",
								    		  								content : text,
								    		  								targetrNo:targetrNo
								    		  							},
								    		  							success: function(){
								    		  								alert('신고 완료');
								    		  								$('.reply_menu').hide();
								    		  					      		$('.reply_report').hide();
								    		  							},error:function(){
								    		  								alert('신고 실패!');
								    		  							}
								    		  						});
								    		  						
								    		  					};	
								    		  			 	});
								    		  		 	});
								    		         	 
								    		      	   	$(".cancel2").on("click",function(e){
								    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
								    		      	   		$(feedReport).css('display', 'none');
								    		      			$(".selectRtype").css("display", "inline-block");
								    		      	   		$(".sendreport").css("display", "none");
								    		      	   	});
								    		      	   	
								    		      	   	$(".Rtype").on("click",function(e){
								    		      	   		$(".selectRtype").css("display", "none");
								    		      	   		$(".sendreport").css("display", "block");
								    		      	   	});
								    		          
								    		          /* 댓글 수정시 텍스트창 변경 */
								    		          $('.rEdit').on("click", function(e) {
								    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
								    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
								    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

								    		      			repCon.css('border', '1px solid #555555');
								    		        	  	repCon.removeAttr('disabled');
								    		        	  	repCon.removeAttr('readonly');
								    		        	  	repBtn.css('display', 'block');
								    		        	  	rupBtn.css('display', 'none');
								    		        	 
								    		        	  	$('.reply_menu').hide();
								    		          });
								      					
								      				}, error: function() {
								      					console.log("전송 실패");
								      				}
								      			});
								      			
								      		confirm("댓글을 수정하시겠습니까?");
								      	});
				    			      	/*두번째끝*/
				      					
				      				}, error: function() {
				      					console.log("전송 실패");
				      				}
				      			});
				      			
				      		confirm("댓글을 수정하시겠습니까?");
				      	});
			          
			  		// 댓글 삭제 시
			  		$('.rDelete').on("click", function(e) {
			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
						var rWriter = '${loginUser.userId}';
						var none = $(this.parentElement).parents("div#replySub").children.length;
						
						$.ajax({
							url: "deleteReply.do",
							data: {rNo: rNo},
							type: "post",
							success: function(data) {	// 성공 시: success, 실패 시: fail
				  				if(data == "success") {
//									$(ul).css('display', 'none');
									$('.rNum').css('display', 'none');
									location.reload();
								}
							}, error: function() {
								console.log("전송 실패");
							}
						});
						
						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
						if(none == 0) {
							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
						}
						
						confirm("댓글을 삭제하시겠습니까?");
			  		});
			          
			          // text-area resize
			      	$.each(jQuery('textarea[data-autoresize]'), function() {
			      		var offset = this.offsetHeight - this.clientHeight;
			      		var resizeTextarea = function(el) {
			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
			      		};
			      		$(this).on('keyup input', function() {
			      		 resizeTextarea(this);
			      		}).removeAttr('data-autoresize');
			      	});
			          
			          /*공유하기*/
					$(function(){
						
						$('.share_feed').on("click",function(){
							$.ajax({
								url:"shareFeed.do",
								data:{ fNo:fNo, mNo:${ loginUser.mNo} },
								type:"post",
								success:function(data){
									if( data > 0){
										alert("게시글을 공유하였습니다.");
										$('.pop_menu').hide();
									}
								},error:function(){
									alert("공유 실패");
								}
							});
						});
					});
			          
				    /*게시글 보관함 추가*/
					$(function(){
						$('.goStorage').on("click",function(){
							console.log(mNo);
							$.ajax({
								url:"selectStorage.do",
								data:{ mNo:mNo},
								dataType:"json",
								success:function(data){
									$('.pop_menu').hide();
							         $('.pop_Mymenu').hide();
									$divAll = $('.storagePop');
									$divAll.html("");
									
										var $input = $('<input type="hidden" id="in_fno" class="in_fno" value="'+fNo+'">')
										var $div = $('<div class="storagePop_menu" id="storagePop_menu" style="background: white; width: 320px; margin: auto; height: 183px; border-radius: 15px;">');
										var $p = $('<p id="sbText" style="margin-top:300px; text-align:center; padding:20px 0 20px 0; border-bottom:1px solid #ccc; color:#555555; font-weight:600">').text("보관함");
										var $p2 = $('<p id="sbText2" style="color:#555555; font-size:14px; text-align:center; padding:20px 0 20px 0">').text("보관함을 선택해주세요.")
										var $select = $('<select id="sbSel" style="width:140px; height:32px; border-radius:10px; margin:0 10px 0 40px">');
										for(var i=0; i < data.length; i++){
											$select.append('<option id="op" value="'+data[i].sbNo+'">'+data[i].sbName+"</option>");
										}
										var $button = $('<input type="button" id="insertStorage" class="insertStorage" value="확인" style="width:80px; height:32px; border:0; border-radius:10px; background:#daf4ed">');	
										
										
										$div.append($p);
										$div.append($p2);
										$div.append($select);
										$div.append($button);
										$divAll.append($input);
										$divAll.append($div);
									
									$('.storagePop').show();
								}
							});
							
							$(document).on("click",".insertStorage",function(){
								console.log(fNo);
								var sbNo = $(this).prev('select').children('option:selected').val();
								var sbName = $(this).prev('select').children('option:selected').text();
								
								console.log(sbNo);
								console.log(sbName);
								$.ajax({
									url:"insertStorage.do",
									data:{ fNo:fNo,mNo:mNo,sbNo:sbNo,sbName:sbName },
									type:"post",
									success:function(data){
										if(data > 0){
											alert("게시글을 보관함에 넣었습니다.");
										}else if(data == 0){
											alert("게시글이 이미 보관되어있습니다.");
										}
										$('.storagePop').hide();
										$('.pop_menu').hide();
									},error:function(){
										alert("보관함에 이미 게시글이 있거나, 보관함에 넣기 실패하였습니다.");
									}
								});
							});
						});
					});

            	}, error:function(request,jqXHR,exception){
                   var msg="";
                   if(request.status == 0){
                      msg = 'Not Connect. \n Verify Network.';
                   } else if(request.status == 404){
                      msg = 'Requested page not fount [404]';
                   } else if(request.status == 500){
                      msg = 'Internal Server Error [500]';
                   } else if(request.status == 'parsererror'){
                      msg = 'Requested JSON parse failed';
                   } else if(exception == 'timeout'){
                      msg = 'Time out error';
                   } else if(exception == 'abort'){
                      msg = 'Ajax request aborted';
                   } else {
                      msg = 'Error. \n' + jqXHR.responseText;
                   }
                   alert(msg);
                } 
         	});
	}
  function nextBtn(index){
  	
		//size = $(this).nextAll().children('li').length;
		console.log(index);
		
		if( size > 1){
			idx1 = (idx + 1) % size;
			$(this).nextAll().children('li:hidden').css("left","633px");
			$(this).nextAll().children('li:eq('+idx+')').animate({left:"-=633px"},500, function(){
				$(this).css("display","none").css("left","633px");
			});
			$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"-=633px"},500);
			idx = idx1;
		}
}
  
  $('#pb1').click(function() {
      $(".pop_feed").show();
  });

  $('.pb2').mouseover(function() {
      $(this).css({'background' : '#daf4eda1'});
  }).mouseleave(function() {
      $(this).css({'background' : 'none'});
  }).click(function() {
      $(".pop_feed").show();
  });
  

  
  $('.rClose').on("click", function(){
      $('.reply_menu').hide();
  });
  $('.deleteMyPost').on('click', function () {
  	confirm('이 포스트를 정말 삭제하시겠습니까?');
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
        
        function likeClick(likeStatu){
          	var likeid = likeStatu.getAttribute('id');

          	console.log(likeStatu);
          	
        		// 좋아요 알람
        			console.log("likeicon 클릭");
        			var toId = $('.toId').val();
        			var toNo = $('.toNo').val();   
        			var fromId = '${loginUser.userId}';
        			
        			if(likeid == 'likeIcon'){
        				
        				$.ajax({
        					url: "likeCount2.do",
        					data : {fNo : toNo,
        							type : 'up',
        							userId : 'null'},
        					success : function(data){
        					//	console.log(data + "좋아요 카운트 up 성공");
        						
        						
        						$('#likeIcon').attr('src','/spring/resources/icons/heart_red.png');
        						$('#likeIcon').attr('id','liked');				
        						sendAlram("상관없음",toId,"like",toNo);
        						var test = $('.fLikeCnt').val();
        						test *= 1;
        						test = test + 1;
        						$('.likeCnt').text(test+"개");
        						$('.fLikeCnt').val(test);
        						
        					},
        		             error:function(){
        		                 alert('좋아요 실패!');
        		            } 
        				});
        			}else{
        				$.ajax({
        					url: "likeCount2.do",
        					data : {fNo : toNo,
        							type : 'down',
        							userId : fromId},
        					success : function(data){
        					//	console.log(data + "좋아요 카운트 down 성공");
        						$('#liked').attr('src','/spring/resources/icons/heart.png');
        						$('#liked').attr('id','likeIcon');
        						var test = $('.fLikeCnt').val();
        						test *= 1;
        						test = test - 1;
        						$('.likeCnt').text(test+"개");
        						$('.fLikeCnt').val(test);
        					},
        		             error:function(){
        		                 alert('좋아요 실패!');
        		            } 
        				});
        			}
        		
          }
        /*댓글 등록*/
        function applyReply(fNo){
        	console.log(fNo);
        	var rContent = $('.replyContent').val();
      		var rfNo = fNo;
      		var rWriter = '${loginUser.userId}';
      		var mNo = '${loginUser.mNo}';
      		
      		var ok = confirm("댓글을 등록하시겠습니까?");
         	console.log(ok);
         	if(ok){
      		
         	$.ajax({
      			url: "addReply.do",
      			data: {
      				rContent: rContent,
      				rfNo: rfNo,
      				rWriter: rWriter,
      				mNo: mNo,
      				fNo : fNo
      			},
      			type: "post",
      			async:false,
      			success: function(data) {	// 성공 시: success, 실패 시: fail
      					var refNo = fNo;
      					var reWriter = '${loginUser.userId}';
      					var mNo = '${loginUser.mNo}';
      			    	sendAlram("상관없음",reWriter,"reply",refNo);
      					$('.replyContent').val("");	// 등록 시에 사용한 댓글 내용 초기화
      					//location.reload();
      					
      					$('#replySub').remove();
      					
      					var input = "";
      					 input +="<div id='replySub'>";
      	              for(var i=0;i<data.replyList.length;i++){
      		              input +="<div id='selectOne'>";	
      		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
      		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
      	                  input +="<div id='replyList'>";
      	                  input +="<ul id='re_list' class='list'>";
      	                if(data.replyList[i].mNo == mNo){
  			  			  if(data.replyList[i].rWriterImg != null){
  			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
  			  			  }else{
  			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
  			  			  }
  	                  } else {
  	                	  if(data.replyList[i].rWriterImg != null){
  	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
  	                	  }else{
  	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
  	                	  }
  	                  }
      	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
      		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
      		              input +="<li><img src='/spring/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
      		              if(data.replyList[i].mNo == mNo){
      						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
      		               }
      					  input +="</ul>";
      		              input +="</div>";
      		              input +="<div class='reply_menu'>";

      		              if(data.replyList[i].mNo == mNo){
      			              input +="<div id='re_menu_list'>";
      			              input +="<ul>";
      			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
      			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
      			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
      			              input +="</ul>";
      			          	  input +="</div>";
      		              } else{
      			              input +="<div id='user_menu_list'>";
      			              input +="<ul>";
      		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
      		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
      			              input +="</ul>";
      			          	  input +="</div>";
      			    		  <!-- 댓글을 신고해보자! -->
      			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
      			    		  input +="<div id='reply_report_con'>";
      				    	  input +="<p>신고사유</p>";
      				    	  input +="<select id='reply_reportType' class='selectRtype'>";
      				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
      					      input +="<option value='insult'>욕설</option>";
      					      input +="<option value='ad'>광고</option>";
      					      input +="<option value='spam'>도배</option>";
      					      input +="</select>";   
      					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
      					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
      					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
      					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
      					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
      					      input +="</div>";
      					      input +="</div>";
      		              }
                         input +="</div>";
                         input +="</div>";
      	              }
      	                  input +="</div>"; 
      	                  
      	                  $('#replyEditCont').append(input);
      	                  
           	      	        $('.feed_delete').click(function() {
           	      	            $(".pop_feed").hide();
           	      	        });
           	      	        
           		      	      $('#feed_menu').click(function() {
           		                  $('.pop_menu').show();
           			          }); 
           			      	
           			          $('.close').on('click', function(){
           			              $('.pop_menu').hide();
           			          });
           			          
           	 		          $('.rUpBtn').on("click", function(e){
           	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
           			              $(replyMenu).show();
           			          }); 
           			          $('.rClose').on("click", function(){
           			              $('.reply_menu').hide();
           			          });
           			          
           			          $('.cancel').on("click", function(){
           			              $('.feed_report').hide();
           			          });
           			          
           			          $('.cancel').on("click", function(){
           			              $('.reply_report').hide();
           			          });
           			          
           			  		// 댓글 삭제 시
           			  		$('.rDelete').on("click", function(e) {
           			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
           						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
           						var rWriter = '${loginUser.userId}';
           						var none = $(this.parentElement).parents("div#replySub").children.length;
           						
           						$.ajax({
           							url: "deleteReply.do",
           							data: {rNo: rNo},
           							type: "post",
           							success: function(data) {	// 성공 시: success, 실패 시: fail
           				  				if(data == "success") {
//           									$(ul).css('display', 'none');
           									$('.rNum').css('display', 'none');
           									location.reload();
           								}
           							}, error: function() {
           								console.log("전송 실패");
           							}
           						});
           						
           						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
           						if(none == 0) {
           							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
           						}
           						
           						confirm("댓글을 삭제하시겠습니까?");
           			  		});
           			          
           			          // text-area resize
           			      	$.each(jQuery('textarea[data-autoresize]'), function() {
           			      		var offset = this.offsetHeight - this.clientHeight;
           			      		var resizeTextarea = function(el) {
           			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
           			      		};
           			      		$(this).on('keyup input', function() {
           			      		 resizeTextarea(this);
           			      		}).removeAttr('data-autoresize');
           			      	});
           			          
        		  		 	/* 댓글 신고하기*/
        		  		 	// 1. 신고하기 버튼 이벤트
        		  		 	$(document).on("click","#rReport",function(){
        		  		 		$(".reply_report").css("display","block");
        		  		 		// 2.리플 번호 불러오기
        		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
        		  		 		
        		  			 	// 3. 댓글 신고하기
        		  			 	$(document).on("click",'.reply_submit',function(){
        		  			 		var text =$(this).prev().prev().prev().val();
        		  			 		
        		  			 		console.log(text);
        		  		 			console.log(targetrNo);
        		  			 		console.log($("#reply_reportType").val());
        		  			 		
        		  			 		if(text == ""){
        		  						alert('신고 사유를 입력해 주세요.')
        		  					}else{
        		  						
        		  						$.ajax({
        		  							url:'reportRInsert.do',
        		  							data:{
        		  								reportType : $("#reply_reportType").val(),
        		  								replyType : "reply",
        		  								content : text,
        		  								targetrNo:targetrNo
        		  							},
        		  							success: function(){
        		  								alert('신고 완료');
        		  								$('.reply_menu').hide();
        		  					      		$('.reply_report').hide();
        		  							},error:function(){
        		  								alert('신고 실패!');
        		  							}
        		  						});
        		  						
        		  					};	
        		  			 	});
        		  		 	});
        		         	 
        		      	   	$(".cancel2").on("click",function(e){
        		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
        		      	   		$(feedReport).css('display', 'none');
        		      			$(".selectRtype").css("display", "inline-block");
        		      	   		$(".sendreport").css("display", "none");
        		      	   	});
        		      	   	
        		      	   	$(".Rtype").on("click",function(e){
        		      	   		$(".selectRtype").css("display", "none");
        		      	   		$(".sendreport").css("display", "block");
        		      	   	});
        		          
        		          /* 댓글 수정시 텍스트창 변경 */
        		          $('.rEdit').on("click", function(e) {
        		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
        		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
        		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

        		      			repCon.css('border', '1px solid #555555');
        		        	  	repCon.removeAttr('disabled');
        		        	  	repCon.removeAttr('readonly');
        		        	  	repBtn.css('display', 'block');
        		        	  	rupBtn.css('display', 'none');
        		        	 
        		        	  	$('.reply_menu').hide();
        		          });
        		          
        			      	/* 두번째 댓글 수정 시 완료 버튼 누르면 */
        			       	$('.rConfirm').on("click", function(e) {
        			      		var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
        			      		var rWriter = '${loginUser.userId}';
        			      		var replyContent = $(this).parent().children()[1].children[0].value;
        			      		
        			      			$.ajax({
        			      				url: "editReply.do",
        			      				data: {
        			      					rContent: replyContent,
        			      					rNo: rNo,
        			      					rWriter: rWriter,
        			      					fNo : fNo
        			      				},
        			      				type: "post",
        			      				async:false,
        			      				success: function(data) {	// 성공 시: success, 실패 시: fail
        			      					console.log(data);
        			       				
//        			      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
        			       						//location.href="goMypage.do?mNo="+mNo;
        			       						$('#replySub').remove();
        			       						
        			       						var input = "";
        			       					 input +="<div id='replySub'>";
        			       	              for(var i=0;i<data.replyList.length;i++){
        			       		              input +="<div id='selectOne'>";	
        			       		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
        			       		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
        			       	                  input +="<div id='replyList'>";
        			       	                  input +="<ul id='re_list' class='list'>";
        			       	               if(data.replyList[i].mNo == mNo){
        			 			  			  if(data.replyList[i].rWriterImg != null){
        			 			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
        			 			  			  }else{
        			 			  				input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
        			 			  			  }
        			 	                  } else {
        			 	                	  if(data.replyList[i].rWriterImg != null){
        			 	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
        			 	                	  }else{
        			 	                		  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='/spring/resources/icons/pro_default.png' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
        			 	                	  }
        			 	                  }
        			       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
        			       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
        			       		              input +="<li><img src='/spring/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
        			       		              if(data.replyList[i].mNo == mNo){
        			       						  input +="<input type='button' id='confirmR' class='rConfirm' value='완료'></li>";
        			       		               }
        			       					  input +="</ul>";
        			       		              input +="</div>";
        			       		              input +="<div class='reply_menu'>";

        			       		              if(data.replyList[i].mNo == mNo){
        			       			              input +="<div id='re_menu_list'>";
        			       			              input +="<ul>";
        			       			              input +="<li><a id='rEdit' class='rEdit'>댓글 수정</a></li>"; 
        			       			              input +="<li><a class='rDelete'>댓글 삭제</a></li>";
        			       			              input +="<li><a id='re_close' class='rClose'>취소</a></li>";
        			       			              input +="</ul>";
        			       			          	  input +="</div>";
        			       		              } else{
        			    			              input +="<div id='user_menu_list'>";
        			    			              input +="<ul>";
        			    		            	  input +="<li><a id='rReport' class='rReport'>댓글 신고</a></li>";
        			    		            	  input +="<li><a id='re_close' class='rClose'>취소</a></li>";
        			    			              input +="</ul>";
        			    			          	  input +="</div>";
        			    			    		  <!-- 댓글을 신고해보자! -->
        			    			    		  input +="<div class='reply_report' id='reply_report' style='display:none'>";
        			    			    		  input +="<div id='reply_report_con'>";
        			    				    	  input +="<p>신고사유</p>";
        			    				    	  input +="<select id='reply_reportType' class='selectRtype'>";
        			    				    	  input +="<option value='unacceptfeed' selected>부적절한 게시글</option>";
        			    					      input +="<option value='insult'>욕설</option>";
        			    					      input +="<option value='ad'>광고</option>";
        			    					      input +="<option value='spam'>도배</option>";
        			    					      input +="</select>";   
        			    					      input +="<textarea class='sendreport Rcontent' id='reply_reportContent' cols='28' rows='4'></textarea>";
        			    					      input +="<br> <input class='selectRtype Rtype' id='selectRtype' type='button' value='확인' style='cursor: pointer;'>";
        			    					      input +="<input class='sendreport reply_submit' type='button' id='reply_report-submit' value='확인' style='cursor: pointer; display: none;'>";
        			    					      input +="<button class='selectRtype cancel' id='cancel' style='cursor: pointer;'>취소</button>";
        			    					      input +="<button class='sendreport cancel2' id='cancel2' style='cursor: pointer; display: none;'>취소</button>";
        			    					      input +="</div>";
        			    					      input +="</div>";
        			       		              }
        			                          input +="</div>";
        			                          input +="</div>";
        			       	              }
        			       	                  input +="</div>"; 
        			       	                  
        			       	                  $('#replyEditCont').append(input);
        			       	                  
        			       	                  
        			       	      	        $('.feed_delete').click(function() {
        			       	      	            $(".pop_feed").hide();
        			       	      	        });
        			       	      	        
        			       		      	      $('#feed_menu').click(function() {
        			       		                  $('.pop_menu').show();
        			       			          }); 
        			       			      	
        			       			          $('.close').on('click', function(){
        			       			              $('.pop_menu').hide();
        			       			          });
        			       			          
        			       	 		          $('.rUpBtn').on("click", function(e){
        			       	 		        	  var replyMenu = e.target.parentElement.parentElement.parentElement.nextElementSibling;
        			       			              $(replyMenu).show();
        			       			          }); 
        			       			          $('.rClose').on("click", function(){
        			       			              $('.reply_menu').hide();
        			       			          });
        			       			          
        			       			          $('.cancel').on("click", function(){
        			       			              $('.feed_report').hide();
        			       			          });
        			       			          
        			       			          $('.cancel').on("click", function(){
        			       			              $('.reply_report').hide();
        			       			          });
        			       			          
        			       			  		// 댓글 삭제 시
        			       			  		$('.rDelete').on("click", function(e) {
        			       			  	 		var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
        			       						var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
        			       						var rWriter = '${loginUser.userId}';
        			       						var none = $(this.parentElement).parents("div#replySub").children.length;
        			       						
        			       						$.ajax({
        			       							url: "deleteReply.do",
        			       							data: {rNo: rNo},
        			       							type: "post",
        			       							success: function(data) {	// 성공 시: success, 실패 시: fail
        			       				  				if(data == "success") {
//        			       									$(ul).css('display', 'none');
        			       									$('.rNum').css('display', 'none');
        			       									location.reload();
        			       								}
        			       							}, error: function() {
        			       								console.log("전송 실패");
        			       							}
        			       						});
        			       						
        			       						// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
        			       						if(none == 0) {
        			       							$(this.parentElement).parents("div#replyEditCont").css('display', 'none');
        			       						}
        			       						
        			       						confirm("댓글을 삭제하시겠습니까?");
        			       			  		});
        			       			          
        			       			          // text-area resize
        			       			      	$.each(jQuery('textarea[data-autoresize]'), function() {
        			       			      		var offset = this.offsetHeight - this.clientHeight;
        			       			      		var resizeTextarea = function(el) {
        			       			      			$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
        			       			      		};
        			       			      		$(this).on('keyup input', function() {
        			       			      		 resizeTextarea(this);
        			       			      		}).removeAttr('data-autoresize');
        			       			      	});
        			       			          
        			    		  		 	/* 댓글 신고하기*/
        			    		  		 	// 1. 신고하기 버튼 이벤트
        			    		  		 	$(document).on("click","#rReport",function(){
        			    		  		 		$(".reply_report").css("display","block");
        			    		  		 		// 2.리플 번호 불러오기
        			    		  			 		var targetrNo = $(this).parent().parent().parent().parent().prev().prev().val();
        			    		  		 		
        			    		  			 	// 3. 댓글 신고하기
        			    		  			 	$(document).on("click",'.reply_submit',function(){
        			    		  			 		var text =$(this).prev().prev().prev().val();
        			    		  			 		
        			    		  			 		console.log(text);
        			    		  		 			console.log(targetrNo);
        			    		  			 		console.log($("#reply_reportType").val());
        			    		  			 		
        			    		  			 		if(text == ""){
        			    		  						alert('신고 사유를 입력해 주세요.')
        			    		  					}else{
        			    		  						
        			    		  						$.ajax({
        			    		  							url:'reportRInsert.do',
        			    		  							data:{
        			    		  								reportType : $("#reply_reportType").val(),
        			    		  								replyType : "reply",
        			    		  								content : text,
        			    		  								targetrNo:targetrNo
        			    		  							},
        			    		  							success: function(){
        			    		  								alert('신고 완료');
        			    		  								$('.reply_menu').hide();
        			    		  					      		$('.reply_report').hide();
        			    		  							},error:function(){
        			    		  								alert('신고 실패!');
        			    		  							}
        			    		  						});
        			    		  						
        			    		  					};	
        			    		  			 	});
        			    		  		 	});
        			    		         	 
        			    		      	   	$(".cancel2").on("click",function(e){
        			    		      	   		var feedReport = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
        			    		      	   		$(feedReport).css('display', 'none');
        			    		      			$(".selectRtype").css("display", "inline-block");
        			    		      	   		$(".sendreport").css("display", "none");
        			    		      	   	});
        			    		      	   	
        			    		      	   	$(".Rtype").on("click",function(e){
        			    		      	   		$(".selectRtype").css("display", "none");
        			    		      	   		$(".sendreport").css("display", "block");
        			    		      	   	});
        			    		          
        			    		          /* 댓글 수정시 텍스트창 변경 */
        			    		          $('.rEdit').on("click", function(e) {
        			    		      		var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
        			    		      		var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");
        			    		      		var rupBtn = $(this.parentElement).parents("div#selectOne").find("img#updateBtn");

        			    		      			repCon.css('border', '1px solid #555555');
        			    		        	  	repCon.removeAttr('disabled');
        			    		        	  	repCon.removeAttr('readonly');
        			    		        	  	repBtn.css('display', 'block');
        			    		        	  	rupBtn.css('display', 'none');
        			    		        	 
        			    		        	  	$('.reply_menu').hide();
        			    		          });
        			    		          
        			      				}, error: function() {
        			      					console.log("전송 실패");
        			      				}
        			      			});
        			      			
        			      		confirm("댓글을 수정하시겠습니까?");
        			      	});
        			      	/*두번째끝*/

      			}, error: function() {
      				console.log("전송 실패");
      			}
      		}); 
         	
         	} else {
         		
         		$('.replyContent').val("");	// 등록 시에 사용한 댓글 내용 초기화
         	}
        }
    /*@유저 이벤트*/
    function goUser(){
    	var id = $(event.target).attr('id')
    	var mno = ${ loginUser.mNo };
    	location.href ='goUserpage.do?userId='+id+'&mNo='+mno;
    }
    /*#태그 이벤트*/
    function goTag(htag) {
    	var tag = $(htag).text();
    	location.href="search.do?type=tag&key="+tag.substr(1)+"&mNo="+${ loginUser.mNo };
	}
    </script>
</body>
</html>