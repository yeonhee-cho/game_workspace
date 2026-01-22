import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/game_assets.dart';
import '../../providers/bird_fluffy_provider.dart';

class BarrierWidget extends StatelessWidget {
  const BarrierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<BirdFluffyProvider>();

    return Stack(
      children: [
        // 위쪽 장애물
        AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          alignment: Alignment(game.barrierX, -1.1),
          child: Container(
            width: 170, /* 장애물 너비 */
            height: game.barrierHeight,
            // color: Colors.green[700],
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(GameAssets.birdFluffyBarrierTop),
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.none
                )
            ),
          ),
        ),

        // 아래쪽 장애물
        AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          alignment: Alignment(game.barrierX, 1.1),
          // 장애물을 png 이미지 가져와서 변경
          // 혹은 이모지로 변경
          child: Container(
            width: 170,
            height: game.barrierHeight,
            // color: Colors.green[700],
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(GameAssets.birdFluffyBarrierBottom),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none
              )
            ),
          ),
        ),
      ],
    );
  }
}
