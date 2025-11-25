import 'package:eateryhub/data/model/theme_option.dart';
import 'package:eateryhub/provider/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      final settingProvider = context.read<SettingsProvider>();
      settingProvider.getThemeOption();
      settingProvider.getLunchNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Consumer<SettingsProvider>(
        builder: (context, value, child) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Appearance",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SegmentedButton<ThemeOption>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeOption.light,
                      label: Text("Light"),
                      icon: Icon(Icons.light_mode),
                    ),
                    ButtonSegment(
                      value: ThemeOption.dark,
                      label: Text("Dark"),
                      icon: Icon(Icons.dark_mode),
                    ),
                    ButtonSegment(
                      value: ThemeOption.system,
                      label: Text("System"),
                      icon: Icon(Icons.phone_android),
                    ),
                  ],
                  selected: {value.themeOption ?? ThemeOption.system},
                  onSelectionChanged: (newValue) {
                    final settingProvider = context.read<SettingsProvider>();
                    settingProvider.setThemeOption(newValue.first);
                  },
                ),
              ),

              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              SwitchListTile(
                title: const Text("Lunch 11:00 AM"),
                value: value.isLunchNotificationEnabled ?? false,
                onChanged: (value) {
                  final settingProvider = context.read<SettingsProvider>();
                  settingProvider.toggleLunchNotification(value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
