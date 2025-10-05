import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/doctor_profile_provider.dart';
import '../models/slot.dart';

class DoctorSlotsView extends ConsumerWidget {
  const DoctorSlotsView({super.key, required this.doctorId, required this.doctorName});
  final String doctorId;
  final String doctorName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotsAsync = ref.watch(doctorSlotsProvider(doctorId));
    return Scaffold(
      appBar: AppBar(title: Text('Slots • $doctorName')),
      body: slotsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load slots: $e')),
        data: (slots) {
          if (slots.isEmpty) {
            return const Center(child: Text('No available slots'));
          }
          return ListView.separated(
            itemCount: slots.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final s = slots[i];
              final start = DateTime.fromMillisecondsSinceEpoch(s.startUtc).toLocal();
              final end = DateTime.fromMillisecondsSinceEpoch(s.endUtc).toLocal();
              String fmt(DateTime dt) {
                final two = (int n) => n.toString().padLeft(2, '0');
                final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
                final ampm = dt.hour >= 12 ? 'PM' : 'AM';
                return '${dt.month}/${dt.day} $h:${two(dt.minute)} $ampm';
              }

              return ListTile(
                leading: const Icon(Icons.schedule),
                title: Text('${fmt(start)} - ${fmt(end)}'),
                subtitle: Text(s.status),
                trailing: ElevatedButton(
                  onPressed: () {
                    // TODO: Call POST /v1/appointments/book with this slotId
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking flow to be implemented')),
                    );
                  },
                  child: const Text('Book'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}