// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// const secureStorage = FlutterSecureStorage();
//
// Future<void> setAccessToken(String accessToken) async {
//   String key = 'ACCESS_TOKEN';
//   String value = accessToken;
//
//   await secureStorage.write(
//     key: key,
//     value: value,
//   );
// }
//
// Future<String> getAccessToken() async {
//   String? accessToken = await secureStorage.read(key: 'ACCESS_TOKEN');
//   if (accessToken != null) {
//     return accessToken;
//   } else {
//     return '';
//   }
// }
//
// Future<void> setRefreshToken(String refreshToken) async {
//   String key = 'REFRESH_TOKEN';
//   String value = refreshToken;
//
//   await secureStorage.write(
//     key: key,
//     value: value,
//   );
// }
//
// Future<String> getRefreshToken() async {
//   String? refreshToken = await secureStorage.read(key: 'REFRESH_TOKEN');
//   if (refreshToken != null) {
//     return refreshToken;
//   } else {
//     return '';
//   }
// }
//
// void setIsAutoLogin(String isAutoLogin) async {
//   String key = 'IS_AUTOLOGIN';
//   String value = isAutoLogin;
//
//   await secureStorage.write(
//     key: key,
//     value: value,
//   );
// }
//
// Future<String> getIsAutoLogin() async {
//   String? isAutoLogin = await secureStorage.read(key: 'IS_AUTOLOGIN');
//   if (isAutoLogin != null) {
//     return isAutoLogin;
//   } else {
//     return '';
//   }
// }
