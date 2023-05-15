import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kopretinka_flutter/getx/app_controller.dart';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

class ModuleControlService {
  static bool parseConfigQR(String configQR) {
    List<String> split = configQR.split(";");

    if (split.length != 3) {
      return false;
    }

    final ipv4Regex = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (!ipv4Regex.hasMatch(split[1])) {
      return false;
    }

    int? portNumber = int.tryParse(split[2]);
    if (portNumber == null || portNumber < 1 || portNumber > 65535) {
      return false;
    }

    AppController.to.moduleSSID.value = split[0];
    AppController.to.moduleIp.value = split[1];
    AppController.to.modulePort.value = portNumber;
    return true;
  }

  static Future<void> connectToModuleWifi() async {
    await PluginWifiConnect.disconnect();
    bool? connected =
        await PluginWifiConnect.connect(AppController.to.moduleSSID.string);

    if (connected == null || !connected) {
      throw Exception("Failed to connect to module");
    }
  }

  static Future<void> uploadConfiguration(Map<String, dynamic> config) async {
    // Send the config to the module, part by part individually
    await _sendPacket(config["ssid"]);
    await _sendPacket(config["password"]);
    await _sendPacket(config["serverIp"]);
    await _sendPacket(config["serverPort"].toString());

    String ports = "";
    for (int i = 0; i < config["ports"].length; i++) {
      ports += "${config["ports"][i]};";
    }
    ports = ports.substring(0, ports.length - 1);
    await _sendPacket(ports);

    return;
  }

  // static Future<void> _sendPacket(String data) async {
  //   int checksum = _calculateChecksum(data);

  //   // Setup the TCP connection
  //   Socket tcp = await Socket.connect(
  //       AppController.to.moduleIp.string, AppController.to.modulePort.value);

  //   // if 1 second passes and no response, resend the data
  //   tcp.timeout(const Duration(seconds: 1), onTimeout: (var sink) {
  //     print("Timeout, resending data");
  //     tcp.add(utf8.encode(data));
  //   });

  //   bool awaitingResponse = false;
  //   while (true) {
  //     if (!awaitingResponse) {
  //       print("Sending data: $data");
  //       tcp.add(utf8.encode(data));
  //       awaitingResponse = true;
  //       continue;
  //     }

  //     if (awaitingResponse) {
  //       String response = utf8.decode(await tcp.first);
  //       print("Received response: $response");
  //       if (response == checksum.toString()) {
  //         print("Checksum OK");
  //         tcp.destroy();
  //         return;
  //       } else {
  //         print("Checksum mismatch, resending data");
  //         awaitingResponse = false;
  //         continue;
  //       }
  //     }
  //   }
  // }

  static Future<void> _sendPacket(String data) async {
    int checksum = _calculateChecksum(data);
    Socket? tcp;

    try {
      // Connect to the TCP server
      tcp = await Socket.connect(
          AppController.to.moduleIp.string, AppController.to.modulePort.value);

      Stream<List<int>> responseStream =
          tcp.asBroadcastStream(); // Create a broadcast stream

      while (true) {
        // Send data
        tcp.add(utf8.encode(data));

        // Wait for response with a timeout
        List<int>? responseBytes;
        try {
          responseBytes =
              await responseStream.first.timeout(const Duration(seconds: 1));
        } on TimeoutException {
          print("Timeout, resending data");
          continue; // Resend the data if timeout occurs
        }

        String response = utf8.decode(responseBytes);

        // Check if the response matches the checksum
        if (response == checksum.toString()) {
          print("Checksum OK");
          break; // Exit the loop if checksum matches
        } else {
          print("Checksum mismatch, resending data");
        }

        // Wait for 1 second before resending the data
        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // wait for 100 ms before closing the TCP connection
      await Future.delayed(const Duration(milliseconds: 100));
      tcp?.close(); // Close the TCP connection
    }
  }

  static int _calculateChecksum(String payload) {
    int checksum = 0;
    for (int i = 0; i < payload.length; i++) {
      checksum ^= payload.codeUnitAt(i);
    }
    return checksum;
  }
}
