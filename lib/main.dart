import 'package:flutter/material.dart';
import 'package:game_workspace/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:game_workspace/providers/game_provider.dart';
import 'package:game_workspace/screens/game_screen.dart';
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
      create: (_) => GameProvider(),

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: GameScreen(),
          home: Center(
            child: Container(
              // width: 400, // 모바일 가로 크기
              // height: 800, // 모바일 세로 크기
              child: const MainScreen(),
            ),
          )
      ),
    );
  }
}