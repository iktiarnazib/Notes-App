import 'package:drift/drift.dart';

// This defines the table schema for Drift
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get noteText => text()();
}
