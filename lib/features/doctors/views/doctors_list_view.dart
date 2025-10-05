import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/doctor_list_provider.dart';
import '../models/doctor.dart';
import 'doctor_profile_view.dart';

class DoctorsListView extends ConsumerWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(doctorListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      body: doctorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load: $e')),
        data: (doctors) {
          if (doctors.isEmpty) {
            return const Center(child: Text('No doctors available'));
          }
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, i) {
              final d = doctors[i];
              final img = const AssetImage('assets/doctor.jpg'); // photoUrl not present yet
              return ListTile(
                leading: CircleAvatar(backgroundImage: img),
                title: Text(d.name),
                subtitle: Text(d.specialty ?? d.clinicName ?? ''),
                trailing: (d.rating != null)
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(d.rating!.toStringAsFixed(1)),
                  ],
                )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorProfileView(doctorId: d.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}