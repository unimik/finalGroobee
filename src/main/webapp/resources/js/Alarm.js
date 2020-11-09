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
 
 