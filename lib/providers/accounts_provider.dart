import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models.dart';
import 'auth_provider.dart';

final accountsProvider = FutureProvider<List<Account>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getAccounts();
});

final transactionsProvider =
    FutureProvider.family<List<Transaction>, String>((ref, accountId) async {
  final api = ref.read(apiServiceProvider);
  return api.getTransactions(accountId);
});

final accountProvider =
    FutureProvider.family<Account, String>((ref, accountId) async {
  final api = ref.read(apiServiceProvider);
  return api.getAccount(accountId);
});
