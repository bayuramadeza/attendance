import 'package:drift/drift.dart';

class LocationTables extends Table {
  TextColumn get name => text()();
  RealColumn get latitide => real()();
  RealColumn get longitude => real()();

  @override
  Set<Column> get primaryKey => {name};
}