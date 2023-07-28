// ignore_for_file: avoid_print, constant_identifier_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/utils/constants/kAlert.dart';
import 'package:intl/intl.dart';
import '../../../models/chat_model.dart';
import '../../../views/02_home/01_bluetooth_serial/bluetooth_serial.dart';
import '../../../views/02_home/home.dart';

enum BluetoothStatus {
  CONNECT,
  DISCONNECT,
}

class BluetoothViewModel extends GetxController {
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> connection;
  StreamSubscription<DiscoveredDevice>? discoveredDeviceStream;
  Map<String, String> deviceMap = <String, String>{};
  late StreamSubscription<List<int>> subscribeInstance;

  String deviceId = '';
  String deviceName = '';
  // String deviceService = '0000ffe0-0000-1000-8000-00805f9b34fb';
  // String deviceCharacteristic = '0000ffe1-0000-1000-8000-00805f9b34fb';
  // String deviceService = 'FFE0';
  // String deviceCharacteristic = 'FFE1';

  String deviceService = defaultTargetPlatform == TargetPlatform.android
      ? '0000ffe0-0000-1000-8000-00805f9b34fb'
      : 'FFE0';
  String deviceCharacteristic = defaultTargetPlatform == TargetPlatform.android
      ? '0000ffe1-0000-1000-8000-00805f9b34fb'
      : 'FFE1';

  BluetoothStatus status = BluetoothStatus.DISCONNECT;

  // mac 98 D3 41 FD 8C 4C

  List<ChatModel> chatModelList = [];
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  NumberFormat intFormat = NumberFormat('00');
  bool isEditing = false;
  String chatData = '';

  void scan() {
    // 구독을 취소하지 않고 다시 구독하며 에러가 발생한다.
    discoveredDeviceStream?.cancel();

    deviceMap = {};
    discoveredDeviceStream = flutterReactiveBle.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      deviceMap[device.id] = device.name;
      update();
    }, onError: (e) {
      print(e);
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
        // Get.to(() => const BluetoothSerial());
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

  void subscribe() {
    print('subscribe');
    chatModelList = [];
    subscribeInstance = flutterReactiveBle
        .subscribeToCharacteristic(getCharacteristic())
        .listen((event) {
      String chat = String.fromCharCodes(event);

      print('string:$chat');
      // print('event: $event');

      ChatModel chatModel = ChatModel(
          chat: chat.substring(0, chat.length - 2),
          userName: deviceName,
          time:
              '${intFormat.format(DateTime.now().hour)}:${intFormat.format(DateTime.now().minute)}:${intFormat.format(DateTime.now().second)}',
          isUser: false);
      chatModelList.add(chatModel);

      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.ease);

      update();
    });
  }

  String temp = '';
  String humidity = '';
  void subscribeIoT() {
    print('subscribe');
    subscribeInstance = flutterReactiveBle
        .subscribeToCharacteristic(getCharacteristic())
        .listen((event) {
      String chat = String.fromCharCodes(event);

      // print('string: $chat');
      print(chat.substring(0, chat.length - 2));
      chat = chat.substring(0, chat.length - 2);
      try {
        List<String> tempHumid = chat.split(',');
        print(tempHumid);
        temp = tempHumid[0];
        humidity = tempHumid[1];
      } catch (e) {
        alert('숫자,숫자 형태로 입력하세요.\n 예시) 30,80');
      }

      update();
    });
  }

  void subscribeClear() {
    subscribeInstance.cancel();
  }

  Future<void> write() async {
    ChatModel chatModel = ChatModel(
        chat: chatData,
        userName: '',
        time:
            '${intFormat.format(DateTime.now().hour)}:${intFormat.format(DateTime.now().minute)}:${intFormat.format(DateTime.now().second)}',
        isUser: true);
    chatModelList.add(chatModel);

    List<int> valueList = ('$chatData\n').codeUnits;
    await flutterReactiveBle.writeCharacteristicWithResponse(
      getCharacteristic(),
      value: valueList,
    );

    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);

    textEditingController.clear();
    isEditing = false;
    update();
  }

  Future<void> writeIoT(String data) async {
    List<int> valueList = ('$data\n').codeUnits;
    await flutterReactiveBle.writeCharacteristicWithResponse(
      getCharacteristic(),
      value: valueList,
    );

    update();
  }

  void checkEditing(String data) {
    chatData = data;
    if (data.isNotEmpty) {
      isEditing = true;
    } else {
      isEditing = false;
    }
    update();
  }

  void controllersInit() {
    textEditingController = TextEditingController();
    scrollController = ScrollController();
  }

  void controllersDispose() {
    textEditingController.dispose();
    scrollController.dispose();
  }

  QualifiedCharacteristic getCharacteristic() {
    return QualifiedCharacteristic(
      serviceId: Uuid.parse(deviceService),
      characteristicId: Uuid.parse(deviceCharacteristic),
      deviceId: deviceId,
    );
  }
}
