import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [AccountTable, TransactionTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<AccountTableData>> getAllAccounts() =>
      select(accountTable).get();

  Stream<List<AccountTableData>> watchAllAccounts() =>
      select(accountTable).watch();

  Future<void> insertAccount(AccountTableCompanion account) =>
      into(accountTable).insert(account, mode: InsertMode.insertOrReplace);

  Future<List<TransactionTableData>> getTransactionsForAccount(String accountId) {
    return (select(transactionTable)
          ..where((t) => t.accountId.equals(accountId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => await m.createAll(),
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'securebank.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
