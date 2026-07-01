// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App settings — theme, notifications, about. Scaffold only.
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.dark_mode_outlined), title: Text('Tema')),
          ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notificações')),
          ListTile(leading: Icon(Icons.info_outline), title: Text('Sobre')),
        ],
      ),
    );
  }
}
