<%@page import="com.kh.spring.feed.model.vo.Feed"%>
<%@page import="com.kh.spring.feed.model.vo.Photo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    
    <style>
    	#postingForm { height: 704px; margin-bottom: 100px; border: none; }
    	#photolistUpView { width: 100px; height: 100px; border: 1px solid #e5e5e5; 
    					   border-radius: 10px; margin: 20px 0px 0px 15px; }
    	#photolistUpView img { width: inherit; height: inherit; border-radius: 10px; }
    	.plistName{ text-align: center; font-size: 10pt; width: 100px;
    				margin-left: 20px; text-align: center; }
    	#postingArea{ border: 2px #e5e5e5 solid; background: white; border-radius: 10px; width: 630px; }
    	#postingArea > h4{ text-align: center }
		#postingArea > hr{ border: 1px solid #e5e5e5;}
		#btnstd{ display: inline-flex; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="wapper">
        <c:import url="../common/menubar.jsp"/>
        <div class="content">
            <div class="search_userInfo">
                
            </div>
            <!--피드 영역 스크롤 필요해서 position 인라인으로 변경해둠-->
            <div id="feedArea" style="position: relative;">
            <form action="pUpdate.do" method="post" id="postInsert" enctype="multipart/form-data">
                <!-- 전체 감싸는 div 영역 -->
                <div id="postingForm">
                <div id="postingArea">
                    <h4>피드 수정하기</h4>
                    <hr>
                    	<input type="hidden" name="fWriter" value="${ loginUser.userId }">
						<input type="hidden" name="mNo" value="${ loginUser.mNo }">
						<input type="hidden" name="fNo" value="${ f.fNo }">
<%-- 						<input type="hidden" name="originName" value="${ p.originName }">
						<input type="hidden" name="changeName" value="${ p.changeName }"> --%>
                        <table id="tbb">
                            <!-- 글 쓰는 영역 -->
                            <tr>
                                <td>
                                    <textarea cols="60" rows="7" name="fContent">${ f.fContent }</textarea>
                                </td>    
                            </tr>
                            <!-- 파일 첨부 영역 -->
                            <tr id="tr1">
                                <td>
                                    <img id="fileIcon" src="${ contextPath }/resources/icons/add_file.png">
                                </td>
                                <td class="filetb">
                                    <input type="file" multiple="multiple" id="input_file" name="reloadFile"
                                     accept="image/png, image/jpeg, image/JPEG, image/jpg, image/bmp, image/gif">
                                </td>
                            </tr>
                            <!-- 파일 미리보기 영역 -->
                           
                            <c:forEach var="p" items="${ f.photoList }" varStatus="status">
                            <c:if test="${ !empty p.originName }">
                            <tr class="trView">
								 <c:if test="${ !empty p.originName }">
                          			<td class="plistView" id="pView_${ status.index }">
	                                <div id="photolistUpView" class="photoView">
	                                	<a href="javascript:void(0);" onclick="updateImageAction(${ status.index })" id="img_id_${ status.index }">
	                                    <img id="preview" class="photopreview" src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" title="${ p.originName }" style="width: 100px; height: 100px;">
	                                	</a>
	                                </div>
                              		</td>
                                </c:if>
                            </tr>
                            <tr class="trViewName">
								<td class="plistName" id="pName_${ status.index }">
									<c:if test="${ !empty p.originName }">
	                                <c:choose>
										<c:when test="${ fn:length(p.originName) gt 15 }">
											<c:out value="${ fn:substring(p.originName, 0, 14) }..."/>
										</c:when>
										<c:otherwise>
											${ p.originName }
										</c:otherwise>
									</c:choose>
									<div class="dltImg">
										<a href="javascript:void(0);" onclick="deleteImageAction(${ status.index })" id="dimg_id_${ status.index }">
										<img class="previewDlt" src="${ contextPath }/resources/icons/close.png" style="width: 10px; height: 10px;" />
										</a>
									</div>
	                                </c:if>
                               	</td>
                            </tr>
                            </c:if>
	                        </c:forEach>
	                     
                            <tr id="undertd">
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
<<<<<<< HEAD
=======
                            <tr>
                                <td id="btnstd">
                                    <button id="btns1">
                                        <a id="page_back" href="javascript:history.go(-1)">이전</a>
                                    </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input id="btns2" type="submit" value="작성">
                                </td>
                            </tr>
