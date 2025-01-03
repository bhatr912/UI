// lib/views/settings_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: viewModel.settings.notificationsEnabled,
                onChanged: (value) {
                  viewModel.toggleNotifications();
                },
              ),
              ListTile(
                title: const Text('Theme'),
                subtitle: Text(viewModel.settings.theme),
                onTap: () {
                  // Example of changing theme
                  viewModel.changeTheme(
                      viewModel.settings.theme == 'Light' ? 'Dark' : 'Light');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
