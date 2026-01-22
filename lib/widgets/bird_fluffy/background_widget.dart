import 'package:flutter/material.dart';

import '../../constants/game_assets.dart';

// 게임 영역의 배경
class BackgroundWidget extends StatelessWidget{
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(GameAssets.birdFluffyBackground),
          fit: BoxFit.cover // 화면 전체 덮음
          // fit: BoxFit.contain // 비율 유지하며 전체 보임
          // fit: BoxFit.fill // 비율 무시하고 전체 차지
        )
      ),
      // color: Colors.green[900],
    );
  }
}