import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/settings/SettingsProvider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
  void _onPress() {
    String username = _usernameController.text.trim();
    final postProvider = context.read<SettingsProvider>();
    if (username.isNotEmpty) {
      postProvider.setUsername(username);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username saved!")),
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill the username field.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _onPress,
              child: Text("Save"),
            ),
            Consumer<SettingsProvider>(
              builder: (context, value, child) {
                return Text("Current Username: ${value.username}");
              },
            ),
          ],
        ),
      ),
    );
  }
}