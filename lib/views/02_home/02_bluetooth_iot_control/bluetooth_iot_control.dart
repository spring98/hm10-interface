import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/view_models/01_bluetooth/bluetooth_view_model.dart';
import '../../../utils/constants/kAppBar.dart';

class BluetoothIotControl extends StatefulWidget {
  const BluetoothIotControl({Key? key}) : super(key: key);

  @override
  State<BluetoothIotControl> createState() => _BluetoothIotControlState();
}

class _BluetoothIotControlState extends State<BluetoothIotControl> {
  final bluetoothViewModel = Get.put(BluetoothViewModel());

  @override
  void initState() {
    super.initState();
    bluetoothViewModel.subscribeIoT();
  }

  @override
  void dispose() {
    super.dispose();
    bluetoothViewModel.subscribeClear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('IoT Control'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            GetBuilder<BluetoothViewModel>(builder: (_) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 원하는 둥근 정도를 조절합니다.
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6FA),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Temp: ${_.temp}℃, Humidity: ${_.humidity}%',
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              );
            }),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: _button('Cool')),
                SizedBox(width: 5),
                Expanded(child: _button('Warm')),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: _button('On')),
                SizedBox(width: 5),
                Expanded(child: _button('Off')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(String type) {
    String data = '';
    Color color = Colors.black;
    Color fontColor = Colors.black;
    switch (type) {
      case 'Cool':
        data = 'C';
        color = Color(0xFFB0E0E6);
        break;
      case 'Warm':
        data = 'W';
        color = Color(0xFFFFC0CB);
        break;
      case 'On':
        data = '1';
        color = Color(0xFF3F3F3F);
        fontColor = Colors.white;
        break;
      case 'Off':
        data = '0';
        color = Color(0xFFC0C0C0);
        break;
    }

    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // 원하는 둥근 정도를 조절합니다.
      ),
      child: InkWell(
        onTap: () async {
          await bluetoothViewModel.writeIoT(data);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // color: color,
          ),
          height: 150,
          child: Text(
            type,
            style: TextStyle(fontSize: 21, color: fontColor),
          ),
        ),
      ),
    );
  }
}
