import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_workspace/models/game_item.dart';

class CalendarScreen extends StatelessWidget{
  final String gameId;
  final GameItem? gameItem;

  const CalendarScreen({super.key, required this.gameId, this.gameItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캘린더'),  // 화면 제목
        backgroundColor: Colors.blue,  // 색상
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black87)
          ),
          child: CalendarDatePicker(initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              onDateChanged: (DateTime date){
                // 날짜 선택시 할 동작
              }),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('메뉴'),  // 메뉴 제목
            ),
            ListTile(
              title: const Text(''),  // 첫 번째 메뉴 이름
              onTap: () {},
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 나중에 채울 거에요
        },
        child: const Icon(Icons.add),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',  // 첫 번째 탭 이름
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '캘린더',  // 두 번째 탭 이름
          ),
        ],
      ),

      endDrawer: const Drawer(
        child: Text('오른쪽 메뉴'),
      ),

    );
  }

}