import 'package:flutter/material.dart';
import 'package:game_workspace/common/app_router.dart';
import 'package:game_workspace/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:game_workspace/providers/bird_fluffy_provider.dart';
/*
 * main() 함수 작성
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // 생성자 작성
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BirdFluffyProvider(),

      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}