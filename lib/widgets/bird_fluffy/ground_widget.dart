import 'package:flutter/material.dart';

import '../../constants/game_assets.dart';

class GroundWidget extends StatelessWidget{
  const GroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: Container(
            // color: Colors.brown
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(GameAssets.birdFluffyGround),
                  fit: BoxFit.fill
              )
          ),
        )
    );
  }
}