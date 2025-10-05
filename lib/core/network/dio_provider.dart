import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dio_client.dart';

// Shared Dio for the app (adds Authorization automatically via your interceptor)
final dioProvider = Provider<Dio>((ref) {
  return createDio();
});