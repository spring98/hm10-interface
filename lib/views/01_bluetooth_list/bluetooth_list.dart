// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/core/view_models/01_bluetooth/bluetooth_view_model.dart';
import 'package:hm10_interface/utils/constants/kAppBar.dart';
import 'package:hm10_interface/utils/constants/kFont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothList extends StatefulWidget {
  const BluetoothList({Key? key}) : super(key: key);

  @override
  State<BluetoothList> createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  final bluetoothViewModel = Get.put(BluetoothViewModel(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBarHome('블루투스 찾기', viewModel: bluetoothViewModel),
      // backgroundColor: Color(0xFF9BBBD4),
      body: SafeArea(
        child: Column(
          children: [
            // _scan(),
            _cardList(),
          ],
        ),
      ),
    );
  }

  Widget _cardList() {
    return GetBuilder<BluetoothViewModel>(builder: (_) {
      double height = MediaQuery.of(context).size.height -
          50.h - //appbar height
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom;
      return Container(
        // color: Colors.grey,
        height: height,
        child: ListView.builder(
            itemCount: _.deviceMap.length,
            itemBuilder: (BuildContext context, int i) {
              return card(i);
            }),
      );
    });
  }

  Widget card(int index) {
    return GetBuilder<BluetoothViewModel>(builder: (_) {
      List<String> deviceIdList = _.deviceMap.keys.toList();
      String deviceId = deviceIdList[index];
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          // color: Colors.blue,
          border: Border(
            top: BorderSide(color: Color(0xFFABABAB)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                bluetoothViewModel.select(deviceId);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFABABAB).withOpacity(0.3),
                ),
                alignment: Alignment.center,
                width: 180.w,
                height: 45.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bluetooth),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            _.deviceMap[deviceId].toString() == ''
                                ? '알 수 없는 장치'
                                : _.deviceMap[deviceId].toString(),
                            style: _.deviceMap[deviceId].toString() == ''
                                ? k12w400.copyWith(color: Colors.black45)
                                : k12w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            deviceId,
                            style: _.deviceMap[deviceId].toString() == ''
                                ? k12w400.copyWith(color: Colors.black45)
                                : k12w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              onTap: () {
                bluetoothViewModel.select(deviceId);
                bluetoothViewModel.connect();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ((_.status == BluetoothStatus.CONNECT) &&
                          (_.deviceId == deviceId))
                      ? Color(0xFFABABAB).withOpacity(0.3)
                      : Color(0xFF2073A7),
                ),
                alignment: Alignment.center,
                width: 70.w,
                height: 45.h,
                child: Text(
                  '연결',
                  style: TextStyle(
                    color: ((_.status == BluetoothStatus.CONNECT) &&
                            (_.deviceId == deviceId))
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                bluetoothViewModel.disconnect();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ((_.status == BluetoothStatus.CONNECT) &&
                          (_.deviceId == deviceId))
                      ? Color(0xFF2073A7)
                      : Color(0xFFABABAB).withOpacity(0.3),
                ),
                alignment: Alignment.center,
                width: 70.w,
                height: 45.h,
                child: Text(
                  '해제',
                  style: TextStyle(
                    color: ((_.status == BluetoothStatus.CONNECT) &&
                            (_.deviceId == deviceId))
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _scan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 70,
            color: Color(0xFF51B263).withOpacity(0.3),
            child: Text('기기연결'),
          ),
        ),
        InkWell(
          onTap: () {
            bluetoothViewModel.scan();
          },
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 70,
            color: Color(0xFF51B263),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Text(
                  'scan',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
