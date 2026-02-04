import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_workspace/common/constants.dart';

import '../models/user.dart';

class UserService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    )
  );

  // 1. 모든 사용자 가져오기
  Future<List<User>> getAllUsers() async {
    try {
      final response = await _dio.get("/users");
      final List<dynamic> data = response.data;

      // JSON을 User 객체로 변환
      return data.map((json) => User.fromJson(json)).toList();
    } catch(e) {
      print("사용자 목록 조회 실패 : $e");
      throw Exception("사용자 목록을 가져올 수 없습니다.");
    }
  }

  // 2. 특정 사용자 가져오기 완성하기
  // return null
  // get 에 대한 미래의 결과 자료형으로 User 라는 객체 형태의 결과 자료형을 사용할 것인데
  // return null 결과 데이터가 없을 수 있다.
  // -> 자료형 User 에다가 ? 를 사용하여
  // 미래 결과로 User 클래스 자료형 형태로 데이터를 전달 받아 프론트엔드에서 사용할 것인데
  // User?를 넣어주어 데이터가 없을 경우 null 형태로 데이터 결과를 사용하겠다.
  // A value of type 'Null' can't be returned from the method 'getUserById' because it has a return type of 'Future<User>'.
  // -> Future<User?> 넣어줌
  Future<User?> getUserById(String userId) async {
    try {
      final response = await _dio.get("/users/$userId");

      // JSON을 User 객체로 변환
      return User.fromJson(response.data);
    } catch(e) {
      // controller 에서 조회한 데이터가 없을 수도 있고, 서버 연결 실패할 수 있다.
      print("사용자 목록 조회 실패 : $e");
      return null;
    }
  }
  /* 프로필 이미지 업데이트 */
  Future<String?> uploadProfileImage(String userId, File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last; // 파일이름이 시작되는 / 부터 끝까지 확인하여 파일이름 가져오겠다.
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName
        )
      });

      final response = await _dio.post('/users/$userId/profile-image', data: formData);

      if(response.statusCode == 200) {
        return response.data['profileImageUrl'];
      }
      return null;
    } catch (e) {
      print('프로필 이미지 업로드 실패 $e');
      return null;
    }
  }

  // 새 사용자 생성
  Future<bool> createUser(User user) async {
    try {
      final response = await _dio.post('/users', data: user.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print('사용자 생성 실패 $e');
      return false;
    }
  }
}