import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum Navigation {
  manual,
  // registration,
  home,
  // dataList,
  siteDataList,
  dataDetail,
  dataRegistration,
}

class HomeControlViewModel extends GetxController {
  Navigation navigation = Navigation.dataRegistration;
  bool isFloating = false;
  int dataIndex = 0;
  int siteIndex = 0;

  ScrollController scrollController = ScrollController();

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 10), curve: Curves.linear);
    // scrollController.animateTo(0,
    //     duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  void updateNavigation(Navigation nav) {
    navigation = nav;
    update();
    scrollToTop();
  }

  void updateFloating(bool flag) {
    isFloating = flag;
    update();
  }

  void updateDataIndex(int index) {
    dataIndex = index;
    update();
  }

  void updateSiteIndex(int index) {
    siteIndex = index;
    update();
  }
}
