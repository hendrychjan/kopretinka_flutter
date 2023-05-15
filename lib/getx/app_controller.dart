import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  RxString productCode = "".obs;
  RxString moduleSSID = "".obs;
  RxString moduleIp = "".obs;
  RxInt modulePort = 0.obs;
}
