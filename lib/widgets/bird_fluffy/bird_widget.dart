import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/game_assets.dart';
import '../../providers/bird_fluffy_provider.dart';

class BirdWidget extends StatelessWidget {
  const BirdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<BirdFluffyProvider>(); // 게임 상태 확인
    final birdY = game.birdY;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      /* X좌표, Y좌표 */
      alignment: Alignment(0, birdY),
      child: Container(
        width: game.gameStarted ? 80 : 90, /* 새 모형의 크기 정사각형 */
        height: game.gameStarted ? 60 : 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            // 게임 시작 전 후 이미지 다르게!
            image: AssetImage(game.gameStarted ? GameAssets.birdFluffyFlyBird : GameAssets.birdFluffyLoading),
            fit: BoxFit.cover, // cover = 50 50 맞추기 contain = 비율유지
            filterQuality: FilterQuality.none // 픽셀 아트의 경우 이 옵션을 추가하면 더 선명
          )
        ),
        /*
        decoration: const BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
        ),
        child: Center(
          // 앞에 보고 있었으면 좋겠어~
          child: Transform.flip(
            flipX: true, // 좌우 반전
            child: const Text(
              '🐦',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        */
      ),
    );
  }
}
