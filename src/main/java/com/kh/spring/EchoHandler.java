package com.kh.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.spring.chat.controller.ChatController;
import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.feed.controller.FeedController;
import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.LikeIt;
import com.kh.spring.group.controller.GroupController;
import com.kh.spring.group.model.service.GroupService;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.notification.controller.NotificationController;
import com.kh.spring.pushAlarm.model.vo.PushAlarm;


@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
	@Autowired
	GroupService gService;
	// httpSession과 webSocketSession 맵객체에 담기
	private Map<String,WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();
    //세션 리스트
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
    
    @Autowired
    private ChatController cController;
    @Autowired
	private NotificationController nController;
    
    @Autowired
    private GroupController gController;
    
    @Autowired
	private FeedService fService;
    
   
    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session);
        String senderId = getId(session);
        userSessions.put(senderId, session);
        logger.info("{} 연결됨", session.getId()); 
        
        Object[] x = sessionList.toArray();
        for(int i=0;i<x.length;i++) {
        	System.out.println("session :"+ x[i]);
        	
        }
        
        System.out.println("몇명 접속중인가? " + userSessions.size());
        System.out.println(userSessions.toString());
        
    }

	//클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        
        String msg = message.getPayload();
        if(!StringUtils.isEmpty(msg)) {
        	String[] strs = msg.split("\\|");
        	String fromId = getId(session);
        	String Rmsg = "";
			String toId = "";
			String sendType = "";
			String crno = "";
			System.out.println(fromId+Rmsg+Rmsg+sendType+crno);
        	for (int i = 0; i < strs.length; i++) {
				Rmsg = strs[0];
				toId = strs[1];
				sendType = strs[2];
				crno = strs[3];
			}
        	System.out.println("Rmsg : " + Rmsg);
        	int crNo = Integer.parseInt(crno);
        	if(sendType.equals("chatting")) {
        		
        		WebSocketSession toSession =  userSessions.get(toId);
        		System.out.println(toSession);
        		if(Rmsg == null || Rmsg.equals("")) {
            		Rmsg = " ";
            		if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            		} else {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			toSession.sendMessage(new TextMessage(Rmsg));
            		}
            	} else {
            		int result = cController.sendMessage(new Chat(),fromId,toId,Rmsg,crNo);

            		if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
            			System.out.println("값 XXX");
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            		} else {
            			System.out.println("값 OOOOO");
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			toSession.sendMessage(new TextMessage(Rmsg));
            		}
            	}
        		

        	}else if(sendType.equals("groupChatting")) {
        		ArrayList<GroupMember> list = gController.getGroupList(toId);
        		WebSocketSession toSession = null;
        		int result = cController.sendMessageGroup(new Chat(), fromId, toId, Rmsg, crNo);
        		String img = "";
        		for(GroupMember gg : list) {
        			if(gg.getGmId().equals(fromId)) {
        				img = gg.getGmImage();
        			}
        		}
        		for(GroupMember g : list) {
        			toSession = userSessions.get(g.getGmId());
        			if(Rmsg == null || Rmsg.equals("")) {
        				if(toSession.equals(fromId)) {
            				session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			} else {
            				if(toSession.equals("") || toSession == null || !toSession.isOpen()) {
            					continue;
            				} else {
            					toSession.sendMessage(new TextMessage(Rmsg));
            				}
            			}
        			} else {

        				if(result == -1) {
        					if(g.getGmId().equals(fromId)) {
        						session.sendMessage(new TextMessage(Rmsg.substring(0, Rmsg.length()-4)+"|sender|sender"));
        					} else {
        						if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
        							continue;
        						} else {
        							toSession.sendMessage(new TextMessage(Rmsg.substring(0, Rmsg.length()-4)+"|sender|sender"));
        						}
        					}
        				} else {
        					if(g.getGmId().equals(fromId)) {
        						session.sendMessage(new TextMessage(Rmsg+"|sender"));
        					} else {
        						if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
        							continue;
        						} else {
        							toSession.sendMessage(new TextMessage(Rmsg+"|"+fromId+"|memberProfileFiles/"+img));
        						}
        					}
        				}
        			}
        		}
        	} else if(Rmsg.equals("alarm")) {
        		//작성자가 로그인 해서 있다면
        		WebSocketSession boardWriterSession = userSessions.get(toId); // 이줄 맞는지 모르겠음 get()
        		if(sendType.equals("groupjoin")) {
        			String gmId = nController.selectGM(crno);
        			boardWriterSession = userSessions.get(gmId);
        			System.out.println(gmId);
        		}
				System.out.println(boardWriterSession);
				if(toId.equals(fromId)) {
					if("like".equals(sendType)) {
						LikeIt lI = new LikeIt(Integer.parseInt(crno),fromId);
						int like = fService.insertLike(lI);						
					}
					System.out.println("자신에게는 알림이 가지 않음");
				}else if(boardWriterSession != null) {
					if(sendType.equals("reply") ) {
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+fromId+"|"+fromId + "님이 " + 
											"<a type='external' href='/mentor/menteeboard/menteeboardView?seq="+"게시글번호"+"&pg=1'></a> 회원님 게시글에 댓글을 남겼습니다.");
						PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);
					
					}else if("followChk".equals(sendType)) {
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+fromId+"|"+crNo);
						PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);							
					}else if("follow".equals(sendType)) {
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+fromId+"|"+fromId + "님이 회원님을 팔로우를 시작했습니다.");
						PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);							
					}else if("like".equals(sendType)) {
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+fromId+"|"+fromId + "님이 회원님의 게시물을 좋아합니다.");
						PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
						LikeIt lI = new LikeIt(Integer.parseInt(crno),fromId);
						int like = fService.insertLike(lI);
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);
						
					}else if("groupjoin".equals(sendType)) {
						Group fromGroup = gService.getManagerId(fromId);
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+fromId+"|"+fromId + "님이 그룹 가입을 신청했습니다.");
						PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);
						
					}else if("groupAccept".equals(sendType)){
						Group fromGroup = gService.getManagerId(fromId);
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+crno+"|그룹 "+fromGroup.getgName());
						PushAlarm pa = new PushAlarm(toId,fromGroup.getgName(),sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);
					}else if("groupDelete".equals(sendType)) {
						Group fromGroup = gService.getManagerId(fromId);
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+crno+"|그룹 "+fromGroup.getgName());
						PushAlarm pa = new PushAlarm(toId,fromGroup.getgName(),sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);
					}else if("tag".equals(sendType)) {
						TextMessage tmpMsg = new TextMessage("alarm|"+sendType+"|"+fromId+"|"+fromId + ".");
						PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
						int result = nController.insertAlarm(pa);
						boardWriterSession.sendMessage(tmpMsg);
					}
					
				}else {
					PushAlarm pa = new PushAlarm(toId,fromId,sendType,crno,"N");
					int result = nController.insertAlarm(pa);
					if("like".equals(sendType)) {						
						LikeIt lI = new LikeIt(Integer.parseInt(crno),fromId);
						int like = fService.insertLike(lI);
					}
				}
        	}
        }
     }
        
    
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }
    // Interceptor를 이용해 websocketsession에서 httpsession값 가져오는 메소드
    private String getId(WebSocketSession session) {
    	Map<String,Object> httpSession = session.getAttributes();
    	Member loginUser = (Member)httpSession.get("loginUser");
    	if(loginUser == null) {
    		return session.getId();
    	} else {
    		return loginUser.getUserId();
    	}
	}
    
}