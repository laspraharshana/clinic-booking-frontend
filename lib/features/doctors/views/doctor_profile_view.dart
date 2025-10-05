import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/doctor_profile_provider.dart';
import '../models/doctor.dart';
import 'doctor_slots_view.dart';

class DoctorProfileView extends ConsumerWidget {
  const DoctorProfileView({super.key, required this.doctorId});
  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(doctorProfileProvider(doctorId));

    return profile.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, st) => Scaffold(
        appBar: AppBar(title: const Text('Doctor')),
        body: Center(child: Text('Failed to load: $err')),
      ),
      data: (doctor) => _ProfileScaffold(doctor: doctor),
    );
  }
}

class _ProfileScaffold extends StatelessWidget {
  const _ProfileScaffold({required this.doctor});
  final Doctor doctor;

  String _formatNext(int? ms) {
    if (ms == null) return 'No slots';
    final dt = DateTime.fromMillisecondsSinceEpoch(ms).toLocal();
    final two = (int n) => n.toString().padLeft(2, '0');
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${dt.month}/${dt.day} $h:${two(dt.minute)} $ampm';
  }

  @override
  Widget build(BuildContext context) {
    final name = doctor.name;
    final specialty = doctor.specialty ?? '';
    final rating = doctor.rating?.toStringAsFixed(1) ?? '—';
    final yearsExp = doctor.yearsExp?.toString() ?? '—';
    final patients = doctor.patientsCount?.toString() ?? '—';
    final bio = doctor.bio ?? '';
    final clinicName = doctor.clinicName ?? '';
    final address = doctor.address ?? '';
    final fee = doctor.consultationFee != null ? '\$${doctor.consultationFee}' : '—';
    final nextAvail = _formatNext(doctor.nextAvailableStartUtc);

    final ImageProvider avatar = (doctor.photoUrl != null && doctor.photoUrl!.isNotEmpty)
        ? NetworkImage(doctor.photoUrl!)
        : const AssetImage('assets/doctor.jpg');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Doctor Profile')),
      body: RefreshIndicator(
        onRefresh: () async {
          // Pull to refresh is handled by popping/returning or using ref.refresh in a Consumer;
          // in a full ConsumerStatefulWidget you'd call ref.refresh. For simplicity, use a small hack:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (_, __, ___) => DoctorProfileView(doctorId: doctor.id)),
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
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
                    const SizedBox(height: 12),
                    CircleAvatar(radius: 40, backgroundImage: avatar),
                    const SizedBox(height: 12),
                    Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(specialty, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text('$rating (reviews)', style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle, color: Colors.lightGreenAccent),
                        const Text(' Available', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoCard('${yearsExp == '—' ? '—' : yearsExp + '+'}', 'Years Exp', Icons.work),
                    _infoCard(patients, 'Patients', Icons.people),
                    _infoCard(rating, 'Rating', Icons.star),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _sectionCard('About', bio),

              _sectionCard('Location', '',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$clinicName\n$address', style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 12),
                      Container(
                        height: 120,
                        color: Colors.grey[200],
                        child: const Center(child: Text('Interactive map', style: TextStyle(color: Colors.grey))),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.teal),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Get Directions', style: TextStyle(color: Colors.teal)),
                      ),
                    ],
                  )),

              _sectionCard('Availability & Pricing', '',
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.access_time, color: Colors.teal),
                        title: const Text('Next Available'),
                        trailing: Text(nextAvail),
                      ),
                      ListTile(
                        leading: const Icon(Icons.attach_money, color: Colors.teal),
                        title: const Text('Consultation Fee'),
                        trailing: Text(fee),
                      ),
                    ],
                  )),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorSlotsView(doctorId: doctor.id, doctorName: doctor.name),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Center(
                    child: Text('Book Appointment', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal, size: 28),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _sectionCard(String title, String description, {Widget? child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (description.isNotEmpty) Text(description, style: const TextStyle(fontSize: 14)),
          if (child != null) child,
        ],
      ),
    );
  }
}