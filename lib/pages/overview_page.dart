import 'package:flutter/material.dart';
import 'package:kopretinka_flutter/components/unit_card.dart';
import 'package:kopretinka_flutter/models/unit.dart';
import 'package:kopretinka_flutter/services/api_service.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool _isLoading = true;
  final List<Unit> _units = [];

  Future<void> _onUpdate() async {
    setState(() {
      _isLoading = true;
    });
    List<Unit> update = await ApiService.fetchUpdate();
    setState(() {
      _units.clear();
      _units.addAll(update);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _onUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kopretinka'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onUpdate(),
        child: (_isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _units.length,
                itemBuilder: (context, index) {
                  return UnitCard(unit: _units[index]);
                },
              ),
      ),
    );
  }
}
