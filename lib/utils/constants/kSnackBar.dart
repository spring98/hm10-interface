import 'package:flutter/animation.dart';
import 'package:get/get.dart';

SnackbarController snackBar(String contents) {
  return Get.snackbar(
    '알림',
    contents,
    snackPosition: SnackPosition.BOTTOM,
    forwardAnimationCurve: Curves.elasticInOut,
    reverseAnimationCurve: Curves.easeOut,
  );
}
