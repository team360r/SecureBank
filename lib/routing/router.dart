import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/login_screen.dart';
import '../screens/accounts_screen.dart';
import '../screens/transactions_screen.dart';
import '../screens/transfer_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/shell_screen.dart';
import '../providers/auth_provider.dart';

/// VULNERABILITY: No role-based guards — any deep link bypasses auth (fixed in Chapter 5)
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState;
      final isOnLogin = state.matchedLocation == '/login';

      if (!isLoggedIn && !isOnLogin) return '/login';
      if (isLoggedIn && isOnLogin) return '/accounts';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/accounts',
            name: 'accounts',
            builder: (context, state) => const AccountsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'transactions',
                builder: (context, state) {
                  // VULNERABILITY: No validation of path parameter (fixed in Chapter 5)
                  final accountId = state.pathParameters['id']!;
                  return TransactionsScreen(accountId: accountId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/transfer',
            name: 'transfer',
            builder: (context, state) => const TransferScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
