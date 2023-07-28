// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/models/chat_model.dart';
import 'package:hm10_interface/utils/constants/kAppBar.dart';
import 'package:intl/intl.dart';
import '../../../core/view_models/01_bluetooth/bluetooth_view_model.dart';
import '../../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothSerial extends StatefulWidget {
  const BluetoothSerial({Key? key}) : super(key: key);

  @override
  State<BluetoothSerial> createState() => _BluetoothSerialState();
}

class _BluetoothSerialState extends State<BluetoothSerial> {
  final bluetoothViewModel = Get.put(BluetoothViewModel());

  @override
  void initState() {
    super.initState();
    bluetoothViewModel.subscribe();
    bluetoothViewModel.controllersInit();
  }

  @override
  void dispose() {
    super.dispose();
    bluetoothViewModel.controllersDispose();
    bluetoothViewModel.subscribeClear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        50.h - //appbar height
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: kAppBar('Bluetooth Serial'),
      backgroundColor: Color(0xFFBAD1E6),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: GetBuilder<BluetoothViewModel>(builder: (_) {
            return SingleChildScrollView(
              reverse: true,
              controller: _.scrollController,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  for (int i = 0; i < _.chatModelList.length; i++) ...[
                    _chat(i),
                    SizedBox(height: 10.h),
                  ],
                ],
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 5.h, top: 5.h),
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Expanded(
              child: GetBuilder<BluetoothViewModel>(builder: (_) {
                return Container(
                  // width: double.infinity,
                  // width: 100,
                  height: 35.h,
                  child: TextFormField(
                    cursorHeight: 18.h,
                    controller: _.textEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.w),
                      suffixIcon: _.isEditing
                          ? InkWell(
                              onTap: () async {
                                await bluetoothViewModel.write();
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFEF01B),
                                ),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(margin: EdgeInsets.all(5.w)),
                      border: textFieldBorderStyle,
                      enabledBorder: textFieldBorderStyle,
                      focusedBorder: textFieldBorderStyle,
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    onChanged: _.checkEditing,
                  ),
                );
              }),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _chat(int index) {
    return GetBuilder<BluetoothViewModel>(builder: (_) {
      double? chatWidth;
      if (_.chatModelList[index].chat.length > 37) {
        chatWidth = 240.w;
      }

      if (_.chatModelList[index].isUser) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(child: Text(_.chatModelList[index].time)),
            SizedBox(width: 5.w),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _.chatModelList[index].isUser
                    ? Color(0xFFFEF01B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: SizedBox(
                width: chatWidth,
                child: Text(_.chatModelList[index].chat),
              ),
            ),
            SizedBox(width: 10),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 10),
            Column(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'images/hm10.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: Text(_.chatModelList[index].userName)),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: SizedBox(
                    width: chatWidth,
                    child: Text(_.chatModelList[index].chat),
                  ),
                ),
              ],
            ),
            SizedBox(width: 5.w),
            Container(child: Text(_.chatModelList[index].time)),
          ],
        );
      }
    });
  }

  final textFieldBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.sp)),
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );
}
