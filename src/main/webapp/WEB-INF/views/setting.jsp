<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.spring.setting.model.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<Member> blist = (ArrayList<Member>)request.getAttribute("bList");
	Member m = (Member)session.getAttribute("loginUser");
	String blocked = (String)request.getAttribute("blocked");
	
   
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">	
    <link rel="stylesheet" href="resources/css/common.css">
    <link rel="stylesheet" href="resources/css/setting.css">
    <link rel="stylesheet" href="resources/css/chat.css">
    <link rel="stylesheet" href="resources/css/myAccount.css">
    <title>G R O O B E E</title>
    <style>
    	.disblock,.block{float:right; color:black; background:#a3d4ff; border:none; border-radius:5px;font-size: 14px;padding: 3px;}
    	.closemodal{position: fixed;bottom: 685px;left: 820px;width: 50px;font-size: 20px; border: none;background: none;color: white;cursor:pointer;}
    </style>
</head>
<body>
    <div class="wapper">
    <c:import url="common/menubar.jsp"/>
      
            <div id="settingArea">
                <div class="setting" id="notification-setting">
                    <div id="setting-all">
                        <table style="margin: 0;">
                            <tr>
                                <th class="setMenu notification">알림</th>
                                <th class="setMenu privarcy" style="color: lightgray;">개인정보 및 보안</th>
                                <th class="setMenu info" style="color: lightgray;">정보</th>
                            </tr>
                        </table>
                        <table>    
                            <tr>
                                <th class="settings">전체알림</th>
                            </tr>
                            <c:if test="${ns.aAll eq 'Y' }"> 
	                            <tr>
	                                <td><input type="radio" name="notification-all" class="all" id="set" checked value="Y"> 설정 <input type="radio" name="notification-all" class="all" id="nonset" value="N"> 해제</td>                            
	                            </tr>
                            </c:if>
                            <c:if test="${ns.aAll eq 'N' }">
	                            <tr>
	                                <td><input type="radio" name="notification-all" class="all" id="set" value="Y"> 설정 <input type="radio" name="notification-all" class="all" id="nonset" value="N" checked> 해제</td>                            
	                            </tr>
                            </c:if>
                        </table>
                    </div>
                    <div id="setting-detail">
                        <table>
                            <tr><td><div class="line"></div></td></tr>
                            <tr>
                                <th class="settings others" >좋아요</th>
                            </tr>

                            <tr><td class="others"><input class="others" type="radio" name="notification-like" id="" value="Y" checked>전체 알림</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-like" id="" value="N" >알림 해제</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-like" id="" value="F">친구만 알림</td></tr>
                            
                            <tr><td><div class="line"></div></td></tr>
                            <tr>
                                <th class="settings others">댓글</th>
                            </tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Comment" id="" value="Y" checked>전체 알림</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Comment" id="" value="N">알림 해제</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Comment" id="" value="F">친구만 알림</td></tr>
                            <tr><td><div class="line"></div></td></tr>
                            <tr>
                                <th class="settings others">댓글 좋아요</th>
                            </tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-CommentLike" id="" value="Y" checked>전체 알림</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-CommentLike" id="" value="N">알림 해제</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-CommentLike" id="" value="F">친구만 알림</td></tr>
                            <tr><td><div class="line"></div></td></tr>
                            <tr>
                                <th class="settings others">친구추가</th>
                            </tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Addfollow" id="" value="Y" checked>설정</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Addfollow" id="" value="N">해제</td></tr>
                            
                            <tr><td><div class="line"></div></td></tr>
                            <tr>
                            <th class="settings others">메시지</th>
                            </tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Message" id="" value="Y" checked>설정</td></tr>
                            <tr><td class="others"><input class="others" type="radio" name="notification-Message" id="" value="N">해제</td></tr>
                        </table>
                    </div>   
                </div>
                <div class="setting" id="privarcy-setting">
                    <table>
                        <tr>
                            <th class="setMenu notification" style="color: lightgray;">알림</th>
                            <th class="setMenu privarcy">개인정보 및 보안</th>
                            <th class="setMenu info" style="color: lightgray;">정보</th>
                        </tr>
                    </table>
                    <table style="margin-left: 20px;">
                        <tr>
                            <th class="settings">공개범위</th>
                        </tr>
                        <tr><td><input type="radio" name="personal-openstatus" id="" value="Y" checked>전체 공개</td></tr>
                        <tr><td><input type="radio" name="personal-openstatus" id="" value="F">친구만 공개</td></tr>
                        <tr><td><div class="line"></div></td></tr>
                        <tr>
                            <th class="settings" id="blocked-accounts"><a href="#" style="text-decoration: none; color:black">차단된 계정</a></th>
                        </tr>
                        <tr>
                            <td>
                                <div id="blockedList">
                                    <div style="height: 10px;"></div>
                                    <!-- 여기에 DB에서 가져온 리스트 출력-->
                                   <%if(!blist.isEmpty()){ %>
                                    <% for (Member b : blist) { %>
                                     <img src="resources/images/<%= b.getmImage() %>" alt=""> <span><%= b.getUserId() %></span> 
                                     <button class="disblock" id="<%= b.getUserId() %>" value="<%= b.getmNo() %>">차단해제</button>
                                     <button class="block" id="<%= b.getUserId() %>1" style="display:none;"value="<%= b.getmNo() %>" >차단 </button><br>
                                    
                                    <%} %>
                                     
                                    <%}else{ %>
                                    <div style="height: 10px; font-size:14px; float:right; margin-right:30px; color:darkgray;" >아직 차단된 계정이 없습니다.</div>
                                    <%} %>
                                    <div style="height: 10px;"></div>
                                    <input type="hidden" id="blocked" value="<%= blocked %>">

                                </div>
                                <div id="test" style="height: 0; overflow: hidden; display: none;">
                                    <img src="resources/images/IMG_7460.JPG" alt=""> user01<br>
                                    <img src="resources/images/IMG_7460.JPG" alt=""> user01<br>
                                    <img src="resources/images/IMG_7460.JPG" alt=""> user01<br>

                                </div>
                            </td>
                        </tr>
                       
                        <tr><td><div class="line"></div></td></tr>
                        <tr>
                            <th class="settings">비밀번호 저장</th>
                        </tr>
                        <tr><td><input type="radio" name="personal-savedpwd" id="" value="Y">설정</td></tr>
                        <tr><td><input type="radio" name="personal-savedpwd" id="" value="N" checked>해제</td></tr>
                        <tr><td><div class="line"></div></td></tr>
                        <tr>
                            <th class="settings">계정 관리</th>
                        </tr>
                        <tr><td><a href="#" id="disable_btn">계정 비활성화</a></td></tr>
                        <tr><td id="modal_opne_btn" ><a href="#" style="text-decoration: none; color:red;">계정삭제</a></td></tr>
                    </table>
                </div>
                <div class="setting" id="info-setting">
                    <table>
                        <tr>
                            <th class="setMenu notification" style="color: lightgray;">알림</th>
                            <th class="setMenu privarcy" style="color: lightgray;">개인정보 및 보안</th>
                            <th class="setMenu info">정보</th>
                        </tr>
                    </table>
                    <div>
                        <table id="info-menu" >
                            <tr><th class="selected" id="question" style="border-color: black;"><a href="#" onclick="showquestion();">&nbsp;문의사항</a></th></tr>
                            <tr><th class="selected" id="help"><a href="#" onclick="showHelp();">&nbsp;도움말</a></th></tr>
                            <tr><th class="selected" id="about"><a href="#" onclick="showAbout(); ">&nbsp;이용약관</a></th></tr>
                        </table>
                        <table class="question" style="padding-left: 20px;">        
                          
                            <tr><th class="settings">문의사항</th></tr>
                            <tr><td><div class="line3"></div></td></tr>
                            <tr><td>
                                <div>
                                    <p>서비스 이용에 불편한 사항이 있거나<br> 발견된 문제가 있다면 이곳에 작성해주세요.</p>
                                    <textarea id="question-area" cols="62" rows="8" style="resize: none;   "></textarea><br>
                                    <input id="question-btn" type="button" value="작성완료">
                                

                                </div>
                            </td></tr>
                        </table>
                        <table class="help" style="padding-left: 20px; display: none;">    
                            <tr><th class="settings">도움말</th></tr>
                            <tr><td><div class="line3"></div></td></tr>
                            <tr><td>
                                <div style="padding: 10px;">
                                    <h5>서비스 개선</h5>
                                    <ol>
                                        <li>친구가 아닌사람 채팅차단기능 추가 </li>
                                        <li>그룹장 위임기능 추가</li>
                                        <li>보관함 기능 추가</li>
                                    </ol>
                                    <h5>현재 사이트의 문제</h5>
                                    <p id="info_groobee">
                                        현재 사이트의 문제를 찾을 수 없습니다.<br>
                                        문제가 있으시다면 <a href="#"  onclick="showquestion();" style="text-decoration: none; color: #47c6a3;"> 문의사항 </a>에 남겨주세요.
                                    </p>
                                </div>
                            </td></tr>
                        </table>
                        <table class="about" style="padding-left: 20px; display: none;">   
                            <tr><th class="settings">이용약관</th></tr>
                            <tr><td><div class="line3"></div></td></tr>
                            <tr><td>
                                <div style="padding: 10px;">
                                    <p>groobee에 오신 것을 환영합니다!<br><br>
                                        
                                        본 약관은 회원님의 groobee 이용에 적용되며, 아래 설명된 groobee 서비스에 관한 정보를 제공합니다. 회원님이 groobee 계정을 만들거나 groobee을 이용하면 회원님은 본 약관에 동의하는 것입니다.<br><br>
                                        
                                        groobee 서비스<br>
                                        당사는 회원님에게 groobee 서비스를 제공하는 것에 동의합니다. 서비스에는 당사가 groobee의 사명을 실현하기 위해 제공하는 모든 groobee 제품, 기능, 앱, 서비스, 기술 및 소프트웨어가 포함됩니다. 회원님이 관심 있는 사람들과 항목을 더 가까이 접할 수 있도록 서비스는 다음과 같은 요소(서비스)로 구성됩니다.
                                        <br><br> - 창작, 연결, 커뮤니케이션, 발견 및 공유를 위한 맞춤화된 기회를 제공합니다.
                                        <br><br> - 사람들은 다양합니다. 당사는 회원님이 실제로 관심을 가지는 경험을 공유함으로써 관계를 강화하길 원합니다. 따라서 당사는 회원님 및 다른 사람들이 관심 있는 사람과 사항을 파악하는 시스템을 구축하고 파악한 정보를 이용함으로써 회원님에게 중요한 경험을 창작하고, 발견하며, 동참하고, 공유하도록 합니다. 그 일환으로, 회원님 및 다른 사람들이 groobee 안팎에서 하는 활동에 기초하여 회원님이 관심을 가질 만한 콘텐츠, 기능, 제안 및 계정을 더 잘 보여드리고, 회원님에게 groobee을 경험하는 방법을 제안하기도 합니다. 
                                        <br><br> - 긍정적이고 포괄적이며 안전한 환경을 조성합니다.
                                        <br><br> - 당사는 groobee 커뮤니티 회원들이 도움을 필요로 한다고 생각하는 경우를 포함하여 회원들의 경험이 긍정적이고 포괄적일 수 있도록 도구를 개발하고 사용하고, 자원을 제공합니다. 또한 당사는 groobee 약관 및 정책의 남용 및 위반을 포함하여 유해하고 사기적인 행위를 방지하기 위한 팀과 시스템을 갖추고 있습니다. 당사는 groobee 플랫폼의 보안을 유지하기 위해 당사가 보유한 모든 정보(회원님의 정보 포함)를 이용합니다. 또한 당사는 오용 또는 유해 콘텐츠에 관한 정보를 법 집행 기관과 공유할 수 있습니다. 
                                        <br><br> - 성장하고 있는 groobee 커뮤니티에 지속적으로 서비스를 제공하는 데 도움이 되는 기술을 개발하고 사용합니다.
                                        <br><br> - 성장하고 있는 groobee 커뮤니티를 위해 정보를 구성하고 분석하는 것이 groobee 서비스의 핵심입니다. groobee 서비스에서 큰 부분을 차지하는 것은 광범위한 글로벌 커뮤니티를 위하여 엄청나게 큰 규모로 groobee 서비스를 맞춤화하고, 보호하며, 향상시키는 데 도움이 되는 첨단 기술을 개발하고 사용하는 것입니다. 
                                        <br><br> - groobee 서비스를 위해 안정적인 글로벌 인프라를 보장합니다.
                                        <br><br> - 글로벌 서비스를 제공하기 위해 당사는 회원님의 거주 국가 이외의 지역을 비롯하여 전 세계에 있는 시스템에 데이터를 저장하고 전송해야 합니다.
                                        <br><br> - 회원님이 관심 있는 방식으로 회원님과 브랜드, 제품 및 서비스를 연결합니다.
                                        <br><br> - 당사는 회원님에게 의미 있다고 생각되는 광고, 제안 및 기타 홍보 콘텐츠를 보여드리기 위해 groobee 및 다른 제3자의 정보를 이용합니다. 그리고 이러한 콘텐츠가 회원님이 groobee에서 경험하는 다른 모든 경험과 마찬가지로 관련성 있도록 노력합니다. 
                                        <br><br> - 연구 및 혁신.
                                        <br><br> - 당사는 보유한 정보를 이용하여 groobee 서비스를 연구하고, 다른 사람들과 협력하여 보다 나은 groobee 서비스를 만들고 groobee 커뮤니티의 복지에 기여하기 위한 연구를 수행합니다. 
                                        
                                        데이터 정책
                                        groobee 서비스를 제공하기 위해서는 회원님의 정보를 수집하고 이용해야 합니다. 데이터 정책은 제품에서 당사가 정보를 수집, 이용하고 공유하는 방법에 대해 설명합니다. 또한 groobee 개인정보 보호 및 보안 설정을 포함해 회원님의 정보를 관리할 수 있는 여러 방법에 대해 설명합니다. groobee을 이용하려면 데이터 정책에 동의해야 합니다.
                                        
                                        회원님의 약속
                                        groobee 서비스 제공에 대한 당사의 약속에 대해 회원님은 다음과 같은 약속을 해야 합니다.
                                        
                                        groobee을 이용할 수 있는 주체. 당사는 groobee 서비스가 가능한 개방적이고 포괄적인 서비스가 되기를 원하지만, 본 서비스가 안전하고, 보안성을 갖추며, 법을 준수하는 서비스가 되기를 원하기도 합니다. 따라서 회원님이 groobee 커뮤니티에 참여하려면 몇 가지 제한 사항을 준수해야 합니다.
                                        <br><br> - 만 14세 이상이어야 합니다. 
                                        <br><br> - 관련 법률에 따라 groobee 서비스를 받는 것이 일부라도 금지된 사람 또는 관련 제재 대상 명단에 있어 결제 관련 groobee 서비스를 이용하는 것이 금지된 사람이 아니어야 합니다. 
                                        <br><br> - 과거에 당사가 회원님의 계정을 법률 또는 groobee 정책 위반을 이유로 하여 비활성화하지 않았어야 합니다. 
                                        <br><br> - 유죄가 확정된 성범죄자가 아니어야 합니다. 
                                        
                                        groobee을 사용할 수 없는 경우. 광범위한 커뮤니티에 안전하고 개방적인 groobee 서비스가 제공되기 위해서는 우리가 모두 각자의 본분을 다해야 합니다.
                                        <br><br> - 다른 사람을 사칭하거나 부정확한 정보를 제공하면 안 됩니다.
                                        <br><br> - groobee에서 회원님의 신원을 공개할 필요는 없지만 정확한 최신 정보(등록 정보 포함)를 제공해야 합니다. 또한 본인이 아닌 다른 사람을 사칭해서는 안 되며, 다른 사람의 명시적인 허락 없이 다른 사람의 이름으로 계정을 만들면 안 됩니다. 
                                        <br><br> - 불법적이거나, 오해의 소지가 있거나, 사기적인 행위 또는 불법적이거나 허가받지 않은 목적을 위한 어떠한 행위도 하면 안 됩니다. 
                                        <br><br> - 특히 groobee 커뮤니티 가이드라인, groobee 플랫폼 정책, 음악 가이드라인을 포함하여 본 약관 또는 당사 정책을 위반하거나 다른 사람들이 위반하도록 돕거나 조장해서는 안 됩니다. 이를 어길 시 다른 사용자가 행위 또는 콘텐츠를 신고할 수 있습니다. 
                                        <br><br> - groobee 서비스의 정상적인 운영을 방해하거나 지장을 주는 어떠한 일도 해서는 안 됩니다. 
                                        <br><br> - 허가받지 않은 방법으로 계정을 만들거나 정보에 접근하거나 정보를 수집하려 해서는 안 됩니다.
                                        <br><br> - 여기에는 당사의 명시적 허락 없이 자동화된 방법으로 계정을 만들거나 정보를 수집하는 것이 포함됩니다. 
                                        <br><br> - 회원님의 계정 일부(사용자 이름 포함)를 구입, 판매 또는 양도하거나, 다른 사용자의 로그인 정보 또는 배지를 요청, 수집 또는 사용하려고 시도해서는 안 됩니다. 
                                        <br><br> - 개인 정보 또는 기밀 정보를 게시하거나 지적 재산을 포함한 타인의 권리를 침해하는 어떠한 행위도 해서는 안 됩니다.
                                        
                                        지적 재산권 정보
                                        <br><br> - 	 
                                        <br><br> - 당사의 사전 서면 동의 없이 회원님의 사용자 이름에 도메인 이름이나 URL을 사용하면 안 됩니다.회원님이 당사에 부여한 권한. 본 계약의 일부로서, 회원님은 당사가 회원님에게 서비스를 제공하기 위해 필요로 하는 권한을 함께 부여합니다.
                                        <br><br> - 당사는 회원님의 콘텐츠에 대한 소유권을 주장하지 않지만 회원님은 당사에 회원님의 콘텐츠를 이용할 라이선스를 부여합니다.
                                        
                                        <br><br> - 회원님의 콘텐츠에 대한 회원님의 권리에 있어 변경되는 사항은 없습니다. 당사는 회원님이 서비스에 또는 서비스를 통해 게시하는 콘텐츠에 대해 소유권을 주장하지 않습니다. 그 대신 회원님이 지적 재산권(사진 또는 동영상 등)이 적용되는 콘텐츠 또는 당사 서비스와 관련된 콘텐츠를 공유, 게시 또는 업로드할 때 회원님은 콘텐츠를 전 세계적으로 호스팅, 사용, 배포, 수정, 실행, 복사, 공개적으로 수행 또는 표시, 번역 및 파생 저작물을 생성할 수 있는 비독점적이고 양도 가능하며 2차 라이선스를 가질 수 있고 사용료가 없는 라이선스를 당사에 부여합니다(회원님의 개인정보 취급방침 및 애플리케이션 설정과 일치함). 이러한 라이선스는 groobee 서비스에 접속하고 이를 이용하는 회원님 및 다른 사람들에게 groobee 서비스 이용을 가능하게 하기 위한 것입니다. 콘텐츠 또는 계정을 삭제하여 언제든지 이러한 라이선스를 종료할 수 있습니다. 단, 회원님의 콘텐츠를 공유한 타인이 해당 콘텐츠를 삭제하지 않았을 경우에는 해당 콘텐츠가 계속 보일 수 있습니다. 
                                        <br><br> - 회원님의 사용자 이름, 프로필 사진 및 회원님의 관계 및 행동에 관한 정보를 계정, 광고 및 홍보 콘텐츠에 이용할 수 있는 권한.
                                        <br><br> - 회원님은 당사에 회원님의 사용자 이름, 프로필 사진 및 회원님의 활동(예: "좋아요") 또는 관계(예: "팔로우")에 관한 정보를 Facebook 제품 전반에 표시되는 계정, 광고, 제안 및 회원님이 팔로우하거나 참여하는 기타 홍보 콘텐츠와 함께 또는 이와 관련하여 표시할 수 있는 권한을 무상으로 부여합니다. 예를 들어, 당사는 회원님이 groobee에 유료로 광고를 게재하는 브랜드의 홍보 게시물을 좋아했다는 점을 표시할 수 있습니다. 다른 콘텐츠에서의 행동 및 다른 계정의 팔로우와 마찬가지로, 홍보 콘텐츠에서의 행동 및 홍보 계정의 팔로우도 해당 콘텐츠나 팔로우를 볼 수 있는 권한이 있는 사람들에게만 표시됩니다. 당사는 회원님의 광고 설정도 존중합니다.
                                        
                                        <br><br> - 회원님은 당사가 회원님의 기기에 groobee 서비스 업데이트를 다운로드하고 설치할 수 있다는 것에 동의합니다. 
                                        
                                        당사가 보유하는 추가적인 권리
                                        <br><br> - 회원님의 계정을 위해 사용자 이름 또는 이와 유사한 식별자를 선정할 경우, 당사는 적절하거나 필요하다고 판단될 경우 이를 변경할 수 있습니다(예: 타인의 지적 재산권을 침해하거나 다른 사용자를 사칭하는 경우 
                                        <br><br> - 당사가 소유하고 groobee 서비스 내에서 사용하도록 한 지적 재산권의 적용을 받는 콘텐츠(예: 당사로부터 받아 회원님이 생성하거나 공유하는 콘텐츠에 추가되는 사진, 디자인, 동영상 또는 사운드)를 회원님이 사용하는 경우, 당사는 해당 콘텐츠에 대해 모든 권리를 보유하되 회원님 고유의 콘텐츠에 대한 권리를 보유하지는 않습니다. 
                                        <br><br> - 회원님은 당사의 브랜드 가이드라인이나 사전 서면 허락을 통해 명백하게 허락을 받은 경우에만 당사의 지적 재산권 및 상표 또는 비슷한 상표를 사용할 수 있습니다. 
                                        <br><br> - 회원님이 당사의 소스코드를 수정하거나, 소스코드에 대한 파생물을 제작하거나, 소스코드를 역컴파일하거나 기타 방법으로 소스코드 추출을 시도하기 위해서는 당사의 서면 허락 또는 오픈 소스 라이선스에 의거한 허락을 받아야 합니다. 
                                        
                                        콘텐츠 삭제 및 계정 비활성화 또는 해지
                                        <br><br> - 회원님이 서비스에서 공유하는 콘텐츠나 정보가 본 약관, 당사 정책에 위배된다고 판단되거나 법에 따라 삭제해야 할 경우 삭제될 수 있습니다. 당사는 groobee 커뮤니티 또는 groobee 서비스를 보호하기 위해 또는 회원님이 당사에 위험 또는 법적 문제를 일으키거나, 본 약관 또는 groobee 정책을 위반하거나, 다른 사람의 지적 재산권을 반복적으로 침해하거나, 법률에 따라 요구되거나 허용되는 경우에 회원님에게 서비스 전부 또는 일부를 제공하는 것을 즉시 중단하거나 거부할 수 있습니다(회원님의 계정 해지 또는 비활성화 포함). 당사가 회원님의 계정을 비활성화하거나 해지하는 조치를 취할 경우 적절할 때 회원님에게 알려드릴 것입니다. 회원님의 계정이 실수로 해지되었다고 생각되는 경우 또는 회원님의 계정을 비활성화하거나 영구 삭제하고 싶은 경우에는 당사 고객 센터로 문의하세요. 
                                        <br><br> - 삭제된 콘텐츠는 합리적인 기간(일반적으로 90일)에 백업 사본으로 존속될 수 있지만 이 기간에 다른 사용자에게 표시되지 않습니다. 단, 이에도 불구하고, 관련 법령, 정부 기관 또는 사법기관의 명령 등에 의하여 요구되는 경우, Facebook은 이를 위하여 필요한 범위 내에서 해당 콘텐츠를 보유할 수 있습니다. 회원님이 삭제한 콘텐츠도 다른 사람이 이미 공유했을 경우 계속 표시됩니다. 이 절과 아래의 "계약 및 동의하지 않을 경우의 결과" 항은 회원님의 계정이 해지 또는 종료된 이후에도 계속 적용됩니다. 
                                        
                                        계약 및 상호 의견이 합치되지 않는 경우
                                        계약.
                                        <br><br> - 서비스 음악 사용 역시 당사의 뮤직 가이드라인이 적용되며, 당사 API 사용에는 당사의 플랫폼 정책이 적용됩니다. 회원님이 기타 특정 기능 또는 관련 서비스를 이용하는 경우, 추가 약관에 대해 동의할 기회를 제공할 것이며 추가 약관은 당사와 회원님 간의 합의 일부를 구성합니다. 예를 들어, 결제 기능을 사용할 경우 커뮤니티 결제 약관에 동의해야 합니다. 추가 약관 조항 중 일부가 본 계약과 상충될 경우 추가 약관이 우선합니다. 
                                        <br><br> - 본 계약의 일부가 이행 불가능한 것으로 판단되더라도 나머지 부분은 계속해서 효력을 갖습니다. 
                                        <br><br> - 본 계약의 개정이나 포기는 당사가 작성하고 서명한 서면으로만 가능합니다. 본 계약의 한 부분을 이행하지 못하더라도 포기로 간주되지는 않습니다. 
                                        <br><br> - 당사는 회원님에게 명시적으로 부여된 권한을 제외한 모든 권한을 보유합니다. 
                                        본 계약에 따른 권리 보유자.
                                        <br><br> - 본 계약은 제삼자에게 권리를 부여하지 않습니다. 
                                        <br><br> - 본 계약에 따른 회원님의 권리나 의무는 당사의 동의 없이 타인에게 양도할 수 없습니다. 
                                        <br><br> - 당사의 권리와 의무는 타인에게 양도될 수 있습니다. 이러한 양도는 예를 들어 (인수합병이나 자산매각으로 인해) 당사의 소유권이 변경되는 경우 또는 법률에 의해 이뤄질 수 있습니다. 
                                        일이 발생할 경우의 책임자.
                                        <br><br> - 당사 서비스는 "있는 그대로" 제공되며, 당사는 서비스가 안전하고 확실하게 제공되거나 항상 완벽하게 작동한다고 보장할 수 없습니다. 관련 법률이 허용하는 한도 내에서 당사는 또한 상업성, 특정 목적을 위한 적합성, 권한 및 비침해성에 대한 묵시적 보증을 포함하되 이에 제한되지 않고 명시적이거나 묵시적인 어떠한 보증도 하지 않습니다. 
                                        <br><br> - 또한 당사는 사람들의 활동이나 말을 통제하지 않으며, 사람들(또는 회원님)의 활동이나 행동(온라인 또는 오프라인) 또는 콘텐츠(불법 또는 유해 콘텐츠 포함)에 대해 책임지지 않습니다. 또한 당사는 다른 사람이나 기업에서 제공하는 서비스와 기능에 대해서도 책임지지 않습니다. 회원님이 당사 서비스를 통해 이러한 서비스와 기능에 접속하더라도 마찬가지입니다. 
                                        <br><br> - groobee 서비스에서 발생하는 모든 사항에 대한 당사의 책임은 법률이 허용하는 최대한도로 제한됩니다. groobee 서비스에 문제가 있는 경우, 당사는 해당 문제가 끼칠 수 있는 모든 가능한 영향을 알 수 없습니다. 회원님은 본 약관으로부터 또는 본 약관과 관련하여 발생하는 수익, 수입, 정보 또는 데이터의 손실이나 파생적, 특수적, 간접적, 처벌적, 징벌적 또는 부수적 손해의 가능성을 알고 있더라도 이에 대해 책임지지 않는다는 것에 동의합니다. 여기에는 당사가 회원님의 콘텐츠, 정보 또는 계정을 삭제할 때도 포함됩니다. 
                                        <br><br> - 단, 이에도 불구하고, 관련 법률에 따라서는 위에 규정된 책임에 대한 제한이나 면제가 허용되지 않을 수 있습니다. 이 경우, Facebook은 해당 법률이 규정하고 있는 범위 내에서 책임을 부담합니다. 
                                        요청하지 않은 자료.
                                        당사는 의견 및 제안을 언제든 환영하지만, 이를 어떠한 제한 또는 보상 의무 없이 활용할 수 있고, 이를 기밀로 유지할 의무가 없습니다.
                                        
                                        본 약관 업데이트
                                        당사는 groobee 서비스 및 정책을 변경할 수 있고, groobee 서비스 및 정책이 정확하게 반영되도록 하기 위해 본 약관을 변경해야 할 경우가 있습니다. 법적으로 달리 요구되지 않는 한 당사는 본 약관을 변경하기 전에 회원님에게 알리고, 변경된 약관의 효력이 발생되기 최소 30일 전에 회원님에게 이를 검토할 기회를 제공합니다. 변경 발효일 이후에도 회원님이 계속 groobee 서비스를 이용하실 경우, 회원님은 변경된 약관의 적용을 받게 됩니다. 본 약관 또는 업데이트된 약관에 동의하지 않을 경우에는 여기서 회원님의 계정을 삭제하면 됩니다.
                                        개정: 2020년 9월 28일</p>
                                </div>
                            </td></tr>
                        </table>
                    </div>
                </div>
                <div style="text-align: right; color: lightgray;">Copyright © 2020 groobee from Dahangejyo</div>
                 <div style="height: 200px; display: inline-block;color: #fcfcfc;">
                    -<br>-<br>-<br>-<br>-<br>
                </div> 
            </div>
            
        </div>
        
    </div>
   		<input type="hidden" name="userpwd" value="<%= m.getUserPwd() %>"> 
    <div class="modal" id="disable_modal">
       
        <div class="modal_content">
            <h3 align="center">계정 비활성화</h3>
            <hr>
           
            <p align="center">계정을 비활성화를 위한 본인 확인을 위해 비밀번호를 입력해 주세요.</p>
            <label>비밀번호 : </label> <input type="password" name="pwdchk" id="pwdchk">
            <button type="button" id="disableAccount">확인</button>
            <!-- 로그아웃 후 로그인 페이지로 보내기-->
           
        </div>
       <input type="button" class="closemodal" value="x">
        <div class="modal_layer"></div>
    </div>
    
    <div class="modal" id="pwdchk_modal">
       
        <div class="modal_content">
            <h3 align="center" float="left">계정삭제</h3>
            <hr>
           
            <p align="center">계정을 삭제를 위한 본인 확인을 위해 비밀번호를 입력해 주세요.</p>
            <label>비밀번호 : </label> <input type="password" name="pwdchk2" id="pwdchk2">
            <button type="button" id="pwdchk_btn">확인</button>
           
        </div>
       <input type="button" class="closemodal" value="x">
        <div class="modal_layer"></div>
    </div>

    <div class="modal" id="delete_modal">
       
        <div class="modal_content">
            <h3 align="center">정말로 계정을 삭제 하시겠습니까?</h3>
            <hr>
           
            <p align="center">계정을 삭제하시면 30일동안 같은 이메일로 다시 회원가입 할 수 없습니다. 계정을 삭제하시려면 “삭제” 버튼을 를 눌러주세요</p>
       
            <button type="button" id="delete_account">삭제</button>
            <button type="button" id="cancel">취소</button>
           
        </div>
       <input type="button" class="closemodal" value="x">
        <div class="modal_layer"></div>
    </div>
   
    <script>
        $(document).ready(function(){
                      
           
                if(document.getElementById('set').checked == true){
                    $("#setting-detail").css("background","none");
                    $(".others").attr('disabled',false);
                    $(".others").css("color","black");
                    

                }else if(document.getElementById('nonset').checked == true){
                    $("#setting-detail").css("background","lightgray");
                    $(".others").attr('disabled',true);
                    $(".others").css("color","#5a5a5a");
                    
                }
           
        });

      

        // 정보 메뉴선택시 효과 설정
        $('.notification').on('click',function(){
            $('#notification-setting').show();
            $('#privarcy-setting').hide();
            $('#info-setting').hide();
            
            $('.notification').css({'border-color':'#fcfcfc'});
            $('.privarcy').css({'border-color':'lightgray'});
            $('.info').css({'border-color':'lightgray'});
            $('.info').css("border-left",'none');
        });

        $('.privarcy').on('click',function(){
            $('#notification-setting').hide();
            $('#privarcy-setting').show();
            $('#info-setting').hide();

            $('.notification').css({'border-color':'lightgray'});
            $('.privarcy').css({'border-color':'#fcfcfc'});
            $('.info').css({'border-color':'lightgray'});
            $('.notification').css("border-right",'1px solid lightgray');
            $('.info').css("border-left",'1px solid lightgray');
        });

        $('.info').on('click',function(){
            $('#notification-setting').hide();
            $('#privarcy-setting').hide();
            $('#info-setting').show();

            $('.notification').css({'border-color':'lightgray'});
            $('.privarcy').css({'border-color':'lightgray'});
            $('.info').css({'border-color':'#fcfcfc'});
            $('.notification').css("border-right",'none');
        });

        $('.all').on("click",function(){
            if(document.getElementById('set').checked == true){
                $("#setting-detail").css("background","none");
                $(".others").attr('disabled',false);
                $(".others").css("color","black");
                

            }else if(document.getElementById('nonset').checked == true){
                $("#setting-detail").css("background","lightgray");
                $(".others").attr('disabled',true);
                $(".others").css("color","#5a5a5a");
                
            }
        });
        

        // 차단된 계정 클릭시 스크롤 

        
        $("#blocked-accounts").on('click',function(){
          
        	
          
        	
        	var num=0;
          	var x = setInterval(function(){
               if(num<20){num=num+1}
               else if(num>20 && num<50){num=num+2}
               else if(num>70 && num<100){num=num+2}
               else if(num>120){num=num+1}
               else{num=num+3;}
          $("#blockedList").css('height',num+'px');
          if(num>150){
              clearInterval(x)
          }
          },5);
        });

      	// 차단해제/차단 버튼 클릭시 이벤트
      	$(".disblock").on('click',function(e){
      		var unblockId = e.target.id;
      		if($("#"+e.target.id).html() == '차단해제' ){
      			$.ajax({
      	       		 url: '/spring/disableBlock.do',
      	      		  	 type: 'post',
      	      		   	 data: {
	      	      		   		disblockId : $("#"+unblockId).val(),
	      	      		   		blocked : $("#blocked").val()
      	      		    	 
      	      		   	 		},
      	      		   	 datatype:"text",
      	      		   	 success: function(data){
      		      		   	if(data != null){
      		  		   			 console.log("차단해제 후 : "+data)
      		      		   		$("#"+e.target.id).html('차단'); 
      							$("#blocked").val(data);
      		  		   		 }else{
      		  		   			 alert("차단해제 실패");
      		  		   		 }
      	      		   	 },error: function(error){
      	      		   		 alert(error+"차단해제 에러");
      	      		   	 }
      	       	 });
      			
      		}else{
      			$.ajax({
      				url: '/spring/blockAccount.do',
      				type: 'post',
      				data:{
      					
      					newblock : $("#"+unblockId).val(),
      					blocked : $("#blocked").val()
      				},
      				datatype:"text",
      				success: function(data){
      					if(data != null){ 
      						console.log("차단 후 : "+data)
			      			$("#"+e.target.id).html('차단해제');      			      			
	      					$("#blocked").val(data);				
      					}else{
      						alert("차단 실패");
      					}
      					
      				},error: function(error){
      					alert("차단실패 에러 ");
      				}
      			})
      		}
      	});
      	




        // 계정 삭제 모달 관련
        document.getElementById("modal_opne_btn").onclick = function() {
            document.getElementById("pwdchk_modal").style.display="block";
        }
        
        document.getElementById("pwdchk_btn").onclick = function() {
            
            $.ajax({
       		 url: '/spring/deleteAccount.do',
      		  	 type: 'post',
      		   	 data: {
      		    	 userPwd : $('input[name=pwdchk2]').val()
      		   	 		},
      		   	 datatype:"text",
      		   	 success: function(data){
	      		   	if(data == 'success'){
	  		   			 
	      		   		document.getElementById("pwdchk_modal").style.display="none"; 
	      		  		$("#delete_modal").css('display','block');
		                
	
	  		   		 }else{
	  		   			/*  $('#pwdchk').val()=null; */
	  		   			 alert("비밀번호를 확인 해 주세요");
	  		   		 }
      		   	 },error: function(error){
      		   		 alert(error+"에러");
      		   	 }
       	 });
            
        }

         document.getElementById("delete_account").onclick = function() {
            document.getElementById("delete_modal").style.display="none";
            location.href="index.jsp";
            alert("계정이 삭제 되었습니다.");
        }
       
        document.getElementById("cancel").onclick = function() {
            document.getElementById("delete_modal").style.display="none";
        }  
        
        // 비활성화 버튼 클릭
        document.getElementById("disable_btn").onclick = function() {
            document.getElementById("disable_modal").style.display="block";
           	
        }
        document.getElementById("disableAccount").onclick = function() {
        	/*  console.log($("input[name=pwdchk]").val()); 
        	  console.log($("input[name=userpwd]").val());*/ 
        	 
        	 
        	 $.ajax({
        		 url: '/spring/disableAccount.do',
       		  	 type: 'post',
       		   	 data: {
       		    	 userPwd : $('input[name=pwdchk]').val()
       		   	 		},
       		   	 datatype:"text",
       		   	 success: function(data){
       		   		 console.log(data);
       		   		 if(data == 'success'){
       		   			 
		       		   	 document.getElementById("disable_modal").style.display="none";  
		                 location.href="index.jsp";
		                 alert("계정이 비활성화 되었습니다.");

       		   		 }else{
       		   			/*  $('#pwdchk').val()=null; */
       		   			 alert("비밀번호를 확인 해 주세요");
       		   		 }
       		   	
       		   	 },error: function(error){
       		   		 alert(error+"에러");
       		   	 }
        	 });
        }   
        
        $(".closemodal").on('click',function(){
        	$(".modal").css('display','none');
        })

        function showquestion(){
            $('.question').css('display','flex');
            $('.help').css('display','none');
            $('.about').css('display','none');
            $(".selected").css('border-color','#fcfcfc');
            $("#question").css('border-color','black');
        }

        function showHelp(){
            $('.help').css('display','flex');
            $('.question').css('display','none');
            $('.about').css('display','none');
            $(".selected").css('border-color','#fcfcfc');
            $("#help").css('border-color','black');
        }
       
        function showAbout(){
            $('.help').css('display','none');
            $('.question').css('display','none');
            $('.about').css('display','flex');
            $(".selected").css('border-color','#fcfcfc');
            $("#about").css('border-color','black');
        }
        $('#question-btn').mousedown(function(){
            $('#question-btn').css({'background':'#32ab89'});
        });
        $('#question-btn').mouseup(function(){
            $('#question-btn').css({'background':'#47c6a3','color':'white'});
        });
        
        $("input[name^=notification],input[name^=personal]").on('click',function(e){
        	console.log(e.target.name);
			console.log($('input[name='+e.target.name+']:checked').val())
			
        	$.ajax({
        		  url: '/spring/updateSetting.do',
        		  type: 'post',
        		   data: {
        		    aAll : $('input[name=notification-all]:checked').val(),
        		    aLike : $('input[name=notification-like]:checked').val(),
        		    aReply : $('input[name=notification-Comment]:checked').val(),
        		    aFriends : $('input[name=notification-Addfollow]:checked').val(),
        		    aMessage : $('input[name=notification-Message]:checked').val(),
        		    openStatus : $('input[name=personal-openstatus]:checked').val(),
        		    pwdSaved : $('input[name=personal-savedpwd]:checked').val()
        		  } 
        		 
        		
        		}); 
        });
        
        
        // 문의처리
        $("#question-btn").on('click',function(){
        	
        	console.log($("#question-area").val().length);
        	if($("#question-area").val().length > 10){
        		$.ajax({
    	        	url: '/spring/updateQuestion.do',
    	        	type:'post',
    	        	data:{
    	        		questionText : $("#question-area").val()
    	        	},
    	        	success: function(){
    	        		$("#question-area").val('');
    	        		alert("문의가 성공적으로 전송되었습니다.");
    	        	},error: function(error){
    	        		alert(error);
    	        	}
    	        	
    	        });
        	}else{
        		alert('10자 이상 입력해 주세요');
        		$("#question-area").val('');
        	}
	        
        });
 
        
       
    </script>
</body>
</html>