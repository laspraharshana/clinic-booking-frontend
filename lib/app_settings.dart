import 'package:flutter/material.dart';
import 'package:myapp/brand_colors.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool darkMode = false;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: kPrimaryDark,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: darkMode,
            onChanged: (v) => setState(() => darkMode = v),
            title: const Text('Dark mode'),
            activeColor: kPrimaryDark,
            activeTrackColor: kPrimary.withOpacity(0.35),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await showModalBottomSheet<String>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('English'),
                        onTap: () => Navigator.pop(context, 'English'),
                      ),
                      ListTile(
                        title: const Text('Sinhala'),
                        onTap: () => Navigator.pop(context, 'Sinhala'),
                      ),
                      ListTile(
                        title: const Text('Tamil'),
                        onTap: () => Navigator.pop(context, 'Tamil'),
                      ),
                    ],
                  ),
                ),
              );
              if (result != null) setState(() => language = result);
            },
          ),
        ],
      ),
    );
  }
}