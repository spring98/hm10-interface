import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/utils/constants/kAppBar.dart';
import 'package:hm10_interface/views/01_bluetooth_list/bluetooth_list.dart';
import 'package:permission_handler/permission_handler.dart';

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
      Permission.location,
    ].request();

    if (await Permission.location.isGranted &&
        await Permission.bluetooth.isGranted) {
      Get.to(() => const BluetoothList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('앱 권한 확인'),
      body: Container(),
    );
  }
}
