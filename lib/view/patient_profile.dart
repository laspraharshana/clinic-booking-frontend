import 'package:flutter/material.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Profile Header =====
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1B5E57), // Green header color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Sarah Johnson",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHeaderStat("Upcoming", "0", Icons.calendar_today),
                      _buildHeaderStat("Completed", "0", Icons.check_circle),
                      _buildHeaderStat("Rating", "4.8", Icons.star),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== Personal Information =====
            _buildSectionTitle("Personal Information"),
            _buildInfoCard([
              _buildInfoRow(Icons.person, "Full Name", "Sarah Johnson"),
              _buildInfoRow(Icons.phone, "Phone Number", ""),
            ]),

            // ===== Quick Actions =====
            _buildSectionTitle("Quick Actions"),
            _buildInfoCard([
              _buildActionRow(Icons.calendar_month, "My Appointments"),
              _buildActionRow(Icons.local_hospital, "Find Doctors"),
            ]),

            // ===== Account Settings =====
            _buildSectionTitle("Account Settings"),
            _buildInfoCard([
              _buildActionRow(Icons.notifications, "Notifications"),
              _buildActionRow(Icons.lock, "Privacy & Security"),
              _buildActionRow(Icons.credit_card, "Payment Methods"),
              _buildActionRow(Icons.settings, "App Settings"),
            ]),

            // ===== Support & Help =====
            _buildSectionTitle("Support & Help"),
            _buildInfoCard([
              _buildActionRow(Icons.help_outline, "Help & FAQ"),
              _buildActionRow(Icons.support_agent, "Contact Support"),
            ]),

            const SizedBox(height: 15),

            // ===== Sign Out =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text("Sign Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ===== Helper Widgets =====

  static Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  static Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  static Widget _buildInfoRow(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(value.isEmpty ? 'Not added' : value),
      trailing: const Icon(Icons.edit, size: 18, color: Colors.grey),
    );
  }

  static Widget _buildActionRow(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B5E57)),
      title: Text(label),
      onTap: () {},
    );
  }
}
