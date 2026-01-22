import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/game_item.dart';

class GameCard extends StatelessWidget {
  final GameItem game;

  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 게임 카드를 클릭했을 때 해당 게임 화면으로 이동
      onTap: () => context.push('/game/${game.id}', extra: game),
      child: Container(
        decoration: BoxDecoration(
          // 게임 카드 배경색
          color: game.color,
          borderRadius: BorderRadius.circular(20),
          // BoxShadow 내부에 어떠한 값을 넣어야 할지 모를 경우 속성 위에 마우스 올리기
          // 대부분 클래스는 {List<BoxShadow>? boxShadow} 타입 : List<BoxShadow>?
          // 타입이 List 형태로 되어있다면 [] 형태로 사용
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5)
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(game.imageAsset != null)
              // 게임 이미지
              Image.asset(
                game.imageAsset!,
                width: 64,
                height: 64,
                fit: BoxFit.contain
              ),
            if(game.icon != null)
              // 게임 아이콘
              Icon(
                game.icon,
                size: 64,
                color: Colors.white
              ),
            const SizedBox(height: 16),
            // 게임 이름
            Text(
                game.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
            )
            // 여기에 코드 작성
          ],
        ),
      ),
    );
  }
}
