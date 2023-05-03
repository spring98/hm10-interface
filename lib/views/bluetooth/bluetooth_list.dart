// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/core/view_models/01_bluetooth/bluetooth_controller.dart';

class BluetoothList extends StatefulWidget {
  const BluetoothList({Key? key}) : super(key: key);

  @override
  State<BluetoothList> createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  final bluetoothViewModel = Get.put(BluetoothController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
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
                ),
                cardList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardList() {
    return GetBuilder<BluetoothController>(builder: (_) {
      return Column(
        children: [
          for (String key in _.deviceMap.keys) ...[
            card(key),
          ]
        ],
      );
    });
  }

  Widget card(String deviceId) {
    return GetBuilder<BluetoothController>(builder: (_) {
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
                width: 200,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bluetooth),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _.deviceMap[deviceId].toString() == ''
                              ? '알 수 없는 장치'
                              : _.deviceMap[deviceId].toString(),
                        ),
                        Text(deviceId),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
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
                      : Colors.amber,
                ),
                alignment: Alignment.center,
                width: 80,
                height: 50,
                child: Text('연결'),
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
                      ? Colors.amber
                      : Color(0xFFABABAB).withOpacity(0.3),
                ),
                alignment: Alignment.center,
                width: 80,
                height: 50,
                child: Text('해제'),
              ),
            )
          ],
        ),
      );
    });
  }
}
