import 'package:flutter/material.dart';
import 'package:game_workspace/models/chat/chat_message.dart';
import 'package:game_workspace/models/chat/chat_request.dart';
import 'package:game_workspace/services/chat_service.dart';
import 'package:game_workspace/widgets/chat/loading_indicator.dart';
import 'package:game_workspace/widgets/chat/message_input.dart';
import 'package:game_workspace/widgets/chat/message_list.dart';

// 메세지가 추가 되기 때문에 StatefulWidget 유동적으로 화면 변경되는 위젯
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // TextEditingController를 이용해서 유저가 작성한 데이터 주고 받을 수 있는 컨트롤러 설정
  final TextEditingController controller = TextEditingController();
  // 유저들이 주고 받은 대화를 리스트 형태로 저장
  List<ChatMessage> messages = [];
  // 데이터를 주고 받을 때 로딩 처리
  bool loading = false;

// int? conversationId;
// 대화 히스토리 저장 (API 전송용)
  // 백엔드에 대화 히스토리를 저장하고자 한다면 리스트 형태 사용
  List<Map<String, String>> conversationHistory = [];

  // 메세지 를 보내기 기능
  void sendMessage() async {
    String text = controller.text; // 글자는 컨트롤러로 input 창에 작성한 텍스트 가져와 text 변수에 담기
    if (text.isEmpty) return; // 텍스트 내부가 비어있다면 메세지 보내기 취소

    setState(() {
      messages.add(ChatMessage(text, true, DateTime.now())); // 메세지를 저장할 때 쳇 메세지 클래스를 이용하여 대화 내용, 보낸 날짜 형태로 저장(  List<ChatMessage> messages = []; 여기에)
      loading = true;
    });

    controller.clear(); // input 창에 작성되어있는 텍스트 지우기 보낸 후 텍스트 input 창 비우기

    try {
      // Gemini API 호출
      final response =
      await ChatService.AIsendMessage(text, conversationHistory); // api 를 이용해서 메세지 전송

      conversationHistory.add({'message': text, 'isUser': 'true'}); // 유저가 보낸 글자 내용은 text 변수에 저장되어있고, isUser : true 로 설정하여 유저임을 표기 후 리스트 저장
      conversationHistory.add({'message': response, 'isUser': 'false'}); // 유저가 보낸 글자 응답은 response 변수에 서버로 부터 전달받은 데이터가 내장되어 있고,
      // isUser : false 로 설정 하여 유저임을 표기한 후 리스트 저장

      setState(() {
        messages.add(ChatMessage(response, false, DateTime.now())); // 보낸 내용과 응답 결과 기록
        loading = false; // 로딩 풀기
      });
    } catch (e) {
      setState(() {
        loading = false; // 서버와 주고 받는데 문제가 있을 경우 예외 처리 진행
      });
      ScaffoldMessenger.of(context) // 오류 내용을 현재 스크린에 띄우기
          .showSnackBar(SnackBar(content: Text('오류 : $e')));
    }
  }

/*
  void sendMessage() async {
    String text = controller.text;
    if (text.isEmpty) return;
    setState(() {
      messages.add(ChatMessage(text, true, DateTime.now()));
      loading = true;
    });
    controller.clear();
    try {
      final request = ChatRequest('user123', text, conversationId);
      final response = await ChatService.sendMessage(request);
      conversationId = response.conversationId;
      setState(() {
        messages.add(ChatMessage(response.message, false, DateTime.now()));
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('오류: $e')));
    }
  }


 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('채팅'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            // 메세지 리스트
            Expanded(
              child: MessageList(messages: messages), // List<ChatMessage> messages = []; 안에 저장해 놓은 메세지 기록들을 전달
            ),

            // 로딩 표시
            if (loading) const LoadingIndicator(),

            // 입력창
            MessageInput(
                controller: controller, onSend: sendMessage, isLoading: loading) // controller 를 이용해서 입력창 데이터를 주고 받기 상호작용
            // onSend : screen 에 만들어놓은 sendMessage 기능을 전달하여 onSend 명칭으로 사용
          ],
        ));
  }
}