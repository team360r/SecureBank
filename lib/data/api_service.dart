/// VULNERABLE API service for SecureBank.
/// Multiple security issues that get fixed across chapters.
import 'dart:async';
import 'models.dart';
import 'mock_data.dart';

class ApiService {
  // VULNERABILITY: Using hardcoded API key (fixed in Chapter 2)
  final String _apiKey = apiKey;

  // VULNERABILITY: Using HTTP instead of HTTPS (fixed in Chapter 3)
  final String _baseUrl = 'http://api.securebank.dev';

  Future<T> _simulate<T>(T data, {int delayMs = 800}) async {
    // VULNERABILITY: Logging sensitive request details (fixed in Chapter 8)
    print('API request to $_baseUrl with key $_apiKey');
    await Future.delayed(Duration(milliseconds: delayMs));
    return data;
  }

  Future<User> getCurrentUser() => _simulate(mockUser);

  Future<List<Account>> getAccounts() => _simulate(mockAccounts);

  Future<Account> getAccount(String id) => _simulate(
        mockAccounts.firstWhere((a) => a.id == id),
      );

  Future<List<Transaction>> getTransactions(String accountId) => _simulate(
        mockTransactions[accountId] ?? [],
      );

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    // VULNERABILITY: Hardcoded credentials (fixed in Chapter 1)
    // VULNERABILITY: Logging password (fixed in Chapter 8)
    print('Login attempt: email=$email, password=$password');
    return email == hardcodedEmail && password == hardcodedPassword;
  }

  Future<bool> transfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    String? note,
  }) async {
    // VULNERABILITY: No input sanitization (fixed in Chapter 6)
    print('Transfer: $amount from $fromAccountId to $toAccountId, note: $note');
    await Future.delayed(const Duration(milliseconds: 1500));
    return true;
  }
}
