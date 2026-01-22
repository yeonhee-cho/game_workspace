import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_workspace/models/game_item.dart';
import 'package:game_workspace/providers/dress_up_provider.dart';
import 'package:game_workspace/widgets/dress_up/character_widget.dart';
import 'package:provider/provider.dart';
/*
models
└─ clothing_item.dart

services
└─ clothing_service.dart

provider
└─ dress_up_provider.dart

widgets/dress_up
└─ character_widget

screen
└─ dress_up_screen
*/

class DressUpScreen extends StatelessWidget{
  final String gameId;
  final GameItem? gameItem;
  const DressUpScreen({super.key, required this.gameId, this.gameItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('옷입히기'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
              onPressed: () {
                context.read<DressUpProvider>().reset();
              },
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: Consumer<DressUpProvider>(
          builder: (context, provider, child) {
            final categories = ['헤어', '상의', '하의', '신발', '악세사리'];
            return Column(
              children: [
                // 캐릭터 영역
                Expanded(
                  child: Container(
                    color: Color(0xFFFFF0F5),
                    child: Center(
                      child: CharacterWidget(
                          equippend: provider.equipped
                      ),
                    ),
                  )
                ),

                // 카테고리 버튼
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 카테고리 버튼 헤어
                      // 카테고리 버튼 상의
                      // 카테고리 버튼 하의
                      // 카테고리 버튼 신발
                      // 카테고리 버튼 악세사리
                    ],
                  ),
                )

                // 해제 버튼

                // 아이템 그리드(아이템 창)
              ],
            );
          }
      ),
    );
  }
}