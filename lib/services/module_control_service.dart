import 'dart:convert';
import 'dart:io';

import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

class ModuleControlService {
  static bool validateConfigQR(String configQR) {
    List<String> split = configQR.split(";");

    if (split.length != 4) {
      return false;
    }

    final ipv4Regex = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (!ipv4Regex.hasMatch(split[2])) {
      return false;
    }

    int? portNumber = int.tryParse(split[3]);
    if (portNumber == null || portNumber < 1024 || portNumber > 65535) {
      return false;
    }

    return true;
  }

  static Future<void> connectToModuleWifi(String configQR) async {
    List<String> split = configQR.split(";");

    String ssid = split[0];
    String password = split[1];

    // TODO: cancel this return when outside of debug
    return;

    bool? connected =
        await PluginWifiConnect.connectToSecureNetwork(ssid, password);

    if (connected == null || !connected) {
      throw Exception("Failed to connect to module");
    }
  }

  static Future<void> uploadConfiguration(
      String configQR, Map<String, dynamic> config) async {
    List<String> split = configQR.split(";");

    String moduleIp = split[2];
    int modulePort = int.parse(split[3]);

    Socket tcp = await Socket.connect(moduleIp, modulePort);

    tcp.add(utf8.encode(json.encode(config)));

    tcp.destroy();

    return;
  }
}
