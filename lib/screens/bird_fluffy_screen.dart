import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game_item.dart';
import '../widgets/bird_fluffy/game_area_widget.dart';
import '../widgets/bird_fluffy/ground_widget.dart';
import '../widgets/bird_fluffy/score_widget.dart';
import '../providers/bird_fluffy_provider.dart';

/*
 * lib
 * ├─── main.dart                         # 어플의 시작점
 * ├─── providers/
 * │    └─────── bird_fluffy_provider.dart       # 게임의 두뇌(상태 관리 + 로직)
 * │                                        - 게임 상태 변수들(새의 위치, 점수, 장애물 위치 등)
 * │                                        - 게임 로직(startGame, jump, 충돌 감지 등)
 * │                                        - 물리 엔진
 * │                                        - ChangeNotifier로 UI 상태 변경 알림
 * ├─── screens/
 * │    └─────── bird_fluffy_screen.dart bird_fluffy_provider.dart        # 전체 화면 레이아웃 관리자
 * │                                        - 탭 제스처 처리(GestureDetector)
 * │                                        - 위젯들을 조합하여 완성된 게임 화면 구성
 * │                                        - Provider 와 UI를 연결하는 중간 다리 역할
 * └── widgets/
 *      ├─────── background_widget.dart   # 배경그리기 상태 변환 없는 정적 위젯
 *      ├─────── barrier_widget.dart      # 장애물 표시 위/아래 2개의 녹색 장애물 렌더링
 *      │                                   - provider 에서 barrierX 위치 받아와서 이동
 *      │                                   - AnimatedContainer 로 부드러운 이동 구현
 *      ├─────── bird_widget.dart         # 플레이어 캐릭터 (새)
 *      │                                   - provider 에서 birdY 위치 받아와서 상하 이동
 *      │                                   - 중력에 따라 위치가 계속 변함
 *      ├─────── game_area_widget.dart    # 게임 플레이 영역 컨테이너
 *      │                                   - Stack으로 여러 위젯을 겹쳐서 배치
 *      │                                   - 배경 + 새 + 장애물 + 게임 오버리스너 조합
 *      ├─────── game_over_listener.dart    # 게임 오버 감지 및 다이얼로그 표시
 *      │                                   - 화면에는 보이지 않는 게임 감시자 위젯
 *      │                                   - 게임 상태 계속 모니터링
 *      │                                   - 게임 오버 순간 감지하여 다이얼로그 표시 "다시 시작" 버튼으로 리셋 처리
 *      ├─────── ground_widget.dart       # 화면 하단 바닥
 *      │                                   - 갈색 땅 영역 렌더링
 *      │                                   - 게임 영역과 구분되는 시각적 요소 정적 위젯으로 상태 변환 없는 단순 UI 화면
 *      └─────── score_widget.dart        # 점수 표시 영역
 *                                          - 게임 시작 전 : 탭하여 시작! 메세지 표시
 *                                          - 게임 중 : 점수 표시
 *                                          -  provider 에서 gameStarted 와 score 값 받아옴
 */
// class BirdFluffyProvider with ChangeNotifier {
//   int _score = 0;
//
//   int get score => _score;
//
//   void addScore() {
//     _score += 10;
//     notifyListeners();
//   }
// }

class BirdFluffyScreen extends StatelessWidget {
  final String gameId;
  final GameItem? gameItem;

  const BirdFluffyScreen({
    super.key,
    required this.gameId,
    this.gameItem
  });

  @override
  Widget build(BuildContext context) {
    // Listener = 마우스 클릭과 터치 동시 제공
    // onPointerDown = 터치하거나 클릭하거나
    // onPointerUp = 터치를 멈추거나 클릭을 멈추거나
    return Scaffold(
      appBar: AppBar(
        title: const Text("새 충돌 피하기"),
        backgroundColor: Colors.white,
      ),
      body: Listener(
        onPointerDown: (_){
          // 현재 유저가 꾹 눌렀을 때 게임의 상태 확인
          final game = context.read<BirdFluffyProvider>();
          if(!game.gameStarted) {
            // 게임이 시작되지 않았으면 게임 시작
            game.startGame();
          } else {
            // 게임 중이면 꾹 누르기 시작
            game.startHolding();
          }
        },

        onPointerUp: (_) {
          // 현재 유저가 꾹 누르기를 종료했을 때 게임의 상태 확인
          final game = context.read<BirdFluffyProvider>();
          game.stopHolding();

          // 점프 실행
          if(game.gameStarted) {
            game.jump();
            // game.startGame();
          }
        },
        /*
        // 꾹 누르기 시작 종료
        onLongPressStart: (_){
          // 현재 내가 꾹 눌렀을 때 게임의 상태 확인
          final game = context.read<BirdFluffyProvider>();
          if(game.gameStarted) {
            game.startHolding();
          }
        },

        onLongPressEnd: (_){
          // 현재 유저가 꾹 누르기를 종료 했을 때 게임의 상태 확인
          final game = context.read<BirdFluffyProvider>();
          game.stopHolding();
        },
        onTap: () {
          final game = context.read<BirdFluffyProvider>();

          // 게임이 시작되지 않았으면 startGame() 호출
          if(!game.gameStarted) {
            game.startGame();
          }

          // jump() 호출
          game.jump();
        },
        */
        child: const Scaffold(
          body: Column(
            children: [
              ScoreWidget(),
              GameArea(),
              GroundWidget()
            ],
          ),
        ),
      )
    );
      /*
    return Scaffold(
      appBar: AppBar(
        title: const Text('게임 화면'),
        backgroundColor: Colors.purple,
      ),
      body: Consumer<BirdFluffyProvider>(
        child: const Column(
          children: [
            SizedBox(height: 20),
            GameCharacter(),
            SizedBox(height: 20),
            GameBackground(),
            SizedBox(height: 20),
            ParticleEffect(),
          ],
        ),

        builder: (context, gameProvider, child) {
          if (kDebugMode) {
            print('builder 실행됨 점수: ${gameProvider.score}');
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '점수: ${gameProvider.score}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              child!,

              ElevatedButton(
                onPressed: () {
                  gameProvider.addScore();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  '점수 올리기 +10',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
    */
  }
}

