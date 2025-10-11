import 'package:flutter/material.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Profile Header =====
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E5E), Color(0xFF2D7F7F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Sarah Johnson",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildHeaderStat(
                          "Upcoming",
                          "0",
                          Icons.calendar_today_outlined,
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildHeaderStat(
                          "Completed",
                          "0",
                          Icons.favorite_border,
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildHeaderStat("Rating", "4.8", Icons.star_border),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== Personal Information =====
            _buildSectionTitle("Personal Information"),
            _buildInfoCard([
              _buildInfoRow(
                Icons.person_outline,
                "Full Name",
                "Sarah Johnson",
                Colors.grey,
              ),
              _buildInfoRow(
                Icons.phone_outlined,
                "Phone Number",
                "",
                Colors.grey,
              ),
            ]),

            // ===== Quick Actions =====
            _buildSectionTitle("Quick Actions"),
            _buildInfoCard([
              _buildActionRow(
                Icons.calendar_month_outlined,
                "My Appointments",
                const Color(0xFF5B9FED),
              ),
              _buildActionRow(
                Icons.location_on_outlined,
                "Find Doctors",
                const Color(0xFF6DDCC3),
              ),
            ]),

            // ===== Account Settings =====
            _buildSectionTitle("Account Settings"),
            _buildInfoCard([
              _buildActionRow(
                Icons.notifications_outlined,
                "Notifications",
                const Color(0xFFB39DDB),
              ),
              _buildActionRow(
                Icons.lock_outline,
                "Privacy & Security",
                const Color(0xFFFFC774),
              ),
              _buildActionRow(
                Icons.credit_card_outlined,
                "Payment Methods",
                const Color(0xFF90CAF9),
              ),
              _buildActionRow(
                Icons.settings_outlined,
                "App Settings",
                const Color(0xFFB0BEC5),
              ),
            ]),

            // ===== Support & Help =====
            _buildSectionTitle("Support & Help"),
            _buildInfoCard([
              _buildActionRow(
                Icons.help_outline,
                "Help & FAQ",
                const Color(0xFF81C784),
              ),
              _buildActionRow(
                Icons.support_agent_outlined,
                "Contact Support",
                const Color(0xFF6DDCC3),
              ),
            ]),

            const SizedBox(height: 15),

            // ===== Sign Out =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red[400]),
                      const SizedBox(width: 8),
                      Text(
                        "Sign Out",
                        style: TextStyle(
                          color: Colors.red[400],
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  static Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  static Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      subtitle: Text(
        value.isEmpty ? 'Not added' : value,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Icon(Icons.edit_outlined, size: 18, color: Colors.grey[400]),
    );
  }

  static Widget _buildActionRow(IconData icon, String label, Color iconColor) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      onTap: () {},
    );
  }
}
