import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'kColor.dart';
import 'kFont.dart';

InputDecoration kTextFieldUnderLine(String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2073A7)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2073A7)),
    ),
    hintText: hint,
    hintStyle: k14w400.copyWith(color: kColorTextFieldHint),
  );
}

InputDecoration kTextFieldRect(String hint) {
  return InputDecoration(
    contentPadding:
        EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h, bottom: 12.h),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kColorTextField),
      borderRadius: BorderRadius.all(Radius.circular(0.sp)),
      gapPadding: 0,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kColorTextField),
      borderRadius: BorderRadius.all(Radius.circular(0.sp)),
      gapPadding: 0,
    ),
    hintText: hint,
    hintStyle: k14w400.copyWith(color: kColorTextFieldHint),
  );
}

InputDecoration kTextFieldRound(String hint) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding:
        EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h, bottom: 12.h),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(5.sp)),
      gapPadding: 0,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(5.sp)),
      gapPadding: 0,
    ),
    hintText: hint,
    hintStyle: k13w400.copyWith(color: Color(0xFF565656)),
    labelStyle: k13w400.copyWith(color: Color(0xFF565656)),
  );
}

InputDecoration kTextFieldPartialRound(String hint) {
  return InputDecoration(
    contentPadding:
        EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h, bottom: 12.h),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kColorTextField),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.sp),
          bottomLeft: Radius.circular(10.sp),
        ),
        gapPadding: 0),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kColorTextField),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.sp),
          bottomLeft: Radius.circular(10.sp),
        ),
        gapPadding: 0),
    hintText: hint,
    hintStyle: k14w400.copyWith(color: kColorTextFieldHint),
  );
}
