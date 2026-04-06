import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models.dart';
import '../providers/accounts_provider.dart';
import '../providers/auth_provider.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _fromAccountId;
  String? _toAccountId;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleTransfer() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fromAccountId == null || _toAccountId == null) return;

    setState(() => _isSubmitting = true);

    final api = ref.read(apiServiceProvider);
    final success = await api.transfer(
      fromAccountId: _fromAccountId!,
      toAccountId: _toAccountId!,
      amount: double.parse(_amountController.text),
      note: _noteController.text.isNotEmpty ? _noteController.text : null,
    );

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer successful'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _formKey.currentState!.reset();
      _amountController.clear();
      _noteController.clear();
      setState(() {
        _fromAccountId = null;
        _toAccountId = null;
      });
      // Refresh accounts
      ref.invalidate(accountsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transfer',
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: accountsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Failed to load accounts')),
        data: (accounts) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _fromAccountId,
                  decoration: const InputDecoration(
                    labelText: 'From account',
                    prefixIcon: Icon(Icons.account_balance_outlined),
                  ),
                  items: accounts
                      .map((a) => DropdownMenuItem(
                            value: a.id,
                            child: Text('${a.name} (${a.formattedBalance})'),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _fromAccountId = value),
                  validator: (value) =>
                      value == null ? 'Select an account' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _toAccountId,
                  decoration: const InputDecoration(
                    labelText: 'To account',
                    prefixIcon: Icon(Icons.account_balance_outlined),
                  ),
                  items: accounts
                      .where((a) => a.id != _fromAccountId)
                      .map((a) => DropdownMenuItem(
                            value: a.id,
                            child: Text('${a.name} (${a.formattedBalance})'),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _toAccountId = value),
                  validator: (value) =>
                      value == null ? 'Select an account' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Icon(Icons.attach_money),
                    prefixText: '\$ ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter an amount';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Note (optional)',
                    prefixIcon: Icon(Icons.note_outlined),
                  ),
                  maxLength: 100,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _handleTransfer,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Send Transfer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
