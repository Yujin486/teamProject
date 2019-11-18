package net.koreate.project.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler{
	
	private List<WebSocketSession> sessionList = new ArrayList<>();
	/*private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();*/

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결되었습니다 : "+session.getId());
		sessionList.add(session);
		/*sessions.put(session.getId(), session);*/
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		String userName = msg.split(",")[0];
		String userMessage = msg.split(",")[1];
		System.out.println(session.getId()+"로부터 전달 받은 메시지 : "+msg);
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(userName+" : "+userMessage));
		}
		/*Iterator<String> sessionsIds = sessions.keySet().iterator();
		String sessionId = "";
		while(sessionsIds.hasNext()) {
			sessionId = sessionsIds.next();
			sessions.get(sessionId).sendMessage(new TextMessage(userName+" : "+userMessage));
		}*/
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결이 끊겼습니다 : "+session.getId());
		sessionList.remove(session);
		/*sessions.remove(session.getId());*/
		
	}
	
	

}
