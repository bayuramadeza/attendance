import 'dart:io';
import 'package:attendance/sevices/db/table/location_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db_service.g.dart';

@DriftDatabase(tables: [LocationTables])
class DbService extends _$DbService {
  DbService() : super(_openConnection());

  // if you change the table then you have to change
  // the scheme version except during development.
  // detail: https://drift.simonbinder.eu/docs/advanced-features/migrations/
  @override
  int get schemaVersion => 1;

  /// Attendece Location Method
  Future<List<LocationTable>> getAllLocation() =>
      select(locationTables).get();
  Future<void> insertLocation(List<LocationTable> data) async {
    await batch((batch) {
      // functions in a batch don't have to be awaited - just
      // await the whole batch afterwards.
      batch.insertAllOnConflictUpdate(locationTables, data);
    });
  }

  Future deleteAllLocation() => delete(locationTables).go();
  Future deleteLocation(String name) =>
      (delete(locationTables)..where((t) => t.name.equals(name))).go();

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
