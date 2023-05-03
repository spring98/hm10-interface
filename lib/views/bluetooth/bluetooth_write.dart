// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:hm10_interface/models/chat_model.dart';
import 'package:intl/intl.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  List<ChatModel> chatModelList = [];
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  NumberFormat intFormat = NumberFormat('00');
  bool isEditing = false;
  String data = '';

  @override
  void initState() {
    super.initState();

    flutterReactiveBle
        .subscribeToCharacteristic(characteristic)
        .listen((event) {
      String chat = String.fromCharCodes(event);

      print('string:$chat');
      // print('event: $event');

      ChatModel chatModel = ChatModel(
          chat: chat.substring(0, chat.length - 2),
          userName: Constants.deviceNAME,
          time:
              '${intFormat.format(DateTime.now().hour)}:${intFormat.format(DateTime.now().minute)}:${intFormat.format(DateTime.now().second)}',
          isUser: false);
      chatModelList.add(chatModel);
      print(chatModelList);
      scrollController.animateTo(
          scrollController.position.maxScrollExtent + 65.h,
          duration: Duration(milliseconds: 100),
          curve: Curves.ease);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Color(0xFF9BBBD4),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: 600.h,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                _stringButton('HELLO WORLD!\n'),
                // const Expanded(child: SizedBox()),
                for (int i = 0; i < chatModelList.length; i++) ...[
                  _chat(i),
                  SizedBox(height: 10.h),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 5.h, top: 5.h),
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                // width: double.infinity,
                // width: 100,
                height: 35.h,
                child: TextFormField(
                  cursorHeight: 18.h,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.w),
                    suffixIcon: isEditing
                        ? InkWell(
                            onTap: () async {
                              ChatModel chatModel = ChatModel(
                                  chat: data,
                                  userName: '',
                                  time:
                                      '${intFormat.format(DateTime.now().hour)}:${intFormat.format(DateTime.now().minute)}:${intFormat.format(DateTime.now().second)}',
                                  isUser: true);
                              chatModelList.add(chatModel);

                              List<int> valueList = ('$data\n').codeUnits;
                              await flutterReactiveBle
                                  .writeCharacteristicWithResponse(
                                characteristic,
                                value: valueList,
                              );

                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent +
                                      40.h,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.ease);

                              textEditingController.clear();
                              isEditing = false;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFEF01B),
                              ),
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : Container(margin: EdgeInsets.all(5.w)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                  ),
                  onFieldSubmitted: (data) async {},
                  onChanged: (data) {
                    this.data = data;
                    if (data.isNotEmpty) {
                      isEditing = true;
                    } else {
                      isEditing = false;
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _chat(int index) {
    double? chatWidth;
    if (chatModelList[index].chat.length > 37) {
      chatWidth = 240.w;
    }

    if (chatModelList[index].isUser) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(child: Text(chatModelList[index].time)),
          SizedBox(width: 5.w),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: chatModelList[index].isUser
                  ? Color(0xFFFEF01B)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: SizedBox(
              width: chatWidth,
              child: Text(chatModelList[index].chat),
            ),
          ),
          SizedBox(width: 10),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'images/hm10.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Text(chatModelList[index].userName)),
              SizedBox(height: 5.h),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: SizedBox(
                  width: chatWidth,
                  child: Text(chatModelList[index].chat),
                ),
              ),
            ],
          ),
          SizedBox(width: 5.w),
          Container(child: Text(chatModelList[index].time)),
        ],
      );
    }
  }

  Widget _stringButton(String code) {
    List<int> valueList = code.codeUnits;

    return InkWell(
      onTap: () async {
        // print(valueList);
        await flutterReactiveBle.writeCharacteristicWithResponse(
          characteristic,
          value: valueList,
        );
      },
      child: Container(
        width: 180,
        height: 111,
        color: Colors.orangeAccent,
        child: Text(code),
      ),
    );
  }
}
