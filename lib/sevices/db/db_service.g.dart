// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_service.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class LocationTable extends DataClass implements Insertable<LocationTable> {
  final String name;
  final double latitide;
  final double longitude;
  LocationTable(
      {required this.name, required this.latitide, required this.longitude});
  factory LocationTable.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocationTable(
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      latitide: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitide'])!,
      longitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['latitide'] = Variable<double>(latitide);
    map['longitude'] = Variable<double>(longitude);
    return map;
  }

  LocationTablesCompanion toCompanion(bool nullToAbsent) {
    return LocationTablesCompanion(
      name: Value(name),
      latitide: Value(latitide),
      longitude: Value(longitude),
    );
  }

  factory LocationTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationTable(
      name: serializer.fromJson<String>(json['name']),
      latitide: serializer.fromJson<double>(json['latitide']),
      longitude: serializer.fromJson<double>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'latitide': serializer.toJson<double>(latitide),
      'longitude': serializer.toJson<double>(longitude),
    };
  }

  LocationTable copyWith({String? name, double? latitide, double? longitude}) =>
      LocationTable(
        name: name ?? this.name,
        latitide: latitide ?? this.latitide,
        longitude: longitude ?? this.longitude,
      );
  @override
  String toString() {
    return (StringBuffer('LocationTable(')
          ..write('name: $name, ')
          ..write('latitide: $latitide, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, latitide, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationTable &&
          other.name == this.name &&
          other.latitide == this.latitide &&
          other.longitude == this.longitude);
}

class LocationTablesCompanion extends UpdateCompanion<LocationTable> {
  final Value<String> name;
  final Value<double> latitide;
  final Value<double> longitude;
  const LocationTablesCompanion({
    this.name = const Value.absent(),
    this.latitide = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  LocationTablesCompanion.insert({
    required String name,
    required double latitide,
    required double longitude,
  })  : name = Value(name),
        latitide = Value(latitide),
        longitude = Value(longitude);
  static Insertable<LocationTable> custom({
    Expression<String>? name,
    Expression<double>? latitide,
    Expression<double>? longitude,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (latitide != null) 'latitide': latitide,
      if (longitude != null) 'longitude': longitude,
    });
  }

  LocationTablesCompanion copyWith(
      {Value<String>? name,
      Value<double>? latitide,
      Value<double>? longitude}) {
    return LocationTablesCompanion(
      name: name ?? this.name,
      latitide: latitide ?? this.latitide,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitide.present) {
      map['latitide'] = Variable<double>(latitide.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationTablesCompanion(')
          ..write('name: $name, ')
          ..write('latitide: $latitide, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $LocationTablesTable extends LocationTables
    with TableInfo<$LocationTablesTable, LocationTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationTablesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _latitideMeta = const VerificationMeta('latitide');
  @override
  late final GeneratedColumn<double?> latitide = GeneratedColumn<double?>(
      'latitide', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double?> longitude = GeneratedColumn<double?>(
      'longitude', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name, latitide, longitude];
  @override
  String get aliasedName => _alias ?? 'location_tables';
  @override
  String get actualTableName => 'location_tables';
  @override
  VerificationContext validateIntegrity(Insertable<LocationTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitide')) {
      context.handle(_latitideMeta,
          latitide.isAcceptableOrUnknown(data['latitide']!, _latitideMeta));
    } else if (isInserting) {
      context.missing(_latitideMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  LocationTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocationTable.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocationTablesTable createAlias(String alias) {
    return $LocationTablesTable(attachedDatabase, alias);
  }
}

abstract class _$DbService extends GeneratedDatabase {
  _$DbService(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LocationTablesTable locationTables = $LocationTablesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [locationTables];
}
