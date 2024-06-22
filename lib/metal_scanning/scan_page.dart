import 'package:flutter/material.dart';
import 'package:metal_scanner/metal_scanning/components/scan_button.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('hi'),
      floatingActionButton: ScanButton(),
    );
  }
}
