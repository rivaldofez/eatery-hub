import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Theme options
  ThemeMode selectedTheme = ThemeMode.system;

  // Notification toggle
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Appearance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // THEME SELECTION (RECOMMENDED APPROACH)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text("Light"),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text("Dark"),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text("System"),
                  icon: Icon(Icons.phone_android),
                ),
              ],
              selected: {selectedTheme},
              onSelectionChanged: (newValue) {
                setState(() => selectedTheme = newValue.first);
                // TODO: you handle the action later
              },
            ),
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Notifications",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // NOTIFICATION TOGGLE
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() => notificationsEnabled = value);
              // TODO: your action
            },
          ),
        ],
      ),
    );
  }
}
