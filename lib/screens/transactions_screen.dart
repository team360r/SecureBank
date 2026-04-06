import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../data/models.dart';
import '../providers/accounts_provider.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends ConsumerWidget {
  final String accountId;

  const TransactionsScreen({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountAsync = ref.watch(accountProvider(accountId));
    final transactionsAsync = ref.watch(transactionsProvider(accountId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: accountAsync.when(
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Account'),
          data: (account) => Text(account.name),
        ),
      ),
      body: Column(
        children: [
          // Account balance header
          accountAsync.when(
            loading: () => const SizedBox(height: 120),
            error: (_, __) => const SizedBox.shrink(),
            data: (account) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: theme.colorScheme.primaryContainer,
              child: Column(
                children: [
                  Text(
                    account.formattedBalance,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available balance',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Transaction list
          Expanded(
            child: transactionsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Failed to load transactions: $error'),
              ),
              data: (transactions) {
                if (transactions.isEmpty) {
                  return const Center(
                    child: Text('No transactions yet'),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return TransactionTile(
                      transaction: transactions[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
