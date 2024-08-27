import 'package:flutter/material.dart';
import 'package:nova/widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              settingsButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
