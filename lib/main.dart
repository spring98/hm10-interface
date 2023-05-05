import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/views/00_splash/splash.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return GetMaterialApp(
          home: child,
        );
      },
      child: const Splash(),
    ),
  );
}
