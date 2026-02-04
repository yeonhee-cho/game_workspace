class ChatMessage {
  final String message; // 메세지 띄우기
  final bool isUser; // 유저 인지 회사측 인지 boolean 형태로 확인
final DateTime time; // 메세지를 전달한 시간 표기

ChatMessage(this.message, this.isUser, this.time);

// 순서에 개의치 않고, 키: 변수 이름 형태로 주고 받는 형식에서 주로 사용
// 마치 json 이나 map 처럼
// ChatMessage({this.message, this.isUser, this.time});
}