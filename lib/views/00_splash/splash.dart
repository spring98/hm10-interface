import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/utils/constants/kAppBar.dart';
import 'package:hm10_interface/utils/constants/kFont.dart';
import 'package:hm10_interface/views/01_bluetooth_list/bluetooth_list.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  late AppLifecycleState _notification;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    print(_notification);
    if (_notification == AppLifecycleState.resumed) {
      print('resumed');
      init();
    }
  }

  Future<void> init() async {
    if (await checkPermissions()) {
      Get.to(() => const BluetoothList());
    }
  }

  Future<bool> checkPermissions() async {
    await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    // if (await Permission.location.isDenied ||
    //     await Permission.bluetooth.isDenied) {
    //   await [
    //     Permission.bluetooth,
    //     Permission.location,
    //   ].request();
    // }

    if (await Permission.location.isGranted &&
        await Permission.bluetooth.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('앱 권한 확인'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Text('앱 권한사용을 허용하지 않으면 사용할 수 없습니다.'),
                  Text('권한 허용하기 버튼을 눌러 권한을 허용해주세요.'),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await openAppSettings();
              },
              child: Card(
                color: Color(0xFF2073A7),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: 100,
                  child: Text('권한 허용하기',
                      style: k14w400.copyWith(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
