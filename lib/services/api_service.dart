import 'package:http/http.dart' as http;
import 'package:kopretinka_flutter/getx/app_controller.dart';
import 'package:kopretinka_flutter/models/module.dart';
import 'package:kopretinka_flutter/models/unit.dart';

class ApiService {
  static Future<List<Unit>> fetchUpdate() async {
    var url = Uri.parse('https://kopretinka.onrender.com/modules');

    var headers = {
      'Content-Type': 'application/json',
      'product-code': AppController.to.productCode.value,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Module.fromJson(response.body).units;
    } else {
      throw Exception('Failed to load update');
    }
  }
}
