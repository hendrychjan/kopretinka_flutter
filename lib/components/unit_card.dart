import 'package:flutter/material.dart';
import 'package:kopretinka_flutter/models/unit.dart';

class UnitCard extends StatefulWidget {
  final Unit unit;
  const UnitCard({super.key, required this.unit});

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  String _formatDate(DateTime? date) {
    if (date == null) {
      return "never";
    }

    String res = "";
    res += date.toLocal().day.toString() + ".";
    res += date.toLocal().month.toString() + ". ";
    res += date.toLocal().hour.toString() + ":";
    res += date.toLocal().minute.toString();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.unit.number.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "${(widget.unit.lastValue ?? 0)}% ${_formatDate(widget.unit.lastUpdate)}",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            LinearProgressIndicator(
              value: (widget.unit.lastValue ?? 0) / 100,
              minHeight: 10,
            ),
          ],
        ),
      ),
    );
  }
}
