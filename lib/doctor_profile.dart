import 'package:flutter/material.dart';

void main() {
  runApp(const DoctorProfileApp());
}

class DoctorProfileApp extends StatelessWidget {
  const DoctorProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DoctorProfilePage(),
    );
  }
}

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF00695C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/doctor.jpg"), // add your doctor image
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Dr. Sarah Johnson",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Cardiology",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text("4.9 (124 reviews)",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.check_circle, color: Colors.lightGreenAccent),
                      Text(" Available", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Experience / Patients / Rating Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoCard("15+", "Years Exp", Icons.work),
                  _infoCard("500+", "Patients", Icons.people),
                  _infoCard("4.9", "Rating", Icons.star),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // About
            _sectionCard("About",
                "Experienced cardiologist with 15+ years in cardiac care and interventional procedures."),

            // Location
            _sectionCard("Location", "",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "City General Hospital\n123 Medical Center Dr, Suite 200",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Center(
                          child: Text("Interactive map",
                              style: TextStyle(color: Colors.grey))),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        "Get Directions",
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                )),

            // Availability & Pricing
            _sectionCard("Availability & Pricing", "",
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.access_time, color: Colors.teal),
                      title: const Text("Next Available"),
                      trailing: const Text("Today 2:30 PM"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money, color: Colors.teal),
                      title: const Text("Consultation Fee"),
                      trailing: const Text("\$150"),
                    ),
                  ],
                )),

            const SizedBox(height: 20),

            // Book Appointment Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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

  // Info card widget
  Widget _infoCard(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal, size: 28),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  // Section card widget
  Widget _sectionCard(String title, String description, {Widget? child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (description.isNotEmpty)
            Text(description, style: const TextStyle(fontSize: 14)),
          if (child != null) child,
        ],
      ),
    );
  }
}
