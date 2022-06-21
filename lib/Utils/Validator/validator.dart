import 'package:get/get.dart';

class Validator extends GetxController {
  RxString username = RxString('');
  RxnString errorText = RxnString(null);
  Rxn<Function()> submitFunc = Rxn<Function()>(null);
  final alphanumeric = RegExp("[A-Z a-z 0-9]");

  @override
  void onInit() {
    super.onInit();
  }

  
}
