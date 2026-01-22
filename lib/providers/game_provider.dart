// ====================== Provider ======================
// 게임의 모든 상태와 로직을 관리하는 Provider 클래스
// ChangeNotifier 를 상속받아 상태 변경 시 UI 에 알림
import 'dart:async';

import 'package:flutter/cupertino.dart';

class GameProvider extends ChangeNotifier{
  // ====================== 게임 상태 변수들 ======================
  // 새의 Y축 위치 (-1 :  화면 최상단, 0 : 중앙, 1 : 화면 최하단)
  double birdY = 0;

  // 중력 계산을 위한 시간 변수 (초 단위)
  double time = 0;

  // 새의 현재 높이(물리 계산용)
  double height = 0;

  // 점프 시작 시점의 새 높이(초기값 저장)
  double initialHeight = 0;

  // 게임 시작 여부(true: 게임 진행 중, false: 대기 중)
  bool gameStarted = false;

  // 현재 점수(장애물을 통과할 때마다 1씩 증가)
  int score = 0;

  // 장애물 X축 위치(2 : 화면 오른쪽 끝, -2 : 화면 왼쪽 끝)
  double barrierX = 2;

  // 장애물의 높이(픽셀 단위)
  double barrierHeight = 200;

  // 게임 루프를 실행하는 타이머 객체
  Timer? _timer;
  // ==========================================================

  // ====================== 게임 메서드들 ======================

  // ===================== 추가: 게임 기능 완성하기 =====================
  // 구현해야 할 기능:
  // 1. 게임 시간 관리 (시간 증가 및 목표 시간 체크)
  // 2. 꾹 누르기 기능 (화면을 꾹 누르면 최대 높이까지 상승)
  // 3. 충돌 감지 (장애물에 부딪히면 점수 감소)
  // 4. 중복 점수/감점 방지
  // 5. 게임 상태 초기화
  // ===================================================================

