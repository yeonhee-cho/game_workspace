import 'package:flutter/material.dart';
import 'package:game_workspace/models/game_item.dart';
import 'package:game_workspace/models/user.dart';
import 'package:game_workspace/services/user_service.dart';
import 'package:go_router/go_router.dart';

import '../models/user.dart';

class UserListScreen extends StatefulWidget {
  final String gameId;
  final GameItem? gameItem;
  const UserListScreen({super.key, required this.gameId, required this.gameItem});

  @override
  State<StatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState(); // 기존에 플러터 개발자가 만들어 놓은 초기 세팅 포함하여
    // 개발자가 만들어놓은 기능 추가 + 화면 시작하자마자 사용자 목록 불러오기
    loadUsers();
  }

  // 사용자 목록 불러오는 기능
  // Future<void> loadUsers() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  // }
  // -> 화살표 함수 형태로 변환
  Future<void> loadUsers() async {
    setState(() => isLoading = true);

    try {
      final result = await UserService.getAllUsers(); // 백엔드에서 데이터를 가져오기
      // 데이터 성공적으로 가져왔다면 UI 상태 변경 진행
      setState(() {
        // result 변수에서 작동한 결과 모델과 users 변수 에서 선언한 모델 타입이  //TODO
        users = result; // 유저 정보에 백엔드에서 가져온 결과 데이터로 변경 처리
        isLoading = false;// 로딩 해지
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("오류: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("사용자 목록"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
          : users.isEmpty // 로딩상태는 아니지만 로딩 결과 존재하는 유저가 없을 때
        ? const Center(child: Text("사용자가 없습니다."))
          : ListView.builder( // ListView 목록을 DB에서 가져와서 만들 때는
        itemCount: users.length, // 반드기 DB에서 조회되는 총 데이터의 개수를 ui에 알려주기
        itemBuilder: (context, index) { // 데이터가 존재하면 생성하겠다.(현재 scaffold 위치에서, 0번부터 순서대로 배치)
          final user = users[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              // 프로필 이미지
              leading: CircleAvatar(
                radius: 30,
                // The getter 'profileImageUrl' isn't defined for the type 'User'. (문서)
                // Try importing the library that defines 'profileImageUrl', correcting the name to the name of an existing getter, or defining a getter or field named 'profileImageUrl'.
                // 1. user.dart 에서 선언한 변수명칭이 일치하는지 확인
                // String? profileImageUrl,
                // import 'package:game_workspace/models/User.dart';
                // model 작성되어있는 경로나 클래스 명칭이 다르다면 문제 발생
                // 이미지가 존재하지 않을 경우, 대체할 기본 이미지 assets 에 추가 후 '' 에셋 //TODO
                backgroundImage: NetworkImage(user.profileImageUrl ?? ''),
              ),

              title: Text(user.userName),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.arrow_forward_ios),
              // 클릭하면 프로필 화면으로 이동
              onTap: () {
                context.go('/users/${user.userId}', extra: user);
              }
            ),
          );
        },
      )
    );
  }
}