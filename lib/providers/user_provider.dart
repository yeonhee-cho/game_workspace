/* 현재 상태 관리 -> 모두에게 적용하는 시스템 */
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:game_workspace/models/user.dart';
import 'package:game_workspace/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  // 자바로 치면 person 객체 하나 인스턴스 생성
  // final private Person person = new Person();
  final UserService _userService = UserService();

  User? _currentUser;
  List<User> _allUsers = [];
  bool _isLoading = false;
  
  // 모델에서 가져온 유저 정보 전달
  User? get currentUser => _currentUser;
  List<User> get allUsers => _allUsers;
  bool get isLoading => _isLoading;

  // 새로운 유저가 추가된다면 추가된 유저 정보 DB에서 다시 업데이트하여 상태 관리
  Future<void> loadAllUsers() async {
    _isLoading = true;
    notifyListeners();
    // static
    // 만약에 getAllUsers() 가 static 모두가 사용할 수 있게 static 형태로 선언되어있다면
    // 인스턴스형태로 호출하여 사용불가
    // 위와 같이 static 을 붙여서 작성하길 원한다면
    // _allUsers = await UserService.getAllUsers(); 이렇게 직접적으로
    // UserService 에서 호출하겠다 작성해야한다.
    _allUsers = await _userService.getAllUsers();

    _isLoading = false;
    notifyListeners();
  }
  // 로그인 한다면 현재 유저 정보를 가져와서 적용하는 상태 관리
  Future<void> loadUser(String userId) async {
    _isLoading = true;
    _currentUser = await _userService.getUserById(userId);

    _isLoading = false;
    notifyListeners();
  }

  // 위 loadUser 만으로도 프로필 변경 업데이트된 유저 정보를 호출 할 수 있지만
  // DB에서 유저 정보에 대한 모든 정보를 다시 가져와야 하므로
  // 메모리 소모 / 트래픽 소모를 줄이기 위해서 다른 데이터는 그대로 사용하되 특정 데이터만
  // db에서 호출하여 일부 변경한다라는 구조
  Future<bool> updateProfileImage(String userId, File imageFile) async {
    _isLoading = true;
    notifyListeners();

    final imageUrl = await _userService.uploadProfileImage(userId, imageFile);

    /*
    만들어진 User 클래스는 freezed 로 만들어져서 불변
    한 번 만들어진 객체는 수정할 수 없다.
    user.profileImageUrl = "새로운URL" XXXX 이런식으로 수정을 할 수 없다.

    객체를 새로 만들 때 .copyWith() profileImageUrl 상수 내부만
    현재 imageUrl 로 대체하여 만들 것

    const factory User({
    required String userId,
    required String userName,
    required String email,
    String? profileImageUrl,
    DateTime? createdAt}) = _User;

    만약 .copyWith() 를 사용 안하면 컴퓨터 입장에서는
    User a = new User(
    userId: user.userId,
    userName: user.userName,
    email: user.email,
    profileImageUrl: "새로운 URL",
    createdAt: user.createdAt
    )
    한 번 더 모두 전체 복제
    만약 .copyWith()를 사용한다면
    User b = a.copyWith(
      profileImageUrl: "새로운 URL",
    )
    a에 있던 기존 데이터를 그대로 복제하고, url 만 교체
    */

    if (imageUrl != null && _currentUser != null) {
      _currentUser = _currentUser!.copyWith(profileImageUrl: imageUrl);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
