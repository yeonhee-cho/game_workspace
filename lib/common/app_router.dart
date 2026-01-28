import 'package:game_workspace/screens/bird_fluffy_screen.dart';
import 'package:game_workspace/screens/calendar_screen.dart';
import 'package:game_workspace/screens/chat_screen.dart';
import 'package:game_workspace/screens/dress_up_screen.dart';
import 'package:game_workspace/screens/main_screen.dart';
import 'package:game_workspace/screens/user_list_screen.dart';
import 'package:go_router/go_router.dart';

import '../models/game_item.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MainScreen()
      ),

      // builder => MainScreen 을 보여줄 것이다 라고 쓸 때는 retrun 생략 가능
      // builder { 특정 기능들 작성 마지막으로 return MainScreen } 결론적으로 return 스크린을 보여줄 것이다.
      // return 생략 가능
      GoRoute(
        path: '/flappy',
        builder: (context, state) {
          // state.extra = GoRouter 가 화면 이동할 때 추가 데이터를 전달하는 공간
          // 타입이 ? 일경우 모든 타입이 우선 가능하다.!! null 일 수도 있다.
          // state.extra 로 넘어온 데이터를 GameItem 타입 또는 null 타입으로 변환해줘요.
          // 변환처리된 결과를 BirdFluffyScreen 에서 gameItem 이라는 명칭으로 활용하겠어요
          final game = state.extra as GameItem?;
          return BirdFluffyScreen(gameId: 'flappy', gameItem: game);
        }
      ),
      GoRoute(
          path: '/dressUp',
          builder: (context, state) {
            final game = state.extra as GameItem?;
            return DressUpScreen(gameId: 'dressUp', gameItem: game);
          }
      ),
      GoRoute(
          path: '/chat', name: 'chat',
          builder: (context, state) => ChatScreen()
      ),
      GoRoute(
          path: '/calendar',
          builder: (context, state) {
            final thisDate = state.extra as GameItem?;
            return CalendarScreen(gameId: 'calendar', gameItem: thisDate);
          }
      ),
      GoRoute(
          path: '/users',
          builder: (context, state) {
            final thisDate = state.extra as GameItem?;
            return UserListScreen(gameId: 'users', gameItem: thisDate);
          }
      ),
      /*
      GoRoute(
        path: '/game/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final game = state.extra as GameItem?;
          return BirdFluffyScreen(gameId: id, gameItem: game);
        }
      )
      */
    ]
  );
}