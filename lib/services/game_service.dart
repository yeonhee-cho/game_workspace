import 'package:flutter/material.dart';

import '../models/game_item.dart';

class GameService {
  static List<GameItem> getAllGames() {
    return [
      GameItem(
          id: 'flappy',
          name: '새 충돌 피하기 게임',
          color: Colors.blue,
          icon: Icons.flight
      ),
      GameItem(
          id: 'shooter',
          name: '슈팅 게임',
          color: Colors.red,
          icon: Icons.gps_fixed
      ),
      GameItem(
          id: 'racing',
          name: '레이싱 게임',
          color: Colors.yellow.shade700,
          icon: Icons.gps_fixed
      ),
      GameItem(
          id: 'puzzle',
          name: '퍼즐 게임',
          color: Colors.purple,
          icon: Icons.extension
      ),
      GameItem(
          id: 'arcade',
          name: '아케이드 게임',
          color: Colors.green,
          icon: Icons.sports_esports
      ),
      GameItem(
          id: 'adventure',
          name: '어드벤처 게임',
          color: Colors.pink,
          icon: Icons.explore
      ),
    ];
  }
  
  static GameItem? getGameById(String id) {
    return getAllGames().firstWhere( (game)=> game.id == id);
  }
}