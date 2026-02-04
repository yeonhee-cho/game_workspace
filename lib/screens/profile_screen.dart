import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_workspace/models/user.dart';
import 'package:game_workspace/providers/user_provider.dart';
import 'package:game_workspace/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget{
  final String? userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  // 아래 변수들도 삭제 필요 삭제 가능한 변수들, 나중에 유저 정보를 provider 에서 상태 관리하게 된다면 굳이 사용하지 않아도 됨
  // 관리자 페이지라면 사용해야하는 변수들
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
    /*
    로그인 한 유저 정보를 provider 에서 상태관리하며 불러와야할 경우 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUser(widget.userId);
    });
    */
  }

  // 프로필 변경할 때는 필요없음..! 하위 기능은 삭제하는 것이 좋음
  // 선택한 유저 정보 불러오기 / 관리자 스크린에서만 쓸 법 한 기능
  // 관리자는 모든 유저들 목록을 보고 조회 가능!
  // 나중에는 지우기
  Future<void> loadUser() async {
    if(widget.userId == null)
      return; // 만약 로그인한 유저 정보가 위젯에 존재한다면 이 기능을 사용하지 않을 것입니다!

    setState(() => isLoading = true);

    try {
      // 유저 서비스에서 유저 정보 가져오기 시도
      final userService = UserService();
      final result = await userService.getUserById(widget.userId!);
      // 제대로 유저 정보를 가져오면 가져온 결과를 user 객체에 맞춰 추가
      // 로딩 해지
      setState(() {
        user = result;
        isLoading = false;
      });
    } catch (e) {
      // 가져오던 중 문제가 발생하면
      // 우선 로딩 해제
      setState(() => isLoading = false);
      // 현재 screen 에서 유저 정보를 가져오는데 오류가 발생했다 표기
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('오류 : $e')));
      }
    }
  }

  Future<void> _pickImage() async {
    // final ImagePicker _picker = ImagePicker();
    // ImagePicker 이미지를 선택하는 도구
    // .pickImage() 이미지를 선택하는 기능
    // ImageSource 어디서 이미지를 가져올지 선택
    // .gallery() 갤러리 사진첩에서 선택
    // .camera() 카메라로 찍기
    // XFile 선택된 파일 정보를 담는 객체
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // 갤러리에서 선택
      maxWidth: 200, // 최대 가로 px
      maxHeight: 200 // 최대 세로 px
    );

    if(image != null) {
      setState(() => isLoading = true);
      /*
      마찬가지로 로그인 한 유저의 프로필 상태를 가져올 때 사용
      final success = await context
          .read<UserProvider>()
          .updateProfileImage(widget.userId, File(image.path));
      */
      
      /*
      TODO try catch 를 이용해서 프로필 이미지 변경 uploadProfileImage 로 교체
      .copyWith 사용
      */
      try {
        final userService = UserService();
        final imageUrl = await userService.uploadProfileImage(widget.userId!, File(image.path));

        if(imageUrl != null && user != null) {
          setState(() {
            user = user!.copyWith(profileImageUrl: imageUrl);
            isLoading = false;

            if(mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('업데이트 완료')));
            }
          });
        } else {
          if(mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('업로드 실패')));
          }
        }
      } catch (e) {
        setState(()  => isLoading = false);
        if(mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('오류 $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(user!.profileImageUrl!), // null ok
                      
                      // 이미지가 존재하지 않는다면 아이콘으로 대체
                      // 이미지가 존재하면 null 로 처리
                      child: user!.profileImageUrl == null 
                          ? Icon(Icons.person) 
                          : null,
                    ),
                    Positioned(
                      // 아무런 값을 주지 않으면
                      // 현재 stack 위치에서 왼쪽 맨 위 배치
                      // left top right bottom 형태로 하여 카메라 모양 위치 변경
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, width: 2
                            )
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                user!.userName,
                style: const TextStyle(
                  fontSize: 24
                ),
              ),
              // ************************************
              const SizedBox(height: 24),
              Text(
                user!.email,
                style: const TextStyle(
                    fontSize: 24
                ),
              ),
              const SizedBox(height: 24),
              Text(
                user!.userId,
                style: const TextStyle(
                    fontSize: 24
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Icon(
                        Icons.info_outline,
                        color: Colors.blue[700]
                    ),
                    SizedBox(width: 12),
                    Expanded(child: Text(
                      '프로필 이미지를 클릭하여 변경할 수 있습니다.',
                      style: TextStyle(
                          color: Colors.blue[700]
                      ),
                    )),
                  ],
                )
              ),
            ],
          ),
        ),
      )
      /*
      Consumer<UserProvider>
      (
        builder: (context, provider, child){
          if(provider.isLoading && provider.currentUser == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = provider.currentUser;
          if(user = null) {
            return Center(child: Text('사용자를 찾을 수 없습니다.'));
          }
        },

      ),
      */
    );
  }

}