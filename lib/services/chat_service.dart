/*
import 'dart:convert';
// json 인코딩 디코딩 기능 제공
// -> 주소로 데이터 주고받을 때 문자열로 변환
// 데이터 가져와서 활용할 때 문자열을 json 형태로 변환 처리

// 아래는 자바 백엔드에서 사용하는 모델
import 'package:game_workspace/common/constants.dart';          // API URL 등 상수를 정의한 파일
import 'package:game_workspace/models/chat/chat_request.dart';  // 채팅 요청 보내는 모델
import 'package:game_workspace/models/chat/chat_response.dart'; // 채팅 요청에 따른 응답을 받아오는 모델
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;                        // http 내용 자체를 http 라는 별칭으로 사용
class ChatService {
  // Google Gemini API 설정

  // static 으로 지정하는 상수는 클래스 레벨의 상수로 인스턴스 생성없이 사용 가능
  // 객체를 만들지않고, 모두가 apiKey 사용할 수 있음 / 비공개 처리가 아니기 때문에 어디서든지 접근 가능
  static const String apiKey = "        ";
  // gemini API 사용할 모델 이름                                                         모델명   : 콘텐츠생성으로 사용
  // static const String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";
  // static const String apiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent";
  static const String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

  //     비동기 함수 미래에 String 결과 반환
  //                                      메세지       키 데이터 형태의 목록들   이전 대화 내역 리스트
  //                                                    [{chatbot : 대화} , {user:대화}]
  static Future<String> AIsendMessage(String message, List<Map<String, String>> conversationHistory) async {
    try{
      // 대화 히스토리를 Gemini API 형식으로 변환
      final List<Map<String, dynamic>> contents = []; // Gemini API에 보낼 대화 내용을 저장할 빈 리스트

      // 이전 대화 추가
      /*
    'role' : Map의 키 - role 이라는 이름
    msg['isUser'] == 'true' - 조건 확인 - msg 라는 Map 에서 'isUser'값이 'true'인지 비교
    msg는 {'message':'안녕','isUser':'true'} 같은 형태
     */
      for(var msg in conversationHistory) {
        contents.add({
          // 사용자 메세지일 때 true role : user
          // A    I 메세지 일 때 false role : model
          'role': msg['isUser'] == 'true' ? 'user' : 'model',
          'parts':[{'text':msg['message']}]
        });
      }
      /*
      === gemini 형식 ====
      contents =[
            {
            'role':'user'
            'parts' : [{'text':'안녕'}]
            },
            {
            'role':'model'
            'parts' : [{'text':'안녕하세요'}]
            }
      ]
      // chat_screen 에서 사용하는 대화 히스토리 방식
     conversationHistory = [
       {'message':'안녕', 'isUser' : 'true'},
       {'message':'안녕하세요', 'isUser' : 'false'},

     ]
       */
      // 현재 메세지
      contents.add({
        'role':'user',
        'parts':[{'text': message}]

      });

      final response = await http.post(
          Uri.parse('$apiUrl?key=$apiKey'),   // ApI가 요구하는 키
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode({            // dart 형식으로 작성한 데이터를 json 문자열형태로 변환 하겠다.
            'contents': contents,      // contents - 위에서 만든 대화 내역 리스트
            'generationConfig':{       // AI 생성 설정 객체
              'temperature':0.7,       // 응답의 창의성 / 무작위성 조절 0.7 중간 정보 (0.0 = 보수적, 1.0 = 창의적)
              'maxOutputTokens':1000, // 최대 응답 길이 약 750 단어 토큰 = 0.75 단어
            }
          })
      );

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        /*
        data['candidates'] = API 응답 후보들의 배열 에서
                 [0]       = 첫 번째 후보 선택
               ['content'] = 컨텐츠 객체
               ['parts']   = 컨텐츠들 중에서
                 [0]       = 첫 번째로 존재하는 컨텐츠의
                ['text']   = 실제 텍스트 내용을 반환하겠다.
         */
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('API 오류 : ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('메세지 전송 실패 : $e');
    }

  }

/*
백엔드 연결하여 챗봇 서비스 제공
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type':'application/json'
      }
    )
  );


  static Future<ChatResponse> sendMessage(ChatRequest request) async {

      // dio post /message
      final res = await _dio.post("${ApiConstants.chatUrl}/message",
          data: request.toJson());

      return ChatResponse.fromJson(res.data);
    }

 */
}
*/

