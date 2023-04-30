// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:daum_postcode_search/daum_postcode_search.dart';
//
// class SearchingPage extends StatefulWidget {
//   @override
//   _SearchingPageState createState() => _SearchingPageState();
// }
//
// class _SearchingPageState extends State<SearchingPage> {
//   bool _isError = false;
//   String? errorMessage;
//
//   @override
//   Widget build(BuildContext context) {
//     DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
//       onConsoleMessage: (_, message) => print(message),
//       onLoadError: (controller, uri, errorCode, message) => setState(
//         () {
//           _isError = true;
//           errorMessage = message;
//         },
//       ),
//       onLoadHttpError: (controller, uri, errorCode, message) => setState(
//         () {
//           _isError = true;
//           errorMessage = message;
//         },
//       ),
//     );
//     return Scaffold(
//       body: Container(
//         color: Colors.grey,
//         child: Padding(
//           padding: EdgeInsets.only(left: 30.w, right: 30.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: 30.h,
//                 child: Stack(
//                   children: [
//                     Align(alignment: Alignment.center, child: Text('주소검색')),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 5.w),
//                         child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Icon(Icons.cancel, color: Colors.white)),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.only(
//                     left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         Text('도로명 '),
//                         Text('주소를 통해 검색합니다. '),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text('건물번호, 번지'),
//                         Text('를 입력하시면 더욱 정확하게 검색됩니다.'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 300.h,
//                 width: 300.w,
//                 child: daumPostcodeSearch,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
