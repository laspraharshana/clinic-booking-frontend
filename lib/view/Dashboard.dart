import 'package:flutter/material.dart';
import 'doctor_list.dart';
import 'visits_page.dart';

// Dummy Placeholder Page
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF1B5E57),
      ),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 22))),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        break; // Home - stay here
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllDoctorsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlaceholderPage(title: "Add New Page"),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VisitsPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlaceholderPage(title: "Profile Page"),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ✅ Custom Bottom Navigation
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

      body: _buildDashboardBody(),
    );
  }

  // === Dashboard ===
  Widget _buildDashboardBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E57), Color(0xFF00695C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.black54),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Good Afternoon",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "Sarah",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.notifications_none,
                      size: 28,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: "Search doctors, symptoms, specialties...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Upcoming",
                    "0",
                    Icons.calendar_today,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    "Completed",
                    "0",
                    Icons.check_circle,
                    Colors.teal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Specialties Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Medical Specialties",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSpecialtyCard(
                  context,
                  "Cardiology",
                  "24 doctors",
                  Icons.favorite,
                  Colors.red,
                  const PlaceholderPage(title: "Cardiology"),
                ),
                _buildSpecialtyCard(
                  context,
                  "Neurology",
                  "18 doctors",
                  Icons.psychology,
                  Colors.purple,
                  const PlaceholderPage(title: "Neurology"),
                ),
                _buildSpecialtyCard(
                  context,
                  "Pediatrics",
                  "32 doctors",
                  Icons.child_care,
                  Colors.pink,
                  const PlaceholderPage(title: "Pediatrics"),
                ),
                _buildSpecialtyCard(
                  context,
                  "Eye Care",
                  "15 doctors",
                  Icons.remove_red_eye,
                  Colors.blue,
                  const PlaceholderPage(title: "Eye Care"),
                ),
                _buildSpecialtyCard(
                  context,
                  "Orthopedics",
                  "28 doctors",
                  Icons.fitness_center,
                  Colors.orange,
                  const PlaceholderPage(title: "Orthopedics"),
                ),
                _buildSpecialtyCard(
                  context,
                  "General",
                  "45 doctors",
                  Icons.medical_services,
                  Colors.teal,
                  const PlaceholderPage(title: "General"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // === Helpers ===

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
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
            Icon(
              icon,
              color: isSelected ? const Color(0xFF1B5E57) : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF1B5E57) : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1B5E57),
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
          color: const Color(0xFF1B5E57),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildSpecialtyCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 26, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
