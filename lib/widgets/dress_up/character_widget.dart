import 'package:flutter/material.dart';
import 'package:game_workspace/models/clothing_item.dart';

import '../../constants/game_assets.dart';

  // widget 데이터가 하나인가? ->> 정하기 나름!!
class CharacterWidget extends StatelessWidget {
  final List<ClothingItem?> equipped;
  const CharacterWidget({super.key, required this.equipped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusGeometry.circular(20)
      ),
      child: Stack(
        children: [
          // // 몸통
          // _buildBody(),
          //
          // // 머리
          // _buildHead(),
          //
          // // 헤어 (장착시)
          // if(equipped[0] != null) _buildHair(),
          //
          // // 상의 (장착시)
          // if(equipped[1] != null) _buildTop(),
          //
          // // 하의 (장착시)
          // if (equipped[2] != null) _buildBottom(),
          //
          // // 신발 (장착시)
          // if (equipped[3] != null) _buildShoes(),
          //
          // // 악세사리 (장착시)
          // if (equipped[4] != null) _buildAccessory(),
          // 몸통
          _buildBody(),

          // // 머리
          // _buildHead(),

          // 헤어 (장착시)
          if(equipped[0] != null) _buildHair(),

          // // 상의 (장착시)
          if(equipped[1] != null) _buildTop(),

          // 하의 (장착시)
          if (equipped[2] != null) _buildBottom(),

          // 신발 (장착시)
          if (equipped[3] != null) _buildShoes(),

          // 악세사리 (장착시)
          if (equipped[4] != null) _buildAccessory(),
        ],
      ),
    );
  }
  // 옷 입히기나 캐릭터 세팅의 경우 포지션으로 위치 명확하게 잡아주어야 함

  // // 몸통
  // Widget _buildBody() {
  //   return Positioned(
  //     bottom: 100,
  //     left: 60,
  //     child: Container(
  //       width: 80,
  //       height: 120,
  //       decoration: BoxDecoration(
  //        color: const Color(0xFFFFDBAC),
  //        borderRadius: BorderRadius.circular(40)
  //       ),
  //     ),
  //   );
  // }
  //
  // // 머리
  // Widget _buildHead() {
  //   return Positioned(
  //     top: 40,
  //     left: 50,
  //     child: Container(
  //       width: 100,
  //       height: 100,
  //       decoration: const BoxDecoration(
  //         color: Color(0xFFFFDBAC),
  //         shape: BoxShape.circle
  //       ),
  //     )
  //   );
  // }
  //
  // // 헤어
  // Widget _buildHair() {
  //   return Positioned(
  //       top: 30,
  //       left: 50,
  //       child: Container(
  //         width: 100,
  //         height: 80,
  //         decoration: BoxDecoration(
  //           color: equipped[0]!.color,
  //           borderRadius: const BorderRadius.vertical(
  //             top: Radius.circular(55)
  //           )
  //         ),
  //       )
  //   );
  // }
  //
  // // 상의
  // Widget _buildTop() {
  //   return Positioned(
  //       top: 140,
  //       left: 55,
  //       child: Container(
  //         width: 90,
  //         height: 70,
  //         decoration: BoxDecoration(
  //           color: equipped[1]!.color,
  //           borderRadius: BorderRadius.circular(10)
  //         ),
  //       )
  //   );
  // }
  //
  // // 하의
  // Widget _buildBottom() {
  //   return Positioned(
  //       bottom: 100,
  //       left: 60,
  //       child: Container(
  //         width: 80,
  //         height: 80,
  //         decoration: BoxDecoration(
  //           color: equipped[2]!.color,
  //           borderRadius: BorderRadius.circular(10)
  //         ),
  //       )
  //   );
  // }
  //
  // // 신발
  // Widget _buildShoes() {
  //   return Positioned(
  //       bottom: 20,
  //       left: 65,
  //       child: Row(
  //           children: [
  //             Container(
  //               width: 30,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 color: equipped[3]!.color,
  //                 borderRadius: BorderRadius.circular(15)
  //               ),
  //             ),
  //             const SizedBox(width: 20),
  //             Container(
  //               width: 30,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 color: equipped[3]!.color,
  //                 borderRadius: BorderRadius.circular(15)
  //               ),
  //             )
  //           ],
  //       )
  //   );
  // }
  //
  // // 악세사리
  // Widget _buildAccessory() {
  //     if(equipped[4]!.name.contains('모자')) {
  //       // 모자 그리기
  //       return Positioned(
  //         top: 50,
  //         left: 60,
  //         child: Container(
  //           width: 80,
  //           height: 30,
  //           decoration: BoxDecoration(
  //           color: equipped[4]!.color,
  //           borderRadius: const BorderRadius.vertical(
  //             top: Radius.circular(10)
  //             )
  //           ),
  //         )
  //       );
  //     } else {
  //       // 안경 그리기
  //       return Positioned(
  //           top: 50,
  //           left: 60,
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: 25,
  //                 height: 15,
  //                 decoration: BoxDecoration(
  //                     color: equipped[4]!.color,
  //                     border: Border.all(
  //                       color: equipped[4]!.color,
  //                       width: 2
  //                     )
  //                 ),
  //               ),
  //
  //               Container(
  //                 width: 25,
  //                 height: 15,
  //                 decoration: BoxDecoration(
  //                     color: equipped[4]!.color,
  //                     border: Border.all(
  //                       color: equipped[4]!.color,
  //                       width: 2
  //                     )
  //                 ),
  //               )
  //             ]
  //           )
  //       );
  //     }
  // }

  // 몸통
  Widget _buildBody() {
    return Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          GameAssets.dressUpBody,
          width: 400,
          height: 400,
          fit: BoxFit.cover,
        )
    );
  }

  // 머리
  // Widget _buildHead() {
  //   return Positioned(
  //       top: 40,
  //       left: 50,
  //       child: Container(
  //         width: 100,
  //         height: 100,
  //         decoration: const BoxDecoration(
  //             color: Color(0xFFFFDBAC), shape: BoxShape.circle),
  //       ));
  // }

  // 헤어
  Widget _buildHair() {
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset(
        equipped[0]!.imageAssets,
        width: 400,
        height: 400,
        fit: BoxFit.cover,
      ),
    );
  }

  // 상의
  Widget _buildTop() {
    return Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          equipped[1]!.imageAssets,
          width: 400,
          height: 400,
          fit: BoxFit.cover,
        ));
  }

  // 하의
  Widget _buildBottom() {
    return Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          equipped[2]!.imageAssets,
          width: 400,
          height: 400,
          fit: BoxFit.cover,
        ));
  }

  // 신발
  Widget _buildShoes() {
    return Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          equipped[3]!.imageAssets,
          width: 400,
          height: 400,
          fit: BoxFit.cover,
        ));
  }

  // 악세사리
  Widget _buildAccessory() {
    return Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          equipped[4]!.imageAssets,
          width: 400,
          height: 400,
          fit: BoxFit.cover,
        ));
  }
}