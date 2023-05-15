import 'dart:convert';

import 'package:kopretinka_flutter/models/unit.dart';

class Module {
  List<Unit> units;

  Module({required this.units});

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      units: List<Unit>.from(map['ports'].map((x) => Unit.fromMap(x))),
    );
  }

  factory Module.fromJson(String json) {
    return Module.fromMap(jsonDecode(json));
  }
}
