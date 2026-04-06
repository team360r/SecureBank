import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref.read(apiServiceProvider));
});

class AuthNotifier extends StateNotifier<bool> {
  final ApiService _api;

  AuthNotifier(this._api) : super(false);

  Future<bool> login(String email, String password) async {
    // VULNERABILITY: No rate limiting (fixed in Chapter 1)
    // VULNERABILITY: Storing token in SharedPreferences (fixed in Chapter 2)
    final success = await _api.login(email, password);
    if (success) state = true;
    return success;
  }

  void logout() {
    state = false;
  }
}
