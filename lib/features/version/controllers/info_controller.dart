import 'package:dart_ipify/dart_ipify.dart';
import 'package:get/get.dart';

class InfoController extends GetxController{
  RxString ip = "".obs;
  @override
  void onInit() {
    super.onInit();
    ipAdress();
  }
  ipAdress()async{
    final ipv4 = await Ipify.ipv4();
    ip.value = ipv4;
    print(ipv4); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    print(ipv6); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    print(ipv4json); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}
  }
}