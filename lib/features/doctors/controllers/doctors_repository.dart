import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../models/doctor.dart';
import '../models/slot.dart'; // If you already have this model

class DoctorsRepository {
  DoctorsRepository(this._dio);
  final Dio _dio;

  Future<Doctor> fetchDoctorProfile(String id) async {
    final res = await _dio.get('/v1/doctors/$id');
    final data = Map<String, dynamic>.from(res.data['data'] as Map);
    return Doctor.fromJson(data);
  }

  // For the slots placeholder screen
  Future<List<Slot>> fetchDoctorSlots(String id, {int? from, int? to}) async {
    final res = await _dio.get('/v1/doctors/$id/slots', queryParameters: {
      if (from != null) 'from': from,
      if (to != null) 'to': to,
    });
    final list = List<Map<String, dynamic>>.from(
      (res.data['data'] as List).map((e) => Map<String, dynamic>.from(e as Map)),
    );
    return list.map((j) => Slot.fromJson(j)).toList();
  }

  Future<List<Doctor>> listDoctors() async {
    final res = await _dio.get('/v1/doctors'); // returns { data: [ ... ] }
    final list = (res.data['data'] as List<dynamic>)
        .map((e) => Doctor.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    return list;
  }
}

// Provider to access the repository
final doctorsRepositoryProvider = Provider<DoctorsRepository>((ref) {
  return DoctorsRepository(ref.read(dioProvider));
});