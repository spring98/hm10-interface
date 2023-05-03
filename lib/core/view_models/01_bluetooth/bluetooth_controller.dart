import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/utils/constants/kAlert.dart';
import 'package:hm10_interface/views/home.dart';

import '../../../views/bluetooth/bluetooth_write.dart';

enum BluetoothStatus {
  CONNECT,
  DISCONNECT,
}

class BluetoothController extends GetxController {
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> connection;
  Map<String, String> deviceMap = <String, String>{};

  String deviceId = '';
  String deviceName = '';
  String deviceService = '0000ffe0-0000-1000-8000-00805f9b34fb';
  String deviceCharacteristic = '0000ffe1-0000-1000-8000-00805f9b34fb';

  BluetoothStatus status = BluetoothStatus.DISCONNECT;

  // mac 98 D3 41 FD 8C 4C

  void scan() {
    flutterReactiveBle.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      deviceMap[device.id] = device.name;
      update();
    }, onError: (e) {
      alert(e.toString());
    });
  }

  void connect() {
    connection = flutterReactiveBle
        .connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((connectionState) {
      if (connectionState.connectionState.name == 'connected') {
        status = BluetoothStatus.CONNECT;
        update();
        Get.to(() => Home());
      }
    }, onError: (Object error) {
      alert(error.toString());
    });
  }

  void disconnect() {
    status = BluetoothStatus.DISCONNECT;
    connection.cancel();

    update();
  }

  void select(String deviceId) {
    this.deviceId = deviceId;
    deviceName = deviceMap[deviceId].toString();
  }
}