  // 게임을 시작하는 메서드
  // 50ms 마다 게임 상태를 업데이트 하는 타이머 시작
  void startGame() {
    gameStarted = true;

    // gameTime을 0으로 초기화하세요
    gameTime = 0;

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      // 추가 : gameTime을 0.05씩 증가 -> 게임 시간 증가
      gameTime += 0.05;

      // 추가 : 목표 시간 도달시 게임 종료
      if(gameTime >= targetTime) {
        stopGame();
        return;
      }

      // 추가 : 목표 점수 도달시 게임 종료
      if(score >= targetScore) {
        stopGame();
        return;
      }

      // 추가 : 꾹 누르기 로직 구현
      if (isHolding) {
        // 최대 높이에 도달하지 않았을 때만 상승
        if(birdY > -0.9) {
          birdY -= 0.03;
          time = 0;
          initialHeight = birdY;
        } else {
          // 최대 높이에 도달하면 그 위치 유지
          birdY = -0.9;
          time = 0;
          initialHeight = birdY; // 물리 초기화
        }
      } else {
        // 일반 탭의 경우

        // 기존 중력 로직 사용
        // 시간 증가 (0.04씩)
        time += 0.04;

        // 물리 공식으로 높이 계산
        height = initialHeight - 4.9 * time * time;

        // 새의 Y 위치 업데이트
        // 점프 시작 시점의 새높이 - 물리공식으로 높이 계산한 height 사용
        birdY = initialHeight - height;
      }

      /*
      // 시간 증가 (0.04씩)
      time += 0.04;

      // 물리 공식으로 높이 계산
      height = initialHeight - 4.9 * time * time;

      // 새의 Y 위치 업데이트
      // 점프 시작 시점의 새높이 - 물리공식으로 높이 계산한 height 사용
      birdY = initialHeight - height;
      */

      // 장애물 이동 및 리셋 로직
      if(barrierX < -2) {
        // 장애물이 화면을 벗어나면 오른쪽 끝으로 리셋하고 점수 증가
        barrierX = 2.5;// 오른쪽 끝으로 리셋

        // 추가 : 중복 점수 방지 로직 추가
        if(!hasPassedBarrier) {
          // score 증가, hasPassedBarrier true
          score++;
          hasPassedBarrier = true;
        }
      } else {
        // 장애물 이동(왼쪽으로 0.05씩)
        barrierX -= 0.05; // 장애물 왼쪽으로 지나가는 듯한 이동 처리

        // 추가 : 장애물이 화면 중앙을 지나가면 통과 플래그 리셋
        if(barrierX < 0 && hasPassedBarrier) {
          hasPassedBarrier = false;
        }
      }

      // 추가 : 충돌 체크 메서드 호출
      _checkCollision();

      // notifyListeners() 호출
      notifyListeners();
      if(_checkGameOver()) {
        stopGame();
      }

      // 게임 오버 체크
      _checkGameOver(); // 게임 중지
    });
  }

  // ============= 과제 2: 충돌 체크 메서드 추가하여 작성하기 =============

  // 추가 : _checkCollision() 메서드
  void _checkCollision() {
    // 1. 장애물이 새 근처에 있을 때만 체크
    if (barrierX < 0.2 && barrierX > -0.2) {
      // 2. 새가 장애물과 충돌했는지 확인 (위 또는 아래 장애물)
      if (birdY < -0.3 || birdY > 0.3) {
        // 3. 이전에 충돌 상태가 아니었다면 점수 감소
        if (!wasColliding) {
          // 4. 점수는 0 미만(음수)으로 떨어지지 않도록 처리
          score = score > 0 ? score -1 : 0;
          wasColliding = true; // 5. wasColliding 플래그를 적절히 업데이트
        }
      } else {
        wasColliding = false;
      }
    } else {
      wasColliding = false;
    }
  }


  // 탭 할 때마다 새로운 포지션으로 이동
  // 새를 점프 시키는 메서드 -> 화면을 탭할 때마다 호출됨
  void jump() {
    // time을 0으로 초기화
    time = 0;

    // initialHeight를 현재 birdY로 설정
    initialHeight = birdY;

    // notifyListeners() 호출
    notifyListeners();
  }

  // 게임 오버 조건을 체크하는 메서드
  // @return true: 게임 오버, false: 계속 진행
  bool _checkGameOver() {
    // 조건 1 - 화면 경계 체크
    if(birdY > 1.0 || birdY < -1.0) return true;

    // 조건 2 - 장애물 충돌 체크
    if(barrierX < 0.2 && barrierX > -0.2) {
      if(birdY < -0.3 || birdY > 0.3) return true;
    } // TODO 닿이면 점수 깎이게
    return false; // 게임 계속 진행
  }

  // ============= 과제 3: stopGame() 메서드 수정하기 =============
  // 게임을 중지하는 메서드
  // 타이머를 멈추고 게임시작 상태를 false 로 변경
  void stopGame(){
    // 타이머 취소
    _timer?.cancel();

    // gameStarted를 false로 설정
    gameStarted = false; // 게임 중지 상태로 변경 후

    // 추가 : 꾹 누르기 해지
    isHolding = false;

    // notifyListeners() 호출
    notifyListeners();
  }

  // ============= 과제 4: resetGame() 메서드 수정하기 =============

  // 게임을 처음 상태로 리셋하는 메서드
  // 게임 종료 후 다시 시작할 때 호출됨
  void resetGame(){
    // 모든 변수를 초기값으로 리셋
    // birdY, time, height, initialHeight, barrierX, score, gameStarted
    birdY = 0;
    time = 0;
    height = 0;
    initialHeight = 0;
    gameStarted = false;
    score = 0;
    barrierX = 2;

    // 추가 : 추가된 변수들도 리셋하세요
    isHolding = false;
    gameTime = 0;
    hasPassedBarrier = false;
    wasColliding = false;

    // notifyListeners() 호출
    notifyListeners();
  }

  // 화면을 꾹 누르고 있는지 여부
  bool isHolding = false;

  // 게임 시작 후 경과 시간(초)
  double gameTime = 0;

  // 목표 시간 (초) - 이 시간에 도달하면 게임 종료
  final double targetTime = 60.0;

  // 목표 점수 - 이 점수에 도달하면 게임 종료
  final int targetScore = 20;

  // 장애물 통과 여부 체크 (중복 점수 방지)
  bool hasPassedBarrier = false;

  // 이전 프레임에서 충돌 상태였는가 (중복 감점 방지)
  bool wasColliding = false;

  // 꾹 누르기 시작
  void startHolding() {
    isHolding = true;
    time = 0;
    initialHeight = birdY;
  }

  // 꾹 누르기 종료
  void stopHolding() {
    isHolding = false;
    time = 0;
    initialHeight = birdY;
  }

  // 남은 시간(초)
  double get remainingTime => targetTime - gameTime;

  // 남은 점수(목표까지)
  int get remainingScore => targetScore - score;

  // ==========================================================
}