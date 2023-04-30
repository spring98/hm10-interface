// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'kColor.dart';
import 'kFont.dart';

Future<dynamic> alert(String contents) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 145.h,
          child: Column(
            children: [
              Container(
                color: Color(0xFF2073A7),
                alignment: Alignment.center,
                height: 39.h,
                child: Text('알림', style: k14w500.copyWith(color: Colors.white)),
              ),
              Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: 1.h),
              Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                alignment: Alignment.center,
                height: 70.h,
                child: Text(contents, style: k14w500),
              ),
              GestureDetector(
                onTap: () {
                  Get.back(result: 'yes');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF4F4F4F),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text('확인',
                      style: k12w500.copyWith(color: Color(0xFF4F4F4F))),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertYesOrNo(String contents) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 145.h,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 39.h,
                child: Text('알림', style: k14w500),
              ),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                alignment: Alignment.center,
                height: 70.h,
                child: Text(contents, style: k14w500),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: 'yes');
                      },
                      child: Container(
                        color: kColorPrimary,
                        alignment: Alignment.center,
                        height: 35.h,
                        child: Text('확인',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: 'no');
                      },
                      child: Container(
                        color: Colors.grey,
                        alignment: Alignment.center,
                        height: 35.h,
                        child: Text('취소',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertYesOrNoTwoRow(String contents1, String contents2) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 145.h,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: Color(0xFF2073A7),
                height: 39.h,
                child: Text('알림', style: k14w500.copyWith(color: Colors.white)),
              ),
              Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: 1.h),
              SizedBox(
                height: 70.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      alignment: Alignment.center,
                      child: Text(contents1, style: k14w500),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      alignment: Alignment.center,
                      child: Text(contents2, style: k14w500),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: 'yes');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Color(0xFF4F4F4F),
                            ),
                            right: BorderSide(
                              width: 1,
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        height: 35.h,
                        child: Text(
                          '확인',
                          style: k12w500.copyWith(
                            color: Color(0xFF4F4F4F),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: 'no');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        child: Text(
                          '취소',
                          style: k12w500.copyWith(
                            color: Color(0xFF4F4F4F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertBackPressed() {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 155.h,
          width: 300.w,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 39.h,
                  width: 40.w,
                  child: Text('알림', style: k12w400)),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              Container(
                alignment: Alignment.center,
                height: 80.h,
                child: Text('정말로 종료 하시겠습니까?', style: k12w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child: Container(
                        color: kColorPrimary,
                        alignment: Alignment.center,
                        width: 100.w,
                        height: 35.h,
                        child: Text('확인',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.grey,
                        alignment: Alignment.center,
                        width: 100.w,
                        height: 35.h,
                        child: Text('취소',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertHistoryDetail(
  String contents, {
  //   required String site,
  // required String material,
  // required int materialCount,
  // required int timeCost,
  // required String analysis,
  // required String inputImage,
  // required String analImage,
  required String image,
}) {
  return Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color(0xFF2073A7),
              alignment: Alignment.center,
              height: 39.h,
              child:
                  Text(contents, style: k14w500.copyWith(color: Colors.white)),
            ),
            Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                height: 1.h),

            /// 40

            Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              alignment: Alignment.center,
              // height: 205.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 300.w,
                    // height: 190.h,
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Get.back(result: 'yes');
              },
              child: Container(
                // color: Colors.yellow,
                alignment: Alignment.center,
                height: 35.h,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF4F4F4F),
                      width: 1,
                    ),
                  ),
                ),
                child: Text('확인',
                    style: k12w500.copyWith(color: Color(0xFF4F4F4F))),
              ),
            )
          ],
        ),
      ),
      barrierDismissible: false);
}
