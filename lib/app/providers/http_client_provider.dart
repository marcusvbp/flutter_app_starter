import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../modules/auth/repositories/auth_token_repository.dart';

final httpClientProvider = Provider<Dio>((ref) {
  var dio = Dio(
      // BaseOptions(
      //   baseUrl: apiUrl,
      //   headers: {'Authorization': 'Bearer ${ref.watch(authProvider)}'},
      // ),
      );

  return dio;
});