>>>>>>> branch 'master' of https://github.com/unimik/finalGroobee.git
                        </table>
                    </div>
					<div id="btnstd">
						<button id="btns1">
							<a id="page_back" href="home.do">이전</a>
						</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="btns2" type="submit" value="작성">
					</div>
    				</div>
				</form>
				</div>
			</div>
        </div>

	<script>
		$(document).ready(function() {

			$('#chat_icon').click(function() {
				var state = $(".chat").css('display');
				if (state == 'none') {
					$('.chat').show();
				} else {
					$('.chat').hide();
				}
			});

			/*************** 그룹 선택 옵션 *****************/

			$('#select_board').change(function() {
				var state = $("#select_board option:selected").val();

				if (state == 'group') {
					$('#myGroupList').css("display", "block");
				} else {
					$('#myGroupList').hide();
				}
			})
		});

		$('.tab_menu_btn').on('click', function() {
			$('.tab_menu_btn').removeClass('on');
			$(this).addClass('on')
		});

		$('.tab_menu_btn1').on('click', function() {
			$('.tab_box').hide();
			$('.tab_box1').show();
		});

		$('.tab_menu_btn2').on('click', function() {
			$('.tab_box').hide();
			$('.tab_box2').show();
		});

		/************* 내계정 자세히보기 script **************/

		$(document).ready(function() {
			$('#detailInfo').click(function() {
				$(".myAccount").animate({
					width : "toggle"
				}, 250);
			});
		});

		$('.MyTab_tab').on("click", function() {
			$('.MyTab_tab').removeClass('on');
			$(this).addClass('on')
		});

		$('.MyTab_tab1').on('click', function() {
			$('.MyTab_box').hide();
			$('.MyTab_box1').show();
		});

		$('.MyTab_tab2').on('click', function() {
			$('.MyTab_box').hide();
			$('.MyTab_box2').show();
		});


		
    	/***************** 이미지 미리보기 *****************/
    	
    	var sel_files= [];
    	
    	$(document).ready(function(e) {
    		//var pCount = ${pCount};
    		//alert(pCount);
    		var chk = <%= ((Feed)request.getAttribute("f")).getfNo() %>;
    		$('#input_file').change(
    			function(e) {
    				
    				var files = e.target.files;
    				var arr = Array.prototype.slice.call(files);
					
    				// 업로드 가능 파일인지 체크
    				// 업로드 시에 이미지가 5개를 초과하면 alert창 띄우기
    				var checkPhotopreview = $(".photopreview").length;
    				alert(checkPhotopreview);
    				if((files.length + checkPhotopreview) > 5) {
   						alert('첨부 가능한 이미지 갯수는 5개를 초과할 수 없습니다.')
   						$('#input_file').val(""); // 파일 초기화
   						reloadPhotoList(chk);
   						return false;
   					}
    				
    				for (var i = 0; i < files.length; i++) {
    					if (!checkExtension(files[i].name, files[i].size)) {
    						return false;
    					}
    					
    					
    				// 기존 파일이 있을 시에 갯수 체크해서 추가할 수 있는 만큼의 이미지 갯수만 올리기
    					
    				}


    				preview(arr);

    			}); // file change

    		function checkExtension(fileName, fileSize) {

    			var regex = new RegExp("(.*?)\.(bmp|gif|png|jpg|jpeg)$");
    			var maxSize = 20971520; // 20MB

    			if(fileSize >= maxSize) {
    				alert('파일 사이즈를 초과하였습니다.');
    				$('#input_file').val(""); // 파일 초기화
    				
    				return false;
    			}

    			if(!regex.test(fileName)) {
    				alert('이미지 확장자만 업로드 가능합니다.');
    				$('#input_file').val(""); // 파일 초기화
    				return false;
    			}
    			
    			return true;
    		}

    		function preview(arr) {
    			// 1
    			var index = 0;
    			var index2 = 0;
    			
    			arr.forEach(function(fUp) {
    				
    				sel_files = [];
    				sel_files.push(fUp);
    				
    				console.log(sel_files);
    				
    				// 파일명이 길면 파일명...으로 처리
    				var fileName = fUp.name;
    				if (fileName.length > 10) {
    					fileName = fileName.substring(0, 9) + "...";
    				}

    				// 이미지 파일 미리보기
    				if (fUp.type.match('image.*')) {
    					var reader = new FileReader(); // 파일을 읽기 위한 FileReader객체 생성
    					reader.onload = function(e) { // 파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
    					
    						// tr에 이미지, 이미지명 추가
    						var str = '<td class="plistView" id="pView_'+index+'"><div id="photolistUpView" class="photoView">';
    						var name = '<td class="plistName" id="pName_'+index+'">';
    						
    						str += '<a href=\"javascript:void(0);\" onclick=\"updateImageAction('+index+')\" id=\"img_id_'+index+'\"><img id="preview" class="photopreview" src="'+e.target.result+'" title="'+fUp.name+'" style="width: 100px; height: 100px;" /></a>';
    						str += '</div></td>';
    						$(str).appendTo('.trView');
    						
    						name += fileName + '<div class="dltImg"><a href=\"javascript:void(0);\" onclick=\"deleteImageAction('+index+')\" id=\"dimg_id_'+index+'\"><img class="previewDlt" src="${ contextPath }/resources/icons/close.png" style="width: 10px; height: 10px;" /></a>';
    						name += '</div>' +'</td>';
    						index++;
    						$(name).appendTo('.trViewName')
    						
    						console.log(fUp);
    						console.log(fUp.name);
    						console.log(fUp.name.length);
    						console.log(fileName);
    						
    					}
    					reader.readAsDataURL(fUp);
    				}
    			}); // arr.forEach
    		}
    		
    	});
    		
   		// X 이미지 클릭 시 삭제 이벤트 핸들러
       	function deleteImageAction(index) {
       		console.log("index : " + index);
       		sel_files.splice(index, 1);
       		
       		var dimg_id = "#dimg_id_" + index;
       		var img_id = "#img_id_" + index;
       		var image = "#pView_" + index;
       		var name = "#pName_" + index;
       		
       		var newFileList = Array.from(document.getElementById("input_file").files);
       		console.log("files : " + newFileList);
       		newFileList.splice(index, 1);
       		$(dimg_id).remove();
       		$(img_id).remove();
       		$(image).remove();
       		$(name).remove();
       		
       		$("#input_file").prop(newFileList);
       		
       		console.log(sel_files);
       	}
   		
   		function reloadPhotoList(fNo){
   			$.ajax({
   				url:"getPhotoList.do",
   				data:{fNo : fNo},
   				dataType:"json",
   				contentType:"application/json;charset=utf-8",
   				success:function(data){
   					$(".trView").remove();
   					$(".trViewName").remove();
   					for(var index in data.photoList){
   						
   						var trView = '<tr class="trView">';
   						var trViewName = '<tr class="trViewName">';
   						var str = '<td class="plistView" id="pView_'+index+'"><div id="photolistUpView" class="photoView">';
						var name = '<td class="plistName" id="pName_'+index+'">';
						
						str += '<a href=\"javascript:void(0);\" onclick=\"updateImageAction('+index+')\" id=\"img_id_'+index+'\"><img id="preview" class="photopreview" src="spring/resources/pUploadFiles/'+data.photoList[index].originName+'" title="" style="width: 100px; height: 100px;" /></a>';
						str += '</div></td>';
						
						name += data.photoList[index].originName + '<div class="dltImg"><a href=\"javascript:void(0);\" onclick=\"deleteImageAction('+index+')\" id=\"dimg_id_'+index+'\"><img class="previewDlt" src="${ contextPath }/resources/icons/close.png" style="width: 10px; height: 10px;" /></a>';
						name += '</div>' +'</td>';
						
						trView += '</tr>';
						trViewName += '</tr>';
						
						$("#undertd").before(trView);
						$("#undertd").before(trViewName);
						$(str).appendTo(trView);
						$(name).appendTo(trViewName);
   					}
   					console.log(data);
   				},error:function(){
   					console.log("전송실패");
   				}
   				
   			});
   			
   		}
   		
   		
   		
   		
   		
   		
   		
   		
	</script>
</body>
</html>