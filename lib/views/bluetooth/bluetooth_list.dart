// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import 'bluetooth_write.dart';

class BluetoothList extends StatefulWidget {
  const BluetoothList({Key? key}) : super(key: key);

  @override
  State<BluetoothList> createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> _connection;
  Map<String, String> deviceMap = <String, String>{};
  bool isConnected = false;

  // mac 98 D3 41 FD 8C 4C

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
                        child: Text('기타..만들기..?'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        flutterReactiveBle.scanForDevices(
                            withServices: [],
                            scanMode: ScanMode.lowLatency).listen((device) {
                          deviceMap[device.id] = device.name;

                          setState(() {});
                        }, onError: (e) {
                          print(e.toString());
                        });
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
    return Column(
      children: [
        for (String key in deviceMap.keys) ...[
          card(key),
        ]
      ],
    );
  }

  Widget card(String deviceId) {
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
              Constants.deviceID = deviceId;
              Constants.deviceNAME = deviceMap[deviceId].toString();
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
                        deviceMap[deviceId].toString() == ''
                            ? '몰라요'
                            : deviceMap[deviceId].toString(),
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
              Constants.deviceID = deviceId;
              Constants.deviceNAME = deviceMap[deviceId].toString();
              _connection = flutterReactiveBle
                  .connectToDevice(
                id: Constants.deviceID,
                connectionTimeout: const Duration(seconds: 2),
              )
                  .listen((connectionState) {
                print('c ${connectionState.connectionState.name}');
                if (connectionState.connectionState.name == 'connected') {
                  isConnected = true;
                  Get.to(() => BluetoothWrite());
                }
              }, onError: (Object error) {
                print(error);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (isConnected && (Constants.deviceID == deviceId))
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
              _connection.cancel();
              isConnected = false;
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (isConnected && (Constants.deviceID == deviceId))
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
  }
}
