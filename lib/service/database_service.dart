import 'package:dailylog/core/utils/assets_path.dart';
import 'package:get/get.dart';
import 'package:dailylog/data/database/app_database.dart';
import 'package:dailylog/data/database/db_migration.dart';

class DatabaseService extends GetxService {

  late AppDatabase database;

  Future<DatabaseService> init() async {
    database = await $FloorAppDatabase
        .databaseBuilder(AssetsPath.databasePath)
        .addMigrations(DbMigration.list())
        .build();
    return this;
  }
}