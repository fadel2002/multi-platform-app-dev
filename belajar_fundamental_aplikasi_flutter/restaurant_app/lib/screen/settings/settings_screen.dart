import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/notification/local_notification_provider.dart';
import '../../provider/settings/settings_provider.dart';

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
        SnackBar(
          content: Text("Username saved!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill the username field."),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  late SettingsProvider settingsProvider;
  late LocalNotificationProvider notificationProvider;

  @override
  dispose(){
    _usernameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    settingsProvider = context.watch<SettingsProvider>();
    notificationProvider = context.watch<LocalNotificationProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Theme", style: Theme.of(context).textTheme.titleMedium),
              RadioListTile<ThemeMode>(
                title: Text("System Default"),
                value: ThemeMode.system,
                groupValue: settingsProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    settingsProvider.setTheme(value);
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text("Dark Mode"),
                value: ThemeMode.dark,
                groupValue: settingsProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    settingsProvider.setTheme(value);
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text("Light Mode"),
                value: ThemeMode.light,
                groupValue: settingsProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    settingsProvider.setTheme(value);
                  }
                },
              ),
              Text("Daily Reminder", style: Theme.of(context).textTheme.titleMedium),
              SwitchListTile(
                title: const Text("Daily Reminder at 11:00 AM"),
                value: settingsProvider.isReminderEnabled,
                onChanged: (bool value) {
                  settingsProvider.setReminder(value);
                  notificationProvider.toggleDailyReminder(value);
                },
              ),
              Text("Change Username", style: Theme.of(context).textTheme.titleMedium),
              Text("Current Username: ${settingsProvider.username}"),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _onPress,
                  child: Text("Save"),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (){
                    notificationProvider.checkPendingNotificationRequests().then((result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    });

                  },
                  child: Text("CEK"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}