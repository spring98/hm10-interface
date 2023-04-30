// // ignore_for_file: avoid_print, non_constant_identifier_names
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../utils/security/login_secure.dart';
//
// class Session {
//   static String BASEURL = '';
//
//   static String id = '';
//   static String pw = '';
//
//   /// user access token and refresh token
//   static String accessToken = '';
//   static String refreshToken = '';
//
//   static Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json'
//   };
//
//   Future<void> setAccessTokenToHeader() async {
//     String accessToken = await getAccessToken();
//     Session.headers['Authorization'] = 'Bearer $accessToken';
//   }
//
//   Future<void> refreshTokenHandler() async {
//     print('refresh token handler in');
//     String url = Session.BASEURL + 'v1/auth/refresh-tokens';
//     String refreshToken = await getRefreshToken();
//
//     print('기기에 등록 되어 있던 리프레시 토큰 -> $refreshToken');
//     var data = {
//       'refreshToken': refreshToken,
//     };
//     var body = jsonEncode(data);
//
//     print(1111);
//     http.Response response = await http.post(
//       Uri.parse(Uri.encodeFull(url)),
//       headers: Session.headers,
//       body: body,
//     );
//     print(2222);
//     print(response.body);
//     print(Session.headers);
//
//     // access 토큰이 만료되서 refresh 토큰으로 새로 발급해서 앱내에 저장
//     await setAccessToken(jsonDecode(response.body)['access']['token']);
//     await setRefreshToken(jsonDecode(response.body)['refresh']['token']);
//
//     // 새로 발급받은 access 토큰을 Session.accessToken(헤더) 에 저장
//     await setAccessTokenToHeader();
//
//     // 만약 refresh 토큰까지 만료되었다면 로그인을 새로 해달라고 요청한다.
//     if (response.statusCode == 401) {
//       print(3);
//       // 기존 기기에 저장된 토큰을 초기화
//       await setAccessToken('');
//       await setRefreshToken('');
//       return;
//     }
//   }
// }
