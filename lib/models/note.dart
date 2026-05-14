import 'package:drift/drift.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get noteText => text()();
  TextColumn get noteSubText => text().withDefault(const Constant(''))();
  DateTimeColumn get timestamp =>
      dateTime().withDefault(Constant(DateTime(2000)))();
}
