// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/core/view_models/01_bluetooth/bluetooth_view_model.dart';
import 'package:hm10_interface/utils/constants/kAlert.dart';
import 'package:hm10_interface/utils/constants/kAppBar.dart';
import 'package:hm10_interface/utils/constants/kColor.dart';
import 'package:hm10_interface/views/02_home/01_bluetooth_serial/bluetooth_serial.dart';
import 'package:hm10_interface/views/02_home/02_bluetooth_iot_control/bluetooth_iot_control.dart';
import 'package:hm10_interface/views/02_home/03_reference_codes/reference_codes.dart';
import '../01_bluetooth_list/bluetooth_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bluetoothViewModel = Get.put(BluetoothViewModel());
  List<Color> colors = [
    Color(0xFFBAD1E6),
    Color(0xFFF7E9E4),
    Color(0xFFFFDAB9),
  ];
  Color textColor = Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: kAppBarHome(bluetoothViewModel.deviceName),
        // backgroundColor: Color(0xFFBAD1E6),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.grey,
                  child: Image.asset('images/hm10.png', fit: BoxFit.fill),
                  height: 250.h,
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.all(0),
                        // child: Container(

                        color: colors[0],
                        child: InkWell(
                          onTap: () {
                            Get.to(() => BluetoothSerial());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 120.h,
                            // color: Color(0xFFF3B45F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  height: 50.w,
                                  child: Image.asset('images/message.png',
                                      fit: BoxFit.fill),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('블루투스',
                                        style: TextStyle(
                                            color: textColor, fontSize: 15.sp)),
                                    SizedBox(height: 5.h),
                                    Text('시리얼 통신',
                                        style: TextStyle(
                                            color: textColor, fontSize: 15.sp)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.all(0),
                        // child: Container(
                        color: colors[1],
                        child: InkWell(
                          onTap: () {
                            Get.to(() => BluetoothIotControl());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 120.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.messenger_outlined, color: textColor),
                                SizedBox(
                                  width: 50.w,
                                  height: 50.w,
                                  child: Image.asset('images/joy_stick.png',
                                      fit: BoxFit.fill),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('블루투스',
                                        style: TextStyle(
                                            color: textColor, fontSize: 15.sp)),
                                    SizedBox(height: 5.h),
                                    Text('IoT 컨트롤',
                                        style: TextStyle(
                                            color: textColor, fontSize: 15.sp)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Expanded(
                  child: Card(
                    // child: Container(

                    color: colors[2],
                    margin: EdgeInsets.all(0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ReferenceCodes());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 100.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 50.w,
                                height: 50.w,
                                child: Image.asset('images/audit.png',
                                    fit: BoxFit.fill)),
                            SizedBox(width: 10.w),
                            Text('참고 코드',
                                style: TextStyle(
                                    color: textColor, fontSize: 15.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 0xFFF3B45F
  // 0xFFF39C67
  // 0xFFF2835D
  // 0xFFF26D6F
}
