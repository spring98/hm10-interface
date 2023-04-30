import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../utils/constants.dart';

class BluetoothWrite extends StatefulWidget {
  const BluetoothWrite({Key? key}) : super(key: key);

  @override
  State<BluetoothWrite> createState() => _BluetoothWriteState();
}

class _BluetoothWriteState extends State<BluetoothWrite> {
  final flutterReactiveBle = FlutterReactiveBle();
  final characteristic = QualifiedCharacteristic(
    serviceId: Uuid.parse(Constants.deviceSERVICE),
    characteristicId: Uuid.parse(Constants.deviceCHARACTERISTIC),
    deviceId: Constants.deviceID,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 180,
                      child: Image.asset(
                        'images/code.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  _codeButton('C'),
                  _codeButton('D'),
                  _codeButton('E'),
                  _codeButton('F'),
                  _codeButton('G'),
                  _codeButton('A'),
                  _codeButton('B'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _codeButton(String code) {
    int value = 0;
    switch (code) {
      case 'A':
        value = 0x41;
        break;
      case 'B':
        value = 0x42;
        break;
      case 'C':
        value = 0x43;
        break;
      case 'D':
        value = 0x44;
        break;
      case 'E':
        value = 0x45;
        break;
      case 'F':
        value = 0x46;
        break;
      case 'G':
        value = 0x47;
        break;
    }

    return InkWell(
      onTap: () async {
        await flutterReactiveBle.writeCharacteristicWithResponse(
          characteristic,
          value: [value],
        );
      },
      child: Container(
        width: 180,
        height: 111,
        // color: Colors.amberAccent,
        // child: Text(code),
      ),
    );
  }
}
