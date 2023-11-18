import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SheetsScreen extends StatefulWidget {
  final String? sheetId;
  const SheetsScreen({super.key, required this.sheetId});

  @override
  State<SheetsScreen> createState() => _SheetsScreenState();
}

class _SheetsScreenState extends State<SheetsScreen> {
  @override
  void initState() {
    print(widget.sheetId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheets Screen'),
      ),
      body: Center(
        child: Text('Sheets Screen'),
      ),
    );
  }
}
