import 'package:flutter/material.dart';

class PatientDashboardPage extends StatelessWidget {
  const PatientDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Find'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40, color: Colors.teal), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Visits'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top greeting and notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Good Morning",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "Sarah",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.teal, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.teal),
                    hintText: 'Search doctors, symptoms, specialties...',
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Appointment status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statusCard(Icons.calendar_today, "Upcoming", "0"),
                  _statusCard(Icons.check_circle_outline, "Completed", "0"),
                ],
              ),

              const SizedBox(height: 24),

              // Medical Specialties (removed "View All")
              const Text(
                "Medical Specialties",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: const [
                  _SpecialtyCard(icon: Icons.favorite, label: "Cardiology", doctors: "24 doctors"),
                  _SpecialtyCard(icon: Icons.psychology, label: "Neurology", doctors: "18 doctors"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _statusCard(IconData icon, String title, String count) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.teal, size: 30),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _SpecialtyCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String doctors;

  const _SpecialtyCard({
    required this.icon,
    required this.label,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.teal, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            doctors,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}