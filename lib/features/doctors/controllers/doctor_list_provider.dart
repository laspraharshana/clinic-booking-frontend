import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/doctor.dart';
import 'doctors_repository.dart';

final doctorListProvider =
FutureProvider.autoDispose<List<Doctor>>((ref) async {
  final repo = ref.read(doctorsRepositoryProvider);
  return repo.listDoctors();
});