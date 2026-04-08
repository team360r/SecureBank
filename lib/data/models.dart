/// SecureBank data models — GBP currency.

enum AccountType { current, savings }

enum TransactionType { credit, debit }

enum UserRole { user, admin }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? sessionToken;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.role = UserRole.user,
    this.sessionToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        role: UserRole.values.byName(json['role'] as String? ?? 'user'),
        sessionToken: json['sessionToken'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role.name,
        'sessionToken': sessionToken,
      };
}

class Account {
  final String id;
  final String name;
  final AccountType type;
  final double balance;
  final String currency;

  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    this.currency = 'GBP',
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json['id'] as String,
        name: json['name'] as String,
        type: AccountType.values.byName(json['type'] as String),
        balance: (json['balance'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'GBP',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.name,
        'balance': balance,
        'currency': currency,
      };

  String get formattedBalance => '\u00a3${balance.toStringAsFixed(2)}';
}

class Transaction {
  final String id;
  final String accountId;
  final double amount;
  final String description;
  final DateTime date;
  final TransactionType type;

  const Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.date,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'] as String,
        accountId: json['accountId'] as String,
        amount: (json['amount'] as num).toDouble(),
        description: json['description'] as String,
        date: DateTime.parse(json['date'] as String),
        type: TransactionType.values.byName(json['type'] as String),
      );

  String get formattedAmount {
    final sign = type == TransactionType.credit ? '+' : '-';
    return '$sign\u00a3${amount.toStringAsFixed(2)}';
  }
}
