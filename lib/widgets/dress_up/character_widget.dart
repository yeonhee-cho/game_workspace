import 'package:flutter/material.dart';
import 'package:game_workspace/models/clothing_item.dart';

  // widget 데이터가 하나인가? ->> 정하기 나름!!
class CharacterWidget extends StatelessWidget {
  final List<ClothingItem?> equippend;
  const CharacterWidget({super.key, required this.equippend});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusGeometry.circular(20)
      ),
      child: Stack(
        children: [
          // 몸통
          _buildBody(),

          // 머리
          _buildHead(),

          // 헤어 (장착시)
          if(equippend[0] != null) _buildHair(),
          // 상의 (장착시)
          // 하의 (장착시)
          // 신발 (장착시)
          // 악세사리 (장착시)
        ],
      ),
    );
  }
  // 옷 입히기나 캐릭터 세팅의 경우 포지션으로 위치 명확하게 잡아주어야 함

  // 몸통
  Widget _buildBody() {
    return Positioned(
      bottom: 100,
      left: 60,
      child: Container(
        width: 80,
        height: 120,
        decoration: BoxDecoration(
         color: const Color(0xFFFFDBAC),
         borderRadius: BorderRadius.circular(40)
        ),
      ),
    );
  }

  // 머리
  Widget _buildHead() {
    return Positioned(
      top: 40,
      left: 50,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
            color: Color(0xFFFFDBAC),
            shape: BoxShape.circle
        ),
      )
    );
  }

  // 헤어
  Widget _buildHair() {
    return Positioned(
        top: 30,
        left: 45,
        child: Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
              color: equippend[0]!.color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(55)
              )
          ),
        )
    );
  }
}