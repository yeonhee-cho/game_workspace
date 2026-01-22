// lib/common/env_config.dart
// 환경 설정 파일 (선택 과제)

import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
 * EnvConfig 클래스 작성
 *
 * 필수 getter들:
 * - apiBaseUrl: .env 파일에서 'API_BASE_URL' 읽어오기, 없으면 'http://localhost:8080/api'
 * - environment: .env 파일에서 'ENVIRONMENT' 읽어오기, 없으면 'development'
 *
 * 추가 getter들:
 * - isDevelopment: environment가 'development'인지 확인
 * - isDebugMode: isDevelopment와 동일
 *
 * 메서드:
 * - printEnvInfo(): 환경 정보를 콘솔에 출력
 *   (isDebugMode가 true일 때만 출력)
 */
class EnvConfig {
  // apiBaseUrl getter 작성하기
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080/api';

  // environment getter 작성하기
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  // isDevelopment getter 작성하기
  static bool get isDevelopment => environment == 'development';
  static bool get isDebugMode => isDevelopment;

  static void printEnvInfo() {
    // isDebugMode getter 작성하기
    if(!isDebugMode) return;

    // printEnvInfo() 메서드 작성하기
    print('======= 환경 설정 =======');
    print('Environment: $environment'); // Environment: development
    print('API URL:: $apiBaseUrl'); // API URL: http://localhost:8080/api
    print('========================")');
  }
}