import 'package:flutter/material.dart';
import 'Bottom_navbar.dart';
import 'doctor_profile.dart';

// Doctor Model
class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String? imageUrl;
  final double rating;
  final double consultationFee;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    this.imageUrl,
    required this.rating,
    required this.consultationFee,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      consultationFee: (json['consultationFee'] as num).toDouble(),
    );
  }
}

class AllDoctorsPage extends StatefulWidget {
  const AllDoctorsPage({super.key});

  @override
  State<AllDoctorsPage> createState() => _AllDoctorsPageState();
}

class _AllDoctorsPageState extends State<AllDoctorsPage> {
  final TextEditingController searchController = TextEditingController();
  String selectedSpecialty = 'All Specialties';
  List<Doctor> allDoctors = [];
  List<Doctor> filteredDoctors = [];
  bool isDropdownOpen = false;

  final List<String> specialties = const [
    'All Specialties',
    'Cardiology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Dermatology',
  ];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
    searchController.addListener(_filterDoctors);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _loadDoctors() {
    allDoctors = [
      Doctor(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialty: 'Cardiology',
        imageUrl: 'https://images.unsplash.com/photo-1550831107-1553da8c8464?w=640',
        rating: 4.9,
        consultationFee: 150,
      ),
      Doctor(
        id: '2',
        name: 'Dr. Michael Chen',
        specialty: 'Neurology',
        imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=640',
        rating: 4.8,
        consultationFee: 180,
      ),
      Doctor(
        id: '3',
        name: 'Dr. Emily Rodriguez',
        specialty: 'Pediatrics',
        imageUrl: null,
        rating: 4.7,
        consultationFee: 120,
      ),
      Doctor(
        id: '4',
        name: 'Dr. James Wilson',
        specialty: 'Orthopedics',
        imageUrl: 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?w=640',
        rating: 4.9,
        consultationFee: 200,
      ),
    ];
    filteredDoctors = allDoctors;
    setState(() {});
  }

  void _filterDoctors() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = allDoctors.where((d) {
        final matchesQuery = d.name.toLowerCase().contains(query) || d.specialty.toLowerCase().contains(query);
        final matchesSpec = selectedSpecialty == 'All Specialties' || d.specialty == selectedSpecialty;
        return matchesQuery && matchesSpec;
      }).toList();
    });
  }

  void _selectSpecialty(String specialty) {
    setState(() {
      selectedSpecialty = specialty;
      isDropdownOpen = false;
    });
    _filterDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('All Doctors', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search & Filter
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search
                Container(
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search doctors or specialties...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Specialty filter
                GestureDetector(
                  onTap: () => setState(() => isDropdownOpen = !isDropdownOpen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedSpecialty, style: const TextStyle(fontSize: 15)),
                        Icon(isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dropdown
          if (isDropdownOpen)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
              ]),
              child: Column(
                children: specialties.map((s) {
                  final selected = s == selectedSpecialty;
                  return InkWell(
                    onTap: () => _selectSpecialty(s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      color: selected ? const Color(0xFFE0F2F1) : Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(s, style: TextStyle(fontSize: 15, color: selected ? const Color(0xFF00695C) : Colors.black)),
                          if (selected) const Icon(Icons.check, color: Color(0xFF00695C), size: 20),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          const SizedBox(height: 8),

          // List
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('No doctors found', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, i) => _buildDoctorCard(filteredDoctors[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorProfilePage(
              doctorId: doctor.id,
              doctorName: doctor.name,
              specialty: doctor.specialty,
              rating: doctor.rating,
              consultationFee: doctor.consultationFee,
              doctorImage: doctor.imageUrl,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: doctor.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        doctor.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.person, size: 32, color: Colors.grey[400]),
                      ),
                    )
                  : Icon(Icons.person, size: 32, color: Colors.grey[400]),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(doctor.specialty, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            // Arrow
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}