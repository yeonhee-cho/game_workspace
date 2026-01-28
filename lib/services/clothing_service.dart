import 'package:flutter/material.dart';
import 'package:game_workspace/constants/game_assets.dart';
import 'package:game_workspace/models/clothing_item.dart';

class ClothingService {
  static final List<ClothingItem> items = [
    // 0: 헤어 1: 상의 2: 하의 3: 신발 4: 악세사리
    // 헤어 (type: 0)
    ClothingItem('h1', '모자', 0, GameAssets.dressUpHat1),
    // ClothingItem(id: id, name: name, type: type, color: color)
    // ClothingItem('h1', '짦은머리', 0, const Color(0xFF8B4513)),
    // ClothingItem('h2', '긴머리', 0, const Color(0xFF000000)),
    // ClothingItem('h3', '금발머리', 0, const Color(0xFFFFD700)),

    // 상의 (type: 1)
    ClothingItem('t1', '상의', 1, GameAssets.dressUpClothes1),
    // ClothingItem('t1', '티셔츠', 1, Colors.blue),
    // ClothingItem('t2', '후드티', 1, Colors.green),
    // ClothingItem('t3', '긴팔티셔츠', 1, Colors.yellow),

    // 하의 (type: 2)
    ClothingItem('b1', '가방', 2, GameAssets.dressUpBag1),
    // ClothingItem('b1', '청바지', 2, const Color(0xFF1E3A8A)),
    // ClothingItem('b2', '반바지', 2, Colors.grey),

    // 신발 (type: 3)
    ClothingItem('s1', '신발', 3, GameAssets.dressUpShoes1),
    // ClothingItem('s1', '운동화', 3, Colors.white),
    // ClothingItem('s2', '부츠', 3, Colors.black),

    // 악세사리 (type: 4)
    ClothingItem('a1', '무기', 4, GameAssets.dressUpAcc1),
    // ClothingItem('a1', '모자', 4, Colors.orange),
    // ClothingItem('a2', '안경', 4, Colors.black),
  ];
}