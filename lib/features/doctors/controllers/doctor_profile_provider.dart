import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/doctor.dart';
import '../models/slot.dart';
import 'doctors_repository.dart';

// Profile provider
final doctorProfileProvider = FutureProvider.family.autoDispose<Doctor, String>((ref, doctorId) async {
  final repo = ref.read(doctorsRepositoryProvider);
  return repo.fetchDoctorProfile(doctorId);
});

// Slots provider (used by the placeholder screen)
final doctorSlotsProvider = FutureProvider.family.autoDispose<List<Slot>, String>((ref, doctorId) async {
  final repo = ref.read(doctorsRepositoryProvider);
  return repo.fetchDoctorSlots(doctorId);
});