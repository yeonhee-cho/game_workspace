import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/chat/chat_message.dart';

// ChatBubble 자체를 ListView가 감싸고 있기 때문에 무조건 세로 정렬
// 내부에있는 Row는 ListView  가 강제 세로 정렬을 하고 있기 때문에 의미 없음 XXXXXXX
// Row 모두 지워도크게 문제되지 않는다.
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // 패딩으로 전체 설정 먼저할 것이다 = 맨 바깥에
    // Padding

    // 패딩보다 Row 로 먼저 작성한 다음에
    // 내부에서 padding 이라는 속성을 사용할 것이다.
    // 선택은 개발자의 자유
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          // 이유 1 번 : 본인 메세지인지 상대 메세지 인지 구분하기 위해서
          mainAxisAlignment:
          message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            // 1. 말풍선
            Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: message.isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    message.message,
                    style: TextStyle(
                        color: message.isUser ? Colors.white : Colors.black),
                  ),
                )),
            // 2. 시간 표시 (항상 말풍선 오른쪽에 위치)
            const Padding(
              padding: EdgeInsetsGeometry.only(left: 4, bottom: 2),
              child: Text(
                "10:20",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            )
          ],
        ));

    /*
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          // 이유 1 번 : 본인 메세지인지 상대 메세지 인지 구분하기 위해서
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: message.isUser? MainAxisAlignment.end: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: message.isUser? Colors.blue: Colors.grey[300],
                        borderRadius:
                        BorderRadius.circular(12)
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(
                          color: message.isUser? Colors.white: Colors.black),
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );

     */
  } // Widget build(BuildContext context) {
} // class ChatBubble extends StatelessWidget {