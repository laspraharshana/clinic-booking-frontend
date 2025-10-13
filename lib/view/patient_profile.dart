import 'Doctor_list.dart';
import 'SigninAndSignup.dart';
import 'auth_service.dart';
import 'contact_support.dart';
import 'help_faq.dart';
import 'notification.dart';
import 'payment_methods.dart';
import 'privacy_security.dart';
import 'app_settings.dart';
import 'package:flutter/material.dart';
import 'visits_page.dart';

// Brand colors
const kPrimaryDark = Color(0xFF1B5E57);
const kPrimary = Color(0xFF00695C);

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key});

  @override
  State<PatientProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PatientProfilePage> {
  int _selectedIndex = 4; // Profile selected

  // Editable fields
  String _fullName = 'Sarah Johnson';
  String _phone = '';

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        if (Navigator.canPop(context))
          Navigator.pop(context); // Home -> back to Dashboard
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AllDoctorsPage()),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add new - coming soon'),
            backgroundColor: kPrimaryDark,
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VisitsPage()),
        );
        break;
      case 4:
        // already here
        break;
    }
  }

  Future<void> _editName() async {
    final result = await _showEditSheet(
      title: 'Edit Full Name',
      initial: _fullName,
      hint: 'Enter full name',
      keyboardType: TextInputType.name,
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => _fullName = result.trim());
    }
  }

  Future<void> _editPhone() async {
    final result = await _showEditSheet(
      title: 'Edit Phone Number',
      initial: _phone,
      hint: 'Enter phone number',
      keyboardType: TextInputType.phone,
    );
    if (result != null) {
      setState(() => _phone = result.trim());
    }
  }

  Future<String?> _showEditSheet({
    required String title,
    required String initial,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) async {
    final controller = TextEditingController(text: initial);
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kPrimaryDark),
                  ),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kPrimaryDark),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: kPrimaryDark),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, controller.text),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleSignOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: kPrimaryDark)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryDark),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await AuthService.signOut();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInAndSignUp()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      // Bottom navigation (same style as Dashboard)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.search, "Find", 1),
            _buildCenterAddButton(2),
            _buildNavItem(Icons.calendar_today, "Visits", 3),
            _buildNavItem(Icons.person, "Profile", 4),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Profile Info (matched colors + decorative circles)
            _headerWithCircles(),

            const SizedBox(height: 16),

            // Personal Information Section
            _buildSection('Personal Information', [
              _buildInfoTile(
                Icons.person_outline,
                'FULL NAME',
                _fullName,
                onTap: _editName,
              ),
              _buildInfoTile(
                Icons.phone_outlined,
                'PHONE NUMBER',
                _phone,
                onTap: _editPhone,
              ),
            ]),

            // Quick Actions Section
            _buildSection('Quick Actions', [
              _buildActionTile(
                Icons.event_note,
                'My Appointments',
                Colors.blue[100]!,
                Colors.blue,
                onTap: () => _onBottomNavTapped(3),
              ),
              _buildActionTile(
                Icons.favorite_border,
                'Find Doctors',
                Colors.green[100]!,
                Colors.green,
                onTap: () => _onBottomNavTapped(1),
              ),
            ]),

            // Account Settings Section
            _buildSection('Account Settings', [
              _buildActionTile(
                Icons.notifications_none,
                'Notifications',
                Colors.purple[100]!,
                Colors.purple,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsPage()),
                ),
              ),
              _buildActionTile(
                Icons.lock_outline,
                'Privacy & Security',
                Colors.orange[100]!,
                Colors.orange,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacySecurityPage(),
                  ),
                ),
              ),
              _buildActionTile(
                Icons.credit_card,
                'Payment Methods',
                Colors.blue[100]!,
                Colors.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentMethodsPage()),
                ),
              ),
              _buildActionTile(
                Icons.settings_outlined,
                'App Settings',
                Colors.grey[300]!,
                Colors.grey[700],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AppSettingsPage()),
                ),
              ),
            ]),

            // Support & Help Section
            _buildSection('Support & Help', [
              _buildActionTile(
                Icons.help_outline,
                'Help & FAQ',
                Colors.cyan[100]!,
                Colors.cyan,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpFaqPage()),
                ),
              ),
              _buildActionTile(
                Icons.headset_mic_outlined,
                'Contact Support',
                Colors.teal[100]!,
                Colors.teal,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactSupportPage()),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            // Sign Out Button (kept red for destructive action)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[100]!),
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: _handleSignOut,
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ---------- Header with same colors + decorative circles ----------
  Widget _headerWithCircles() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryDark, kPrimary], // same as Dashboard
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -40,
              left: -40,
              child: _circle(140, Colors.white.withOpacity(0.08)),
            ),
            Positioned(
              top: -10,
              right: -30,
              child: _circle(120, Colors.white.withOpacity(0.06)),
            ),
            Positioned(
              bottom: -30,
              left: 80,
              child: _circle(100, Colors.white.withOpacity(0.05)),
            ),

            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Profile Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Name and Edit Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _fullName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _editName,
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(Icons.event_note, '0', 'Upcoming'),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem(Icons.favorite_border, '0', 'Completed'),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem(Icons.star_border, '4.8', 'Rating'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // ---------- Bottom nav helpers ----------
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? kPrimaryDark : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? kPrimaryDark : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryDark,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterAddButton(int index) {
    return GestureDetector(
      onTap: () => _onBottomNavTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kPrimaryDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  // ---------- UI helpers ----------
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: Colors.grey[700]),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        value.isEmpty ? 'Not provided' : value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: onTap,
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    Color bgColor,
    Color? iconColor, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}
