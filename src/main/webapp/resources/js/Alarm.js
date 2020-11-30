/**
 * 알람 기능 관련 스크립트
 */

// 알람 전송
 function sendAlram(fromId,toId,type,aNo) {
// 	 var fromId = fromId;//알람을 보낼id   
// 	 var toId = toId;
//	 var sendType = type; // 보낼 알람의 타입
//	 var type = type;
//	 var crNo = aNo;//보내질 알람 타입별 유저/게시물번호   
	 console.log(fromId+","+toId+","+type+","+aNo +"여기까지나옴");
	 sock.send("alarm"+"|"+toId+"|"+type+"|"+aNo);

 }

 // 좋아요 클릭시 알람
 $(".likeIcon").on('click',function(e){
	 console.log("like클릭됨");
	 $("#"+e.target.id).css('background','red');
	 $("#"+e.target.id).parent().children('input').val()
	 console.log("상관없음",$("#"+e.target.id).parent().children('input').val(),'like',$("#"+e.target.id).parent().children('.fNo').val());
	 sendAlram("상관없음",$("#"+e.target.id).parent().children('input').val(),'like',$("#"+e.target.id).parent().children('.fNo').val());
 });

//그룹원 내보내기 알림
	$(".del_gm").on('click',function(e){
		console.log("e.target:"+e.target.getElementById());
		sendAlram();
	});

	//그룹 가입 신청 알람
	$("#joinBtn").on('click',function(){
		alert('그룹가입 신청');
		// 그룹 가입 알람
      	function sendAlarm(){
      		console.log('${loginUser.userId}','${g.gCreator}',"groupjoin",'${g.gNo}');
      		sendAlram('${loginUser.userId}','${g.gCreator}','groupjoin','${g.gNo}');          		
      	};
	});
	// 팔로우 클릭
	$('#follow_btn').click(function() {

         console.log("follow 클릭됨");
        sendAlram('${loginUser.userId}','${ memberInfo.userId }','follow','1');
	});

	// 그룹가입알람 그룹디테일에 넣어야함
	$("#joinBtn").on('click',function test(){
			alert("test");
			console.log('${loginUser.userId}','${g.gCreator}',"groupjoin",'${g.gNo}');
  		sendAlram('${loginUser.userId}','${g.gCreator}','groupjoin','${g.gNo}');   
		});
	
	
	
    /************ 포스트 박스 클릭 시 script ************/
    function goDetail(fNo,smNo){
    	var mNo = $('#mNo').val();
    
           $.ajax({
              url:"goDetail.do", 
              dataType:"json",
		    	// smNo : 공유한 글작성자
              data:{mNo: mNo,fNo : fNo, smNo : smNo},
              type:"post", 
              success:function(data){
                
            	  var input="";
                  input += "<div class='feed_delete'>";
                  input += "<img src='${ contextPath }/resources/icons/close_white.png' type='button'>";
                  input += "</div>";
                  input += "<div id='writer_submenu'>";
                  if(data.mImage != null){
                    input += "<img src='${ contextPath }/resources/memberProfileFiles/"+data.mImage+"' alt='' id='feed_profile_img'>";
                  } else {
                    input += "<img src='${ contextPath }/resources/icons/pro_default.png' alt='' id='feed_profile_img'>";
                  }
	              input += "<div id='user_time'>";
	              input += "<p id='feed_id'>"+data.fWriter+"</p>";
	              input += "<h6>"+data.fCreateDate+"</h6>";
	              input += "</div>";
	              input += "<img src='${ contextPath }/resources/icons/feed_menu.png' alt='' id='feed_menu' class='test'>";
	              input += "</div>";
	              <!-- 내가 쓴 글 볼 때 피드 메뉴 -->
	              input +="<div class='pop_menu'>";

	              if(data.shareYN == 'N'){
		              input +="<div id='feed_Mymenu_list'>";
		              input +="<ul>";
		              input +="<li><a href='pUpdateView.do?fNo="+fNo+"&like="+data.fLikeSet+"&share="+data.fShareSet+"&reply="+data.fReplySet+"' id='feed_menu1_btn'>수정</a></li>";
		              input +="<li><a href='pDelete.do?fNo="+fNo+"' class='deleteMyPost'>삭제</a></li>";
		              input +="<li><a id='close' class='close'>취소</a></li>";
		              input +="</ul>";
		              input +="</div>";
	              } else{
		              input +="<div id='share_Mymenu_list'>";
		              input +="<ul>";
	            	  input +="<li><a href='shareFeedCancle.do?sfNo="+fNo+"&smNo="+mNo+"' class='deleteMyPost'>공유 취소</a></li>";
		              input +="<li><a id='close' class='close'>취소</a></li>";
		              input +="</ul>";
		              input +="</div>";
	              }
	              input +="</div>";
	              input +="<div id='con'>";
	              input +="<div id='feed_content'>";
  	        	  	if(data.photoList[0] != null){
		      	  	input +="<button id='nextBtn${ i }' name='nextBtn' class='imgbtn nextBtn'><img src='${ contextPath }/resources/icons/nextbtn.png'></button>";
					input +="<button id='prevBtn${ i }' name='prevBtn' class='imgbtn prevBtn'><img src='${ contextPath }/resources/icons/prevbtn.png'></button>";
	            	input +="<ul id='imgList' style='height:633px'>";
		              for(var i=0; i < data.photoList.length; i++){
						  if(data.photoList[i].changeName != null){
							  input +="<li><img src='${ contextPath }/resources/pUploadFiles/"+data.photoList[i].changeName+"' alt='' id='input_img'></li>";
			              }
		              } 
		              input +="</ul>";
  	        	  }
	              input +="<p id='text'>"+data.fcontent+"</p>";
	              if(data.shareYN == 'N'){
	              input +="<div id='heart_reply'>";
				  <!-- 좋아요 금지가 되어 있지 않을 경우 -->
 				  if(data.fLikeSet == 'Y' ||  data.fLikeSet == null){
					<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
	             	if(data.likeChk == null){
		             	input +="<img src='${ contextPath }/resources/icons/heart.png' alt='' name='"+fNo+"'class='likeIcon' id='likeIcon' onclick='likeClick(this);'>";
		             	input +="<label class='likeCnt' id='"+fNo+"'>"+data.fLikeCnt+"개</label>";
	             	} else {
		             	input +="<img src='${ contextPath }/resources/icons/heart_red.png' alt='' name='"+fNo+"' class='liked' id='liked' onclick='likeClick(this);'>";	             	
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
				  	 input +="<img src='${ contextPath }/resources/icons/bubble.png' alt='' id='replyIcon' style='margin: 9px 0 0 25px;'>";
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
				  	 input +="<img src='${ contextPath }/resources/icons/bubble.png' alt='' id='replyIcon'>";
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
                  if(data.replyList[0] != null){
	              input +="<div id='replySub'>";
	              for(var i=0;i<data.replyList.length;i++){
		              input +="<div id='selectOne'>";	
		              input +="<input type='hidden' id='hdFno' class='fno' value='"+fNo+"'>";		              
		              input +="<input type='hidden' class='rNum' value='"+data.replyList[i].rNo+"'>";		              
	                  input +="<div id='replyList'>";
	                  input +="<ul id='re_list' class='list'>";
	                  if(data.replyList[i].mNo == mNo){
	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	                  } else {
	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	                  }
	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
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
	              input +="<input type='text' id='textArea'class='rContent'  name='textArea'>";
	              input +="<input type='button' id='replyBtn'  class='replyUpBtn' name='replyBtn' value='등록' onClick='applyReply("+fNo+");'>";
	              input +="</div>";
                  }
	              input +="</div>";
	              }
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
		        var count = $(".pop_feed").children('div#con').children('div#feed_content').children("ul#imgList").children('li').length;
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
		       				
//		      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
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
		       	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		       	                  } else {
		       	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		       	                  }
		       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
		       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
		       		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
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
//		       									$(ul).css('display', 'none');
		       									$('.rNum').css('display', 'none');
		       									location.href="goMypage.do?mNo="+mNo;
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
		    			       				
//		    			      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
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
		    			       	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		    			       	                  } else {
		    			       	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
		    			       	                  }
		    			       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
		    			       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
		    			       		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
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
//		    			       									$(ul).css('display', 'none');
		    			       									$('.rNum').css('display', 'none');
		    			       									location.href="goMypage.do?mNo="+mNo;
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
//								$(ul).css('display', 'none');
								$('.rNum').css('display', 'none');
								location.href="goMypage.do?mNo="+mNo;
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

    $('.pb2').mouseover(function() {
        $(this).css({'background' : '#daf4eda1'});
    }).mouseleave(function() {
        $(this).css({'background' : 'none'});
    }).click(function() {
        $(".pop_feed").show();
    });
    

    
    /*댓글 등록*/
    function applyReply(fNo){
    	console.log(fNo);
    	var rContent = $('.rContent').val();
		var rfNo = fNo;
		var rWriter = '${loginUser.userId}';
		var mNo = $('#mNo').val();
		
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
					var mNo = $('#mNo').val();
			    	sendAlram("상관없음",reWriter,"reply",refNo);
					$('.rContent').val("");	// 등록 시에 사용한 댓글 내용 초기화
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
      	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
      	                  } else {
      	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
      	                  }
      	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
      		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
      		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
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
//	       									$(ul).css('display', 'none');
	       									$('.rNum').css('display', 'none');
	       									location.href="goMypage.do?mNo="+mNo;
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
	    			       				
//	    			      						$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
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
	    			       	                	  input +="<li><a href='goMypage.do?mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	    			       	                  } else {
	    			       	            	  	  input +="<li><a href='goUserpage.do?userId="+data.replyList[i].rWriter+"&mNo="+mNo+"'><img src='${ contextPath }/resources/memberProfileFiles/"+data.replyList[i].rWriterImg+"' alt='' id='reply_img'>&nbsp;&nbsp;&nbsp;<p id='userId'>"+data.replyList[i].rWriter+"</p></a></li>";
	    			       	                  }
	    			       	            	  input +="<li><textarea id='replyCon' class='rCon' data-autoresize readonly required='required' placeholder='댓글을 입력해 주세요.' cols=40 rows=auto disabled>"+data.replyList[i].rContent+"</textarea>";
	    			       		              input +="<li><p id='time'>"+data.replyList[i].rModifyDate+"</p></li>";
	    			       		              input +="<li><img src='${ contextPath }/resources/icons/replyMenu.png' type='button' alt='' id='updateBtn' class='rUpBtn'></li>";
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
//	    			       									$(ul).css('display', 'none');
	    			       									$('.rNum').css('display', 'none');
	    			       									location.href="goMypage.do?mNo="+mNo;
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
     		
     		$('.rContent').val("");	// 등록 시에 사용한 댓글 내용 초기화
     	}
    }
    
	  $('.rClose').on("click", function(){
	      $('.reply_menu').hide();
	  });
	  $('.deleteMyPost').on('click', function () {
	  	confirm('이 포스트를 정말 삭제하시겠습니까?');
	  });
