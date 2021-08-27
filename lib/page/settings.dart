import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تنظیمات'),
      ),
      body: const Center(
        // features to add:
        // can change to dark and light mode
        // ...
        child: Text('صفحه تنظیمات'),
      ),
    );
  }
}
