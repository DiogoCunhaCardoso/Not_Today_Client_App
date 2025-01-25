import 'package:flutter/material.dart';
import 'package:not_today_client/components/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLanguageEnglish = true;
  bool isDarkTheme = false;
  bool isNotificationsEnabled = true;
  bool isDailyMotivationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: <Widget>[
              // Language Setting
              SettingTile(
                title: "Language",
                subtitle: "Select your preferred language",
                icon: Icons.language,
                value: isLanguageEnglish,
                onChanged: (isChecked) {
                  setState(() {
                    isLanguageEnglish = isChecked;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Color Theme Setting
              SettingTile(
                title: "Color Theme",
                subtitle: "Choose dark or light theme",
                icon: Icons.palette,
                value: isDarkTheme,
                onChanged: (isChecked) {
                  setState(() {
                    isDarkTheme = isChecked;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Progress Notification Setting
              SettingTile(
                title: "Progress Notification",
                subtitle: "Enable progress notifications",
                icon: Icons.notifications,
                value: isNotificationsEnabled,
                onChanged: (isChecked) {
                  setState(() {
                    isNotificationsEnabled = isChecked;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Daily Motivation Setting
              SettingTile(
                title: "Daily Motivation",
                subtitle: "Enable daily motivational quotes",
                icon: Icons.mood,
                value: isDailyMotivationEnabled,
                onChanged: (isChecked) {
                  setState(() {
                    isDailyMotivationEnabled = isChecked;
                  });
                },
              ),
              const SizedBox(height: 16),

              const Spacer(),

              // Logout Button
              TextButton(
                onPressed: () {
                  // Handle the logout logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully!')),
                  );
                  Navigator.of(context).pop(); // Go back to ProfileScreen
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
