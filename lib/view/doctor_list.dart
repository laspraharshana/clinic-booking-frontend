import 'package:flutter/material.dart';
import 'Bottom_navbar.dart';
import 'doctor_profile.dart';

/*

          DATABASE SUGGESSION
          
comment for  database data Line no (314   , 324 - 419)
Future<void> _loadDoctors() async {
  // Example with Firebase
  final snapshot = await FirebaseFirestore.instance
      .collection('doctors')
      .get();
  
  setState(() {
    allDoctors = snapshot.docs
        .map((doc) => Doctor.fromJson(doc.data()))
        .toList();
    filteredDoctors = allDoctors;
  });
}


Include Database with these
{
  "id": "doc123",
  "name": "Dr. Sarah Johnson",
  "specialty": "Cardiology",
  "imageUrl": "https://...",
  "rating": 4.9,
  "consultationFee": 150
}
*/

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

  // Factory constructor to create Doctor from database/API response
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      consultationFee: json['consultationFee'].toDouble(),
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

  // Sample specialties - fetch from database in real app
  final List<String> specialties = [
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

  // Simulate loading doctors from database
  void _loadDoctors() {
    // In real app, fetch from your database
    allDoctors = [
      Doctor(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialty: 'Cardiology',
        imageUrl: 'https://example.com/sarah.jpg',
        rating: 4.9,
        consultationFee: 150,
      ),
      Doctor(
        id: '2',
        name: 'Dr. Michael Chen',
        specialty: 'Neurology',
        imageUrl: 'https://example.com/michael.jpg',
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
        imageUrl: 'https://example.com/james.jpg',
        rating: 4.9,
        consultationFee: 200,
      ),
    ];
    filteredDoctors = allDoctors;
    setState(() {});
  }

  void _filterDoctors() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = allDoctors.where((doctor) {
        bool matchesSearch =
            doctor.name.toLowerCase().contains(query) ||
            doctor.specialty.toLowerCase().contains(query);
        bool matchesSpecialty =
            selectedSpecialty == 'All Specialties' ||
            doctor.specialty == selectedSpecialty;
        return matchesSearch && matchesSpecialty;
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
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 1,
      ), // 0-4 for different pages
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Doctors',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search doctors or specialties...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Specialty Filter Dropdown
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDropdownOpen = !isDropdownOpen;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedSpecialty,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Icon(
                          isDropdownOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dropdown Menu (when open)
          if (isDropdownOpen)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: specialties.map((specialty) {
                  bool isSelected = specialty == selectedSpecialty;
                  return InkWell(
                    onTap: () => _selectSpecialty(specialty),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE0F2F1)
                            : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            specialty,
                            style: TextStyle(
                              fontSize: 15,
                              color: isSelected
                                  ? const Color(0xFF00695C)
                                  : Colors.black,
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: Color(0xFF00695C),
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          const SizedBox(height: 8),

          // Doctors List
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No doctors found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      //return _buildDoctorCard(doctor);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /* Widget _buildDoctorCard(Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorProfilePage(
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: doctor.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        doctor.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 32,
                            color: Colors.grey[400],
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.grey[400],
                    ),
            ),
            const SizedBox(width: 12),
            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  } */
}
