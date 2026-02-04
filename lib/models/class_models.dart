
import 'package:freezed_annotation/freezed_annotation.dart';

/*
freezed 작성 방법

part은 이 파일은 다른 Dart 파일들이랑 한 몸이다.
현재 dart 파일의 코드를 파일 분할하여 작성할 때 사용
아래 구문은
dart run build_runner build --delete-conflicting-outputs
명령어로 아래 파일을 자동 생성 하기 전까지는 빨간 표기로 되어 있는 것이 정상
↓↓↓↓↓↓↓↓↓↓
part 'user.freezed.dart';
part 'user.g.dart';

#pubspec.yaml
dependencies:
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1

# 터미널 창에서 아래와같이 실행 가능
flutter pub add freezed_annotation json_annotation
flutter pub add --dev build_runner freezed json_serializable


# model 만들기 구문
flutter pub run build_runner build --delete-conflicting-outputs
dart run build_runner build --delete-conflicting-outputs

_$ClassModels 은 dio, freezed, retrofit / json_serializable 를 사용할 때 빼고는 작성할 일이 없음

_ 는 private $ -> 변수나 함수, 클래스 이름 표기  ClassModels 은 클래스 이름 표기

part 작성한 코드는 중괄호 내부에 나눠진 코드들이 작성되어 있는 것과 같은 효과로 한 파일 내에서 쓰여지는 형태

*/
/*
@freezed
class ClassModels with _$ClassModels {
  const factory ClassModels({
    required String variableNameOne,
    required String variableNameTwo,
    required String variableNameThree,
    String? variableNameFour,
    DateTime? createdAt}) = _ClassModels;
  factory ClassModels.fromJson(Map<String, dynamic> json) => _$ClassModelsFromJson(json);
}
// 필요한 형태들 모두 생성 json map->json 이 외 변형해야할 모든 경우의 수를 다 생성
*/
/*
part 'user.freezed.dart';
part 'user.g.dart';
이 내부에 작성되어 있는 코드들이 아래 추가로 존재하는 것과 동일한 형태
*/