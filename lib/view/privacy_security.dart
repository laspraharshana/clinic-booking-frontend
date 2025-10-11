import 'patient_profile.dart';
import 'package:flutter/material.dart';
import 'package:clinic_booking_frontend/brand_colors.dart' hide kPrimaryDark, kPrimary;

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool biometric = false;
  bool twoFactor = false;

  void _changePassword() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Current password')),
            const SizedBox(height: 8),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: 'New password')),
            const SizedBox(height: 8),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Confirm new password')),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kPrimaryDark),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: kPrimaryDark)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDark,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: kPrimaryDark,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Biometric login'),
            subtitle: const Text('Face ID / Fingerprint'),
            value: biometric,
            onChanged: (v) => setState(() => biometric = v),
            activeColor: kPrimaryDark,
            activeTrackColor: kPrimary.withOpacity(0.35),
          ),
          SwitchListTile(
            title: const Text('Two-factor authentication'),
            value: twoFactor,
            onChanged: (v) => setState(() => twoFactor = v),
            activeColor: kPrimaryDark,
            activeTrackColor: kPrimary.withOpacity(0.35),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _changePassword,
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}