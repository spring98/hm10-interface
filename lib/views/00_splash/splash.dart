import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/views/01_bluetooth_list/bluetooth_list.dart';
import 'package:permission_handler/permission_handler.dart';

import '../02_home/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _getStatuses();
  }

  Future<void> _getStatuses() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
      Permission.locationWhenInUse
    ].request();

    if (await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted &&
        await Permission.bluetoothAdvertise.isGranted &&
        await Permission.bluetooth.isGranted) {
      Get.to(() => const BluetoothList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
