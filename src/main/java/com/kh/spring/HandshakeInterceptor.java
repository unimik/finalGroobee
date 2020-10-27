package com.kh.spring;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.spring.member.model.vo.Member;


public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		
		// 위의 파라미터 중, attributes 에 값을 저장하면 웹소켓 핸들러 클래스의 WebSocketSession에 전달된다
        ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
  
        HttpServletRequest req =  ssreq.getServletRequest();
 
        // HttpSession 에 저장된 이용자의 아이디를 추출하는 경우
        Member loginUser = (Member)req.getSession().getAttribute("loginUser");
        attributes.put("loginUser", loginUser);
        System.out.println("HttpSession에 저장된 id:"+loginUser.getUserId());
         
        return super.beforeHandshake(request, response, wsHandler, attributes);
	}

	
}