class ChatService {
  // 간단한 QnA 데이터베이스
  static final Map<String, String> _qnaDatabase = {
    // 인사
    '안녕': '안녕하세요. 무엇을 도와드릴까요?',
    '안녕하세요': '안녕하세요. 반갑습니다.',
    'hi': 'Hi there. How can I help you?',
    'hello': 'Hello. Nice to meet you.',

    // 게임 관련
    '게임': '충돌피하기와 옷입히기 게임이 있어요. 어떤 게임을 하고 싶으세요?',
    '충돌피하기': '충돌피하기는 새를 조종해서 장애물을 피하는 게임이에요. 화면을 꾹 누르면 부스터로 빠르게 상승할 수 있어요.',
    '옷입히기': '옷입히기는 캐릭터에게 다양한 옷을 입히는 게임이에요. 헤어, 상의, 하의, 신발, 악세서리를 골라보세요.',
    '어떻게': '게임을 선택한 후 화면의 안내를 따라주세요. 충돌피하기는 탭하면 시작되고, 옷입히기는 카테고리를 선택해서 꾸밀 수 있어요!',
    '도움말': '궁금한 게임에 대해 물어보세요. 예: "충돌피하기", "옷입히기", "점수" 등',

    // 점수/규칙
    '점수': '충돌피하기에서는 장애물을 통과할 때마다 점수가 올라가요. 20점을 목표로 도전해보세요.',
    '콤보': '장애물을 연속으로 통과하면 콤보가 쌓여요. 3콤보마다 화려한 효과가 나타납니다.',
    '규칙': '충돌피하기: 60초 안에 20점 달성. 옷입히기: 자유롭게 캐릭터를 꾸며보세요.',

    // 기능
    '캘린더': '캘린더에서 공휴일을 확인할 수 있어요. 년도별로 공휴일을 보거나 숨길 수 있습니다.',
    '채팅': '지금 채팅하고 계시네요. 궁금한 것을 물어보세요.',

    // 기타
    '고마워': '천만에요! 즐거운 시간 되세요.',
    '감사': '도움이 되었다니 기쁩니다.',
    '재미': '재미있게 즐기고 계시나요? 더 궁금한 게 있으면 물어보세요.',
    '최고': '감사합니다! 당신도 최고예요.',

    // 날씨/시간
    '날씨': '죄송해요, 실시간 날씨는 확인할 수 없어요. 하지만 게임은 언제든 즐길 수 있답니다.️',
    '시간': '지금은 게임을 즐기기 좋은 시간이에요.',
  };

  // 키워드 기반 응답
  static final Map<String, String> _keywordResponses = {
    '시작': '게임을 시작하려면 메인 화면에서 원하는 게임을 선택하세요.',
    '방법': '화면을 탭하거나 꾹 누르면 돼요. 각 게임마다 조작법이 조금씩 달라요.',
    '부스터': '충돌피하기에서 화면을 꾹 누르면 부스터가 발동되어 빠르게 상승해요.',
    '파티클': '게임 플레이 중 화려한 파티클 효과를 즐기실 수 있어요.',
    '진동': '게임 중 진동 피드백이 있어서 더 생생한 느낌을 받을 수 있어요.',
  };

  static Future<String> AIsendMessage(
      String message,
      List<Map<String, String>> conversationHistory
      ) async {
    // 메시지를 소문자로 변환하고 공백 제거
    final lowerMessage = message.toLowerCase().trim();

    // 짧은 지연으로 실제 채팅처럼 보이게
    await Future.delayed(const Duration(milliseconds: 500));

    // 1. 정확한 매칭 확인
    for (var entry in _qnaDatabase.entries) {
      if (lowerMessage.contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }

    // 2. 키워드 매칭
    for (var entry in _keywordResponses.entries) {
      if (lowerMessage.contains(entry.key)) {
        return entry.value;
      }
    }

    // 3. 물음표가 있으면 질문으로 간주
    if (message.contains('?') || message.contains('？')) {
      return _getRandomQuestionResponse();
    }

    // 4. 기본 응답
    return _getRandomDefaultResponse();
  }

  static String _getRandomQuestionResponse() {
    final responses = [
      '흥미로운 질문이네요. 게임에 대해 더 자세히 알고 싶으시면 "도움말"을 입력해보세요.',
      '좋은 질문이에요. 충돌피하기나 옷입히기에 대해 물어보시면 자세히 알려드릴게요.',
      '궁금하신 게임이나 기능에 대해 구체적으로 물어봐주세요.',
    ];
    return responses[DateTime.now().millisecond % responses.length];
  }

  static String _getRandomDefaultResponse() {
    final responses = [
      '네. 게임에 대해 궁금한 점이 있으시면 물어보세요.',
      '말씀하신 내용을 잘 이해하지 못했어요. "도움말"을 입력하면 질문 예시를 볼 수 있어요.',
      '게임이나 기능에 대해 물어보시면 도와드릴게요. 예: "충돌피하기", "점수", "캘린더"',
      '재미있게 즐기고 계신가요? 궁금한 점이 있으면 언제든 물어보세요.',
    ];
    return responses[DateTime.now().millisecond % responses.length];
  }
}
