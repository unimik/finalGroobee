<%@page import="com.kh.spring.feed.model.vo.Feed"%>
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
    <link rel="stylesheet" href="${ contextPath }/resources/css/postInsertForm.css">
    <title>G R O O B E E</title>

</head>
<body>
    <div class="wapper">
        <c:import url="../common/menubar.jsp"/>
         <div class="search_userInfo">
                
            </div>
        <div class="content">
           
            <!--피드 영역 스크롤 필요해서 position 인라인으로 변경해둠-->
            <div id="feedArea">
            <form action="pInsert.do" method="post" id="postInsert" enctype="multipart/form-data">
                <!-- 전체 감싸는 div 영역 -->
                <div id="postingForm">
                <div id="postingArea">
                    <h4>새 피드 작성</h4>
                    <hr>
                    	<input type="hidden" name="fWriter" value="${ loginUser.userId }">
						<input type="hidden" name="mNo" value="${ loginUser.mNo }">
                        <table id="tbb">
                            <!--글 쓰는 영역-->
                            <tr>
                                <td>
                                    <textarea cols="60" rows="7" name="fContent"></textarea>
                                </td>    
                            </tr>
                            <!-- 파일 첨부 영역 -->
                            <tr class="tr">
                                <td>
                                    <img id="fileIcon" src="${ contextPath }/resources/icons/add_file.png">
                                </td>
                                <td class="filetb">
                                    <input type="file" multiple="multiple" id="input_file" class="input_file" name="upFile"
                                     accept="image/png, image/jpeg, image/JPEG, image/jpg, image/bmp, image/gif">
                                </td>
                                <td><!-- 파일 선택 폼 추가 -->
                                	<a href="javascript:void(0);" onclick="deleteFile()">
                                		<img id="deleteFile" src="${ contextPath }/resources/icons/delete_image.png">
                                		<p class="file_p">이미지 전체 삭제</p>
                                	</a>
                                </td>
                            </tr>
                            <!-- 파일 미리보기 영역 -->
                            <tr class="trView">
                            </tr>
                            <tr class="trViewName">
                            </tr>
                            <tr>
                                <td id="underLine"></td>
                            </tr>
                            <tr>
                                <td class="checkList tdfi">작성위치</td>
                                <td class="tdfi">
                                    <select id="select_board" name="selectLocation">
                                        <option value="M">내 피드</option>
                                        <option value="G">그룹 피드</option>
                                    </select>
                                </td>
                                <td>
                                    <select id="myGroupList" name="gNo">
                                    	<option value="0">그룹을 선택해 주세요.</option>
                                     	<c:forEach var="g" items="${ gn }">
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
                                    <select name="selectOpenScope">
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
                                        <li><input type="radio" name="like" id="" value="Y" checked><label for="like">허용</label></li>
                                        <li><input type="radio" name="like" id="" value="N"><label for="like">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr height="35px">
                                <td class="checkListse st">댓글</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="reply" id="" value="Y" checked><label for="reply">허용</label></li>
                                        <li><input type="radio" name="reply" id="" value="F"><label for="reply">친구만 허용</label></li>
                                        <li><input type="radio" name="reply" id="" value="N"><label for="reply">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr height="35px">
                                <td class="checkListse st">공유</td>
                                <td>
                                    <ul>
                                        <li><input type="radio" name="share" id="" value="Y" checked><label for="share">허용</label></li>
                                        <li><input type="radio" name="share" id="" value="N"><label for="share">금지</label></li>
                                    </ul>
                                </td>
                            </tr>
                        </table>
                    </div>
					<div id="btnstd">
						<button id="btns1">
							<a id="page_back" href="javascript:history.go(-1)">이전</a>
						</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="btns2" type="submit" value="작성">
					</div>
    				</div>
                    </form>
                    </div>
                </div>
            </div>

    
    <script>
    	
        $(document).ready(function(){
        	$("#btns1").click(function(){
        		history.go(-1);
        	});
        	
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
                
                if(state == 'G'){
                    $('#myGroupList').css("display","block");
                } else{
                    $('#myGroupList').hide();
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
        $('#btns2').on('click', function () {
        /***** 글 작성 시 0바이트일 경우(글 작성 안 했을 경우) *****/
            var text = $('textarea').val();
            
            if(text == "") {
            	alert('작성된 내용이 없습니다.\n내용을 작성해 주세요.');
            	return false;
            }
            
            if(text != "") {
        		var postConfirm = confirm('글을 작성하시겠습니까?');        		
        		/***** 취소 누르면 작성되지 않게 *****/
        		if(postConfirm == false) {
        			return false;
        		}else{
		            var tarr = text.split(" ");
		        		for(var i =0; i < tarr.length;i++){
		        			if(tarr[i].charAt(0)=='@'){
		        				var mid = tarr[i].substr(1);;
		        				$.ajax({
		                			url:'findMember.do',
		        					data:{ 
		        						mid:mid
		        					},success: function(data){
		        							sendAlram("상관없음",data[1],"tag",data[0]);		        							
		        					},error:function(){
		        						
		        					}
		                			
		                		});
		        		}
		            }
        			
        		}
	        }
            
        
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
        
        
    	/***************** 이미지 미리보기 *****************/
    	
    	var sel_files= [];
    	
    	$(document).ready(function(e) {
    		$('.input_file').change(
    			function(e) {
    				
    				var files = e.target.files;
    				var arr = Array.prototype.slice.call(files);
					
    				var checkPhotopreview = $(".photopreview").length;

    				// 업로드 시에 이미지가 5개를 초과하면 alert창 띄우기
    				if((files.length + checkPhotopreview) > 5) {
   						alert('첨부 가능한 이미지 갯수는 5개를 초과할 수 없습니다.')
   						$('.input_file').val(""); // 파일 초기화
   						reloadPhotoList(chk);
   						return false;
   					}
    				
    				// 파일 업로드가 0개인 인서트/업데이트 피드에 파일 업로드할 경우 미리보기 추가
    				if(checkPhotopreview < 1) {
    					var trView = '<tr class="trView">';
   						var trViewName = '<tr class="trViewName">';
						$("#undertd").before(trView);
						$("#undertd").before(trViewName);
						preview(arr);
    					return true;
    					
    				}
    				
    				// 업로드 가능 파일인지 체크
    				for (var i = 0; i < files.length; i++) {
    					if (!checkExtension(files[i].name, files[i].size)) {
    						return false;
    					}	
    				}

    				preview(arr);

    			}); // file change

    		function checkExtension(fileName, fileSize) {

    			var regex = new RegExp("(.*?)\.(bmp|gif|png|jpg|jpeg)$");
    			var maxSize = 20971520; // 20MB

    			if(fileSize >= maxSize) {
    				alert('파일 사이즈를 초과하였습니다.');
    				$('.input_file').val(""); // 파일 초기화
    				
    				return false;
    			}

    			if(!regex.test(fileName)) {
    				alert('이미지 확장자만 업로드 가능합니다.');
    				$('.input_file').val(""); // 파일 초기화
    				return false;
    			}
    			
    			return true;
    		}

    		function preview(arr) {
    			var index = 0;
    			
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
    						var str = '<td class="plistView" id="pView"><div id="photolistUpView" class="photoView">';
    						var name = '<td class="plistName" id="pName">';
    						
    						str += '<a href=\"javascript:void(0);\" id=\"img_id\"><img id="preview" class="photopreview" src="'+e.target.result+'" title="'+fUp.name+'" style="width: 100px; height: 100px;" /></a>';
    						str += '</div></td>';
    						$(str).appendTo('.trView');
    						
    						name += fileName + '</div></td>';
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
    		
   		// 이미지 전체 삭제 클릭 시 삭제 이벤트 핸들러
       	function deleteFile() {
   			
	        var newFileList = Array.from(document.getElementById("input_file").files);
	        
	        if(newFileList.length == 0) {
	        	alert('삭제할 이미지 파일이 없습니다.');
	        }else {
	        
   			var deleteConfirm = confirm('첨부한 이미지를 전체 삭제하시겠습니까?\n※ 이미지는 부분 삭제를 할 수 없습니다.');
   			
   			if(deleteConfirm) {
				
        		if(deleteConfirm == false) {
        			return false;
        		}
        		
	       		var dimg_id = "#dimg_id";
	       		var img_id = "#img_id";
	       		var image = "#pView";
	       		var name = "#pName";
	       		
	       		console.log("files : " + newFileList);
	       		
	       		var ie = navigator.userAgent.indexOf("MSIE") >-1 || navigator.userAgent.indexOf("Trident") >-1
				
	       		for(i = 0; i < newFileList.length; i++) {
		       		$(dimg_id).remove();
		       		$(img_id).remove();
		       		$(image).remove();
		       		$(name).remove();
		       		console.log(sel_files);
	       		}
	       		
	       		if (/(MSIE|Trident)/.test(navigator.userAgent)) {
	       			// ie 일때 input[type=file] init.
	       			$("#input_file").replaceWith( $("#input_file").clone(true) );
	       		}else {
	       			// other browser 일때 input[type=file] init.
	       			$("#input_file").val("");
	       		}

   			}
       		}
   		}
   		
        function changeValue(obj){
	        // 파일 선택창을 띄웠다가 취소 시 선택값이 모두 사라질 경우 기존에 추가되었던 미리보기 사진도 모두 삭제
       		if(obj.value === '') {
				$(".plistView").remove();
  				$(".plistName").remove();
       		}
        }
        
    </script>
</body>
</html>