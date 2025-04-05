// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ElectricityDao? _electricityDaoInstance;

  GasDao? _gasDaoInstance;

  WaterPumpDao? _waterPumpDaoInstance;

  WaterAtmDao? _waterAtmDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 10,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `electricity_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `balance` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `gas_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `price` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `water_pump_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `amount` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `water_atm_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `balance` REAL NOT NULL, `water_pump_id` INTEGER, FOREIGN KEY (`water_pump_id`) REFERENCES `water_pump_logs` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ElectricityDao get electricityDao {
    return _electricityDaoInstance ??=
        _$ElectricityDao(database, changeListener);
  }

  @override
  GasDao get gasDao {
    return _gasDaoInstance ??= _$GasDao(database, changeListener);
  }

  @override
  WaterPumpDao get waterPumpDao {
    return _waterPumpDaoInstance ??= _$WaterPumpDao(database, changeListener);
  }

  @override
  WaterAtmDao get waterAtmDao {
    return _waterAtmDaoInstance ??= _$WaterAtmDao(database, changeListener);
  }
}

class _$ElectricityDao extends ElectricityDao {
  _$ElectricityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _electricityEntityInsertionAdapter = InsertionAdapter(
            database,
            'electricity_logs',
            (ElectricityEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'balance': item.balance
                }),
        _electricityEntityUpdateAdapter = UpdateAdapter(
            database,
            'electricity_logs',
            ['id'],
            (ElectricityEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'balance': item.balance
                }),
        _electricityEntityDeletionAdapter = DeletionAdapter(
            database,
            'electricity_logs',
            ['id'],
            (ElectricityEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'balance': item.balance
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ElectricityEntity> _electricityEntityInsertionAdapter;

  final UpdateAdapter<ElectricityEntity> _electricityEntityUpdateAdapter;

  final DeletionAdapter<ElectricityEntity> _electricityEntityDeletionAdapter;

  @override
  Future<List<ElectricityEntity>> getAllLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM electricity_logs ORDER BY createdAt DESC LIMIT 20',
        mapper: (Map<String, Object?> row) => ElectricityEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            balance: row['balance'] as double));
  }

  @override
  Future<ElectricityEntity?> getLogById(int id) async {
    return _queryAdapter.query('SELECT * FROM electricity_logs WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ElectricityEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            balance: row['balance'] as double),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllLogs() async {
    await _queryAdapter.queryNoReturn('DELETE FROM electricity_logs');
  }

  @override
  Future<List<ElectricityEntity>> getLastLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM electricity_logs ORDER BY createdAt DESC LIMIT 3',
        mapper: (Map<String, Object?> row) => ElectricityEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            balance: row['balance'] as double));
  }

  @override
  Future<void> deleteLogById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM electricity_logs WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertLog(ElectricityEntity entity) {
    return _electricityEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLog(ElectricityEntity entity) async {
    await _electricityEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLog(ElectricityEntity entity) async {
    await _electricityEntityDeletionAdapter.delete(entity);
  }
}

class _$GasDao extends GasDao {
  _$GasDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _gasEntityInsertionAdapter = InsertionAdapter(
            database,
            'gas_logs',
            (GasEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'price': item.price
                }),
        _gasEntityUpdateAdapter = UpdateAdapter(
            database,
            'gas_logs',
            ['id'],
            (GasEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'price': item.price
                }),
        _gasEntityDeletionAdapter = DeletionAdapter(
            database,
            'gas_logs',
            ['id'],
            (GasEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'price': item.price
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GasEntity> _gasEntityInsertionAdapter;

  final UpdateAdapter<GasEntity> _gasEntityUpdateAdapter;

  final DeletionAdapter<GasEntity> _gasEntityDeletionAdapter;

  @override
  Future<List<GasEntity>> getAllLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM gas_logs ORDER BY createdAt DESC LIMIT 20',
        mapper: (Map<String, Object?> row) => GasEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            price: row['price'] as double));
  }

  @override
  Future<GasEntity?> getLogById(int id) async {
    return _queryAdapter.query('SELECT * FROM gas_logs WHERE id = ?1',
        mapper: (Map<String, Object?> row) => GasEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            price: row['price'] as double),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllLogs() async {
    await _queryAdapter.queryNoReturn('DELETE FROM gas_logs');
  }

  @override
  Future<void> deleteLogById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM gas_logs WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<List<GasEntity>> getLastTwoLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM gas_logs ORDER BY createdAt DESC LIMIT 2',
        mapper: (Map<String, Object?> row) => GasEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            price: row['price'] as double));
  }

  @override
  Future<int> insertLog(GasEntity entity) {
    return _gasEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLog(GasEntity entity) async {
    await _gasEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLog(GasEntity entity) async {
    await _gasEntityDeletionAdapter.delete(entity);
  }
}

class _$WaterPumpDao extends WaterPumpDao {
  _$WaterPumpDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _waterPumpEntityInsertionAdapter = InsertionAdapter(
            database,
            'water_pump_logs',
            (WaterPumpEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'amount': item.amount
                }),
        _waterPumpEntityUpdateAdapter = UpdateAdapter(
            database,
            'water_pump_logs',
            ['id'],
            (WaterPumpEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'amount': item.amount
                }),
        _waterPumpEntityDeletionAdapter = DeletionAdapter(
            database,
            'water_pump_logs',
            ['id'],
            (WaterPumpEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'amount': item.amount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WaterPumpEntity> _waterPumpEntityInsertionAdapter;

  final UpdateAdapter<WaterPumpEntity> _waterPumpEntityUpdateAdapter;

  final DeletionAdapter<WaterPumpEntity> _waterPumpEntityDeletionAdapter;

  @override
  Future<List<WaterPumpEntity>> getAllLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM water_pump_logs ORDER BY createdAt DESC LIMIT 20',
        mapper: (Map<String, Object?> row) => WaterPumpEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            amount: row['amount'] as double));
  }

  @override
  Future<WaterPumpEntity?> getLogById(int id) async {
    return _queryAdapter.query('SELECT * FROM water_pump_logs WHERE id = ?1',
        mapper: (Map<String, Object?> row) => WaterPumpEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            amount: row['amount'] as double),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllLogs() async {
    await _queryAdapter.queryNoReturn('DELETE FROM water_pump_logs');
  }

  @override
  Future<void> deleteLogById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM water_pump_logs WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<List<WaterPumpEntity>> getLastTwoLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM water_pump_logs ORDER BY createdAt DESC LIMIT 2',
        mapper: (Map<String, Object?> row) => WaterPumpEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            amount: row['amount'] as double));
  }

  @override
  Future<int> insertLog(WaterPumpEntity entity) {
    return _waterPumpEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLog(WaterPumpEntity entity) async {
    await _waterPumpEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLog(WaterPumpEntity entity) async {
    await _waterPumpEntityDeletionAdapter.delete(entity);
  }
}

class _$WaterAtmDao extends WaterAtmDao {
  _$WaterAtmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _waterAtmEntityInsertionAdapter = InsertionAdapter(
            database,
            'water_atm_logs',
            (WaterAtmEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'balance': item.balance,
                  'water_pump_id': item.waterPumpId
                }),
        _waterAtmEntityUpdateAdapter = UpdateAdapter(
            database,
            'water_atm_logs',
            ['id'],
            (WaterAtmEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'balance': item.balance,
                  'water_pump_id': item.waterPumpId
                }),
        _waterAtmEntityDeletionAdapter = DeletionAdapter(
            database,
            'water_atm_logs',
            ['id'],
            (WaterAtmEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'balance': item.balance,
                  'water_pump_id': item.waterPumpId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WaterAtmEntity> _waterAtmEntityInsertionAdapter;

  final UpdateAdapter<WaterAtmEntity> _waterAtmEntityUpdateAdapter;

  final DeletionAdapter<WaterAtmEntity> _waterAtmEntityDeletionAdapter;

  @override
  Future<List<WaterAtmEntity>> getAllLogs() async {
    return _queryAdapter.queryList(
        'SELECT * FROM water_atm_logs ORDER BY createdAt DESC LIMIT 20',
        mapper: (Map<String, Object?> row) => WaterAtmEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            balance: row['balance'] as double,
            waterPumpId: row['water_pump_id'] as int?));
  }

  @override
  Future<WaterAtmEntity?> getLogById(int id) async {
    return _queryAdapter.query('SELECT * FROM water_atm_logs WHERE id = ?1',
        mapper: (Map<String, Object?> row) => WaterAtmEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            balance: row['balance'] as double,
            waterPumpId: row['water_pump_id'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllLogs() async {
    await _queryAdapter.queryNoReturn('DELETE FROM water_atm_logs');
  }

  @override
  Future<void> deleteLogById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM water_atm_logs WHERE water_pump_id = ?1',
        arguments: [id]);
  }

  @override
  Future<WaterAtmEntity?> getLastBalance() async {
    return _queryAdapter.query(
        'SELECT * FROM water_atm_logs ORDER BY createdAt DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => WaterAtmEntity(
            id: row['id'] as int?,
            createdAt: row['createdAt'] as String,
            balance: row['balance'] as double,
            waterPumpId: row['water_pump_id'] as int?));
  }

  @override
  Future<int> insertLog(WaterAtmEntity entity) {
    return _waterAtmEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLog(WaterAtmEntity entity) async {
    await _waterAtmEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLog(WaterAtmEntity entity) async {
    await _waterAtmEntityDeletionAdapter.delete(entity);
  }
}
