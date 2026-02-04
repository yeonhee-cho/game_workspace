class ChatResponse {
  final int conversationId; // 기존에 만약에 저장되어 있는 대화 내용이 존재한다면 기존 대화 내용 id 를 가져와서 이어서 응답하고,
  // 기존에 대화한 내역이 존재하지 않는 다면 request 에서 만들어진 id 로 대화를 이어서 진행
  final String message; // 그에 해당하는 응답 메세지 전달

  ChatResponse(this.conversationId, this.message);

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      ChatResponse(json['conversationId'], json['message']);
}