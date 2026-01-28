import 'package:flutter/material.dart';
import 'package:game_workspace/constants/game_assets.dart';

import '../models/game_item.dart';

class GameService {
  static List<GameItem> getAllGames() {
    return [
      GameItem(
          id: 'flappy',
          name: '새 충돌 피하기',
          color: Colors.blue,
          imageAsset: GameAssets.birdFluffyLoading
          // icon: Icons.flight
      ),
      GameItem(
          id: 'dressUp',
          name: '옷 입히기',
          color: Colors.red,
          imageAsset: GameAssets.dressUpLogo
          // icon: Icons.gps_fixed
      ),
      // GameItem(
      //     id: 'shooter',
      //     name: '슈팅',
      //     color: Colors.red,
      //     icon: Icons.gps_fixed
      // ),
      GameItem(
          id: 'racing',
          name: '레이싱',
          color: Colors.yellow.shade700,
          icon: Icons.flight
      ),
      GameItem(
          id: 'puzzle',
          name: '퍼즐',
          color: Colors.purple,
          icon: Icons.extension
      ),
      GameItem(
          id: 'arcade',
          name: '아케이드',
          color: Colors.green,
          icon: Icons.sports_esports
      ),
      GameItem(
          id: 'adventure',
          name: '어드벤처',
          color: Colors.pink,
          icon: Icons.explore
      ),
    ];
  }
  
  static GameItem? getGameById(String id) {
    return getAllGames().firstWhere( (game)=> game.id == id);
  }
}