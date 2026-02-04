class ChatRequest {
  final String userId;
  final String message;
  final int? conversationId;

  ChatRequest(this.userId, this.message, [this.conversationId]);

  Map<String, dynamic> toJson() => {
    'userId': userId, // db에서 조회한 어떤 유저가
    'message': message, // 보내는 메세지 내용, db에 저장
    'conversationId':conversationId // 기존 대화를 저장하고 저장된 데이터를 불러오고 싶다면 db 와 연결되었다는 가정
  };
}