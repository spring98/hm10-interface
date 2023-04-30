// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'kFont.dart';

PreferredSizeWidget kAppBar(String title) {
  return AppBar(
    backgroundColor: Color(0xFF2073A7),
    automaticallyImplyLeading: false,
    title: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: k18w600_roboto.copyWith(color: Colors.white),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     GestureDetector(
        //       onTap: () {
        //         Get.back();
        //       },
        //       child: Icon(Icons.arrow_back_ios, color: Colors.black),
        //     ),
        //   ],
        // )
      ],
    ),
    bottom: PreferredSize(
      child: Container(
        // color: Colors.blue,
        color: Colors.transparent,
        height: 1.5.h,
      ),
      preferredSize: Size.fromHeight(0.h),
    ),
    elevation: 0.0,
  );
}

PreferredSizeWidget kAppBarHome(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Stack(
      children: [
        // Image.asset('images/HomeSunghaLogo.png'),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: k16w500.copyWith(color: Color(0xFF3F3F3F)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     // Get.to(AlertPage());
            //   },
            //   child: SizedBox(
            //     width: 24.w,
            //     height: 25.w,
            //     child: Image.asset('images/CircleBell.png', fit: BoxFit.fill),
            //   ),
            // ),
            SizedBox(width: 5.w),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(MyPage());
            //   },
            //   child: SizedBox(
            //     width: 25.w,
            //     height: 25.w,
            //     child: Image.asset('images/HomeMyPage.png', fit: BoxFit.fill),
            //   ),
            // ),
          ],
        ),
      ],
    ),
    bottom: PreferredSize(
      child: Container(
        color: Colors.blue,
        height: 1.5.h,
      ),
      preferredSize: Size.fromHeight(0.h),
    ),
    elevation: 0.0,
  );
}

PreferredSizeWidget kAppBarNoBack(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: k16w500.copyWith(color: Color(0xFF3F3F3F)),
          ),
        ),
      ],
    ),
    bottom: PreferredSize(
      child: Container(
        color: Colors.blue,
        height: 1.5.h,
      ),
      preferredSize: Size.fromHeight(0.h),
    ),
  );
}
