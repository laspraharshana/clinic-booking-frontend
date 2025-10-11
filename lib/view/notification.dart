import 'patient_profile.dart';
import 'package:flutter/material.dart';
import 'package:clinic_booking_frontend/brand_colors.dart' hide kPrimaryDark, kPrimary;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool push = true;
  bool reminders = true;
  bool sound = true;
  bool email = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: kPrimaryDark,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: [
          _switchTile(
            title: 'Push notifications',
            subtitle: 'General announcements, updates',
            value: push,
            onChanged: (v) => setState(() => push = v),
          ),
          _switchTile(
            title: 'Appointment reminders',
            subtitle: 'Reminders for upcoming visits',
            value: reminders,
            onChanged: (v) => setState(() => reminders = v),
          ),
          _switchTile(
            title: 'Notification sounds',
            value: sound,
            onChanged: (v) => setState(() => sound = v),
          ),
          _switchTile(
            title: 'Email notifications',
            value: email,
            onChanged: (v) => setState(() => email = v),
          ),
        ],
      ),
    );
  }

  Widget _switchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: kPrimaryDark,
      activeTrackColor: kPrimary.withOpacity(0.35),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}