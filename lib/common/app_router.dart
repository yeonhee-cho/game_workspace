import 'package:game_workspace/screens/game_screen.dart';
import 'package:game_workspace/screens/main_screen.dart';
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
      GoRoute(
        path: '/game/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final game = state.extra as GameItem?;
          return BirdFluffyScreen(gameId: id, gameItem: game);
        }
      )
    ]
  );
}