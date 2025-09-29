
import 'package:flutter/material.dart';

class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "My Appointments",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ChoiceChip(label: Text("Upcoming (1)"), selected: true),
              ChoiceChip(label: Text("Completed (0)"), selected: false),
              ChoiceChip(label: Text("Cancelled (0)"), selected: false),
            ],
          ),

          const SizedBox(height: 16),

          // Appointment card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dr. Sarah Johnson",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Cardiology", style: TextStyle(color: Colors.grey)),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 6),
                        Text("8/7/2025"),
                        const SizedBox(width: 16),
                        Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 6),
                        Text("09:30 AM"),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(Icons.meeting_room, size: 16),
                        const SizedBox(width: 6),
                        Text("In-Person Visit"),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Confirmed",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Find"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Visits"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: 3, // "Visits" selected
        onTap: (index) {
          if (index == 2) {
            // Navigate to Doctor List Page when + is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DoctorListPage()),
            );
          }
        },
      ),
    );
  }
}

// Dummy Doctor List Page
class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor List")),
      body: Center(
        child: Text("Here will be the doctor list"),
      ),
    );
  }
}
