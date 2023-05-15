import 'dart:convert';

class Unit {
  int number;
  int? lastValue;
  DateTime? lastUpdate;

  Unit({required this.number, this.lastValue, this.lastUpdate});

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      number: map['number'],
      lastValue: map['lastValue'],
      lastUpdate: DateTime.parse(map['lastUpdate']).toLocal(),
    );
  }

  factory Unit.fromJson(String json) {
    return Unit.fromMap(jsonDecode(json));
  }
}
