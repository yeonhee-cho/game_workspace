import 'package:flutter/material.dart';
import 'package:game_workspace/models/clothing_item.dart';

class ClothingService {
  static final List<ClothingItem> items = [
    // 0: 헤어 1: 상의 2: 하의 3: 신발 4: 악세사리
    // 헤어 (type: 0)
    // ClothingItem(id: id, name: name, type: type, color: color)
    ClothingItem('h1', '짦은머리', 0, const Color(0xFF8B4513)),
    ClothingItem('h2', '긴머리', 0, const Color(0xFF000000)),
    ClothingItem('h3', '금발머리', 0, const Color(0xFFFFD700)),

    // 상의 (type: 1)
    ClothingItem('t1', '티셔츠', 1, Colors.blue),
    ClothingItem('t2', '후드티', 1, Colors.green),
    ClothingItem('t3', '긴팔티셔츠', 1, Colors.yellow),

  ];
}