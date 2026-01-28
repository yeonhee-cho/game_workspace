import 'package:freezed_annotation/freezed_annotation.dart';
/*
'user.freezed.dart';
 -> copyWith, ==, hashCode, toString 과 같은 유틸리티 메서드 자동 생성해서 사용

'user.g.dart';
 -> models 에서 만들어 사용했던 fromJson, toJson 형태의 변환용 model

이 상태로  User.dart 을 service 나 provider screen widget 등 에서 사용하면 된다
 */
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
//        with _$User Mixin : freezed 가 자동 생성한 기능을 사용하겠다 의미
// _ = private $ = 변수명칭
class User with _$User {
  // const = 상수 = 불변
  // factory = 객체 생성자  factory 는 만약에 캐시 데이터에 객체가 존재하면 그 객체를 사용하겠다.
  // 와 같이 유연하게 존재하면 존재하는 데이터 사용하고, 없으면 객체를 새로 생성하는 생성자
  const factory User({
    required String userId,
    required String userName,
    required String email,
    String? profileImageUrl,
    DateTime? createdAt}) = _User; // = _User 실제 생성되는 클래스의 이름
  // json 변환 기능 만들겠다.                         Json을 User 객체로 변환하는 함수 user.g.dart 자동 생성됨
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
/*
class User {
  final String userId;
  final String userName;
  final String email;
  final String? profileImageUrl; // 데이터가 없으면 null oK
  final DateTime? createdAt;

  User({required this.userId,
    required this.userName,
    required this.email,
    this.profileImageUrl, // 유저 데이터에서 프로필 이미지가 없을 수 있다.
    this.createdAt});     // 유저 데이터에서 유저 생성할 때 백엔드로 유저 생성일자는 null 데이터로 전달하여
                         // 데이터 베이스에서 유저가 저장되는 시간일자를 알아서 작성
}
 */