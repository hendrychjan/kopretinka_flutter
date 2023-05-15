import 'package:get_storage/get_storage.dart';
import 'package:kopretinka_flutter/getx/app_controller.dart';

class AppInitService {
  static Future<void> onStartInit() async {
    await GetStorage.init();

    AppController.to.productCode.value =
        GetStorage().read("product-code") ?? "";
  }
}
