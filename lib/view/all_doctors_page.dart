//THIS IS FIND PAGE IN BOTTOM NAVIGATIONBAR

import 'package:flutter/material.dart';
import 'package:myapp/visits_page.dart';
import 'package:myapp/doctor_profile.dart'; // <-- use the external profile page

class SimplePage extends StatelessWidget {
  final String title;
  const SimplePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF1B5E57)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 22))),
    );
  }
}

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});
  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  int _selectedIndex = 1;
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedSpecialty = 'All Specialties';

  final List<String> _specialties = const [
    'All Specialties',
    'Cardiology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Dermatology',
    'Oncology',
  ];

  // You can edit names/specialties/photos here
  final List<Doctor> _doctors = const [
    Doctor(name: 'Dr. Gotabhaya Ranasinghe', specialty: 'Cardiology' , photoUrl: 'https://gotabhayaranasinghe.com/wp-content/uploads/2025/01/Home-Page-Doctor-1024x853.jpg'),
    Doctor(name: 'Dr. Sanjeewa Garusinghe', specialty: 'Neurology' , photoUrl: 'https://chblob.icloudhospital.com/thumbnailcontainer/Dr.%20Sanjeewa%20Garusinghe-59065ae0-ffdc-41dd-b254-0d1546c4f153.jpg?w=1536&q=75&format=webp'),
    Doctor(name: 'Dr. Duminda Samarasinghe', specialty: 'Pediatrics' , photoUrl:'https://th.bing.com/th/id/R.f69b6114cd42a21259e6001608f8ba20?rik=nZ8ZLuaWcFvi9g&riu=http%3a%2f%2fwww.sundaytimes.lk%2f171217%2fuploads%2fD3S6151Dr-Duminda.jpg&ehk=gH%2fNaMJKIKsjhwRCs%2fxB7N4hywFyeRfax8CsHVEU3S8%3d&risl=&pid=ImgRaw&r=0 '),
    Doctor(name: 'Dr. Duminda Samarasinghe', specialty: 'Orthopedics' , photoUrl:'https://th.bing.com/th/id/R.f69b6114cd42a21259e6001608f8ba20?rik=nZ8ZLuaWcFvi9g&riu=http%3a%2f%2fwww.sundaytimes.lk%2f171217%2fuploads%2fD3S6151Dr-Duminda.jpg&ehk=gH%2fNaMJKIKsjhwRCs%2fxB7N4hywFyeRfax8CsHVEU3S8%3d&risl=&pid=ImgRaw&r=0 '),
  ];
  

  List<Doctor> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _doctors.where((d) {
      final matchesQuery = q.isEmpty || d.name.toLowerCase().contains(q) || d.specialty.toLowerCase().contains(q);
      final matchesSpecialty = _selectedSpecialty == 'All Specialties' || d.specialty == _selectedSpecialty;
      return matchesQuery && matchesSpecialty;
    }).toList();
  }

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        if (Navigator.canPop(context)) Navigator.pop(context);
        break;
      case 1:
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimplePage(title: 'Add New Page')));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const VisitsPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimplePage(title: 'Profile Page')));
        break;
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // Bottom nav
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, -2))],
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

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 4),
                  Text('All Doctors', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search doctors or specialties...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Specialty filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: _pickSpecialty,
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 8))],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedSpecialty,
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                physics: const BouncingScrollPhysics(),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final d = _filtered[index];
                  return DoctorCard(
                    doctor: d,
                    onTap: () {
                      // OPEN THE EXTERNAL PROFILE PAGE, PASSING DATA
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoctorProfilePage(
                            name: d.name,
                            specialty: d.specialty,
                            photoUrl: d.photoUrl,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickSpecialty() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _specialties.length,
            itemBuilder: (context, i) {
              final value = _specialties[i];
              final selected = value == _selectedSpecialty;
              return ListTile(
                title: Text(value, style: TextStyle(fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
                trailing: selected ? const Icon(Icons.check, color: Color(0xFF1B5E57)) : null,
                onTap: () => Navigator.of(context).pop(value),
              );
            },
          ),
        );
      },
    );

    if (result != null && mounted) {
      setState(() => _selectedSpecialty = result);
    }
  }

  // bottom nav helpers
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        decoration: isSelected ? BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(20)) : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF1B5E57) : Colors.grey),
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
              Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1B5E57))),
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
        decoration: BoxDecoration(color: const Color(0xFF1B5E57), borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

// ===== Models and list card =====
class Doctor {
  final String name;
  final String specialty;
  final String? photoUrl;
  const Doctor({required this.name, required this.specialty, this.photoUrl});
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap;
  const DoctorCard({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Row(
          children: [
            _Avatar(name: doctor.name, photoUrl: doctor.photoUrl),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(doctor.specialty, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final String? photoUrl;
  const _Avatar({required this.name, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    const size = 64.0;
    final initials = _toInitials(name);

    Widget child;
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          photoUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(size, initials),
        ),
      );
    } else {
      child = _placeholder(size, initials);
    }
    return child;
  }

  Widget _placeholder(double size, String initials) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: const Color(0xFFEAF3F1), borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Text(initials, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F7B66))),
    );
  }

  static String _toInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}