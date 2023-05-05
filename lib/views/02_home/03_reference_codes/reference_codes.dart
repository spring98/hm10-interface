import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm10_interface/utils/constants/kAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReferenceCodes extends StatefulWidget {
  const ReferenceCodes({Key? key}) : super(key: key);

  @override
  State<ReferenceCodes> createState() => _ReferenceCodesState();
}

class _ReferenceCodesState extends State<ReferenceCodes> {
  List<String> codeList = [
    'void setup() {\n\tpinMode(5, OUTPUT);\n}',
    'void loop() {\n\tdigitalWrite(5, HIGH);\n\tdelay(1000);\n\tdigitalWrite(5, LOW);\n\tdelay(1000);\n}',
    'int a=1;\nif(a==1) {\n\tdigitalWrite(5, HIGH);\n\tdelay(1000);\n}',
    'for(int i=3; i<6; i++) {\n\tdigitalWrite(i, HIGH);\n\tdelay(1000);\n}',
    '#include<Servo.h>\n\nvoid setup() {\n\tServo myservo;\n\tpinMode(9, OUTPUT);\n\tmyservo.attach(9);\n}\n\nvoid loop() {\n\tmyservo.write(10);\n\tdelay(1000);\n}',
    '#include<SoftwareSerial.h>\nSoftwareSerial BTSerial(2, 3);\n\nvoid setup() {\n\tSerial.begin(9600);\n\tBTSerial.begin(9600);\n}\n\nvoid loop() {\n\tif(BTSerial.available()) {\n\t\tSerial.write(BTSerial.read());\n\t}\n}'
  ];
  List<String> explainList = [
    'pinMode(핀번호, OUTPUT)\n해당핀을 출력모드로 설정한다.\nsetup() 함수 내에서 작성하면 단 한번만 실행된다.',
    '5번핀에 5V 신호를 주고 1초 기다리고,\n0V 신호를 주고 1초 기다린다.\nloop() 함수 내에서 작성하면 무한히 실행된다.',
    'if() 괄호안의 내용이 참이라면\n중괄호 안의 코드를 실행한다.\na는 1로 참이므로\n5번핀에 5V 신호를 주고 1초 기다린다.',
    'for() i가 3부터 시작해서 하나씩 증가시키고\n해당 값이 6보다 작다면 중괄호 안의 코드를 실행한다.\n3번핀에 5V 신호를 주고 1초 기다리고,\n4번핀에 5V 신호를 주고 1초 기다리고,\n5번핀에 5V 신호를 주고 1초 기다린다.\ni가 6이되면 만족하지 않으므로\n중괄호안으로 들어가지 않는다.',
    '★ #include<Servo.h> ★\n서보모터는 헤더파일을 전처리해야 한다.\n★ Servo myservo ★\n사용할 모터이름을\nmyservo 라고 정한다. (마음대로 설정)\n★ myservo.attach(핀번호) ★\n서보모터를 제어할 핀 번호를 설정한다.\n★ myservo.write(각도) ★\n서보모터를 제어할 각도를 설정한다.',
    '★ #include<SoftwareSerial.h> ★\n블루투스는 헤더파일을 전처리해야 한다.\n★ SoftwareSerial BTSerial(Rx, Tx) ★\n블루투스에서 데이터를 주고받을\nBTSerial이라는 객체를 생성\n(Rx, Tx)이므로 만약 (2,3)로 설정하면\n아두이노에 연결할 때 Tx=2 Rx=3이다.\n★ Serial.begin(9600); ★\n시리얼 모니터를 사용합니다.\n★ BTSerial.begin(9600); ★\n블루투스에서도 시리얼을 사용합니다.\n★\nif (BTSerial.available()) {\n\tSerial.write(BTSerial.read())\n}\n★\n블루투스 측에서 데이터를 전송하면\n해당 데이터가 시리얼 모니터에 나타난다.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('참고 코드'),
      backgroundColor: Color(0xFFBAD1E6),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: _cardList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardList() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        for (int i = 0; i < codeList.length; i++) ...[
          _card(i),
        ],
      ],
    );
  }

  Widget _card(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(10.sp),
                child: Text(codeList[index]),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: codeList[index]));
                  Get.snackbar(
                    '알림',
                    '클립보드에 복사되었습니다.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(milliseconds: 1000),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.sp),
                  child: Text(
                    '\nCOPY\n',
                  ),
                ),
              ),
            ),
          ],
        ),
        Card(
          color: Color(0xFFF7E9E4),
          child: Container(
            padding: EdgeInsets.all(10.sp),
            child: Text(explainList[index]),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
