
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MyTabController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );

  }
  @override
  void onClose() {
    super.onClose();
    tabController?.dispose();

  }


}