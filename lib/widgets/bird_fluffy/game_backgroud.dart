import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('🌅게임 배경 생성됨 (게임 배경 화면을 다시 그리므로 무거운 작업)');
    }
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.red],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          '🌅 게임 배경',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
