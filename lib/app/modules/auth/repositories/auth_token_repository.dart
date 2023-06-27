import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth_storage.dart';

class AuthTokenNotifier extends StateNotifier<String?> {
  AuthTokenNotifier() : super(null);

  save(String? token) async {
    state = token;
    if (token != null) {
      await AuthStorage.instance.save(token);
    } else {
      await AuthStorage.instance.delete();
    }
  }

  Future<void> rehydrate() async {
    state = await AuthStorage.instance.getData;
  }
}

final authProvider = StateNotifierProvider<AuthTokenNotifier, String?>((ref) {
  return AuthTokenNotifier();
});
