// // ignore_for_file: avoid_print
//
// import 'dart:convert';
// import 'package:cheong_joo/core/services/specimen/specimen_service.dart';
// import 'package:cheong_joo/models/data_model.dart';
// import 'package:cheong_joo/models/specimen_model.dart';
// import 'package:cheong_joo/utils/constants/kAlert.dart';
// import 'package:cheong_joo/utils/constants/kSnackBar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class LookupViewModel extends GetxController {
//   final SpecimenService _specimenService = SpecimenService();
//
//   String path = '';
//
//   int dateOffset = 0;
//   DateTime historyNow = DateTime.now();
//
//   List<String> siteList = [];
//   String currentSite = '테스트 현장';
//
//   String inputSite = '';
//   String inputMaterial = '공시체 종류';
//   String inputMaterialCount = '공시체 갯수';
//
//   int selectIndex = 0;
//
//   void updateSelectIndex(int index) {
//     selectIndex = index;
//   }
//
//   void updateInputMaterial(String value) {
//     inputMaterial = value;
//   }
//
//   void updateInputMaterialCount(String value) {
//     inputMaterialCount = value;
//   }
//
//   void updateDateOffset(int i) {
//     dateOffset = dateOffset + i;
//     update();
//   }
//
//   void updatePath(String path) {
//     this.path = path;
//   }
//
//   void updateInputSite(String value) {
//     inputSite = value;
//     update();
//   }
//
//   Future<List<String>> fetchSiteList() async {
//     siteList = [];
//     String result = await _specimenService.fetchSiteList();
//     print('❤️');
//     var resultList = jsonDecode(result)['result'];
//     for (int i = 0; i < resultList.length; i++) {
//       siteList.add(resultList[i]['PLACE_NAME']);
//       print(i);
//     }
//     // currentSite = siteList[0];
//     return siteList;
//   }
//
//   List<DataModel> specimenList = [];
//   Future<List<DataModel>> fetchSpecimenList() async {
//     specimenList = [];
//     String result = await _specimenService.fetchSpecimenList(currentSite);
//     print('❤️');
//     var resultList = jsonDecode(result)['result'];
//     for (int i = 0; i < resultList.length; i++) {
//       specimenList.add(DataModel.fromJson(resultList[i]));
//       print('🤬');
//       print(specimenList);
//       print(i);
//     }
//     return specimenList;
//   }
//
//   Future<void> postData(DateTime now) async {
//     if (path.isEmpty) {
//       alert('카메라 캡쳐가 필요합니다.');
//     } else {
//       await _specimenService.postData(
//         path: path,
//         placeName: inputSite + '_' + DateFormat('yyyy.MM.dd.hh.mm').format(now),
//         address: inputSite,
//         material: inputMaterial,
//         materialCount: inputMaterialCount,
//       );
//       // alert('이미지를 성공적으로 전송하였습니다.');
//       // snackBar('이미지를 성공적으로 전송하였습니다.');
//     }
//   }
//
//   Future<List<DataModel>> fetchSpecimenListWithDate(String date) async {
//     specimenList = [];
//     String result = await _specimenService.fetchSpecimenListWithDate(date);
//     // print('❤️');
//
//     try {
//       // print(1);
//       // 최초의 JSON 가져오기
//       var resultList = jsonDecode(result)['result'];
//       // print(2);
//       print('resultList.length ${resultList.length}');
//       // result 안의 list 개수 만큼 반복
//       for (int i = 0; i < resultList.length; i++) {
//         // ANALYSIS_RESULT 안의 specimen 데이터 따로 가져오기
//         List<dynamic> specimens = resultList[i]['ANALYSIS_RESULT']['specimen'];
//         List<SpecimenModel> list = [];
//         for (int j = 0; j < specimens.length; j++) {
//           SpecimenModel specimenModel = SpecimenModel.fromJson(specimens[j]);
//           list.add(specimenModel);
//         }
//         print('list : $list');
//         DataModel dataModel = DataModel.fromJson(resultList[i]);
//         // print('⚽️');
//         dataModel.specimenModels = list;
//         // print('🏀');
//         specimenList.add(dataModel);
//         print('index $i');
//       }
//       // print(3);
//     } catch (err, e) {
//       print(err);
//       print(e);
//     }
//     return specimenList;
//   }
//
//   Future<void> deleteSpecimenWithID(String id) async {
//     String result = await _specimenService.deleteSpecimenWithID(id);
//     String resultList = jsonDecode(result)['status'];
//
//     if (resultList == '200') {
//       if (await alert('성공적으로 삭제하였습니다.') == 'yes') {
//         update();
//       }
//     } else {
//       if (await alert('삭제에 실패하였습니다.') == 'yes') {
//         update();
//       }
//     }
//   }
// }
