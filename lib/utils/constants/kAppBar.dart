// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/core/view_models/01_bluetooth/bluetooth_view_model.dart';
import 'package:hm10_interface/views/02_home/home.dart';

import 'kFont.dart';

PreferredSizeWidget kAppBar(String title) {
  return AppBar(
    backgroundColor: Color(0xFF2073A7),
    // automaticallyImplyLeading: false,
    toolbarHeight: 50.h,
    title: Text(title, style: k16w400_roboto.copyWith(color: Colors.white)),
    elevation: 3,
  );
}

PreferredSizeWidget kAppBarHome(String title, {BluetoothViewModel? viewModel}) {
  return AppBar(
    backgroundColor: Color(0xFF2073A7),
    automaticallyImplyLeading: false,
    toolbarHeight: 50.h,
    title: Stack(
      children: [
        // Image.asset('images/HomeSunghaLogo.png'),
        Container(
          height: 35.h,
          // color: Colors.yellow,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: k16w400_roboto.copyWith(color: Colors.white),
            ),
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
            viewModel == null
                ? Container()
                : GestureDetector(
                    onTap: () {
                      viewModel.scan();
                      // Get.to(() => Home());
                    },
                    child: Container(
                      // color: Colors.yellow,
                      width: 35.w,
                      height: 35.w,
                      child: Icon(Icons.search),
                    ),
                  ),
          ],
        ),
      ],
    ),
    // bottom: PreferredSize(
    //   child: Container(
    //     color: Colors.blue,
    //     height: 1.5.h,
    //   ),
    //   preferredSize: Size.fromHeight(0.h),
    // ),
    elevation: 3,
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
